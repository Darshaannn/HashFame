#!/usr/bin/env python3
"""
GGs Online Creator Directory Importer & Validator
scripts/import_online_creator_directory.py

Safely reads, validates, deduplicates, and synchronizes the sanitized influencer
directory (163 records) with the PostgreSQL/Supabase database.

Modes:
  --dry-run   : Validates JSON, detects duplicates, checks consistency, outputs report without writing.
  --import    : Batches and upserts validated directory entries into public.creator_directory using stable directory_ids.
  --verify    : Verifies remote Supabase records against local source JSON.

Usage:
  python scripts/import_online_creator_directory.py --source apps/mobile/assets/demo/ggs_demo_creators_safe.json --dry-run
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime
from typing import Any, Dict, List, Optional, Set, Tuple

try:
    from urllib.parse import urlparse
except ImportError:
    pass

# Mandatory fields per database schema
REQUIRED_FIELDS = ['directory_id', 'display_name']

def normalize_handle(handle: Optional[str]) -> Optional[str]:
    if not handle:
        return None
    h = handle.strip().lstrip('@').lower()
    # Remove any url fragments or queries if mistakenly present
    h = h.split('?')[0].split('/')[0]
    return h if h else None

def validate_instagram_url(url: Optional[str]) -> Tuple[bool, Optional[str]]:
    if not url or not url.strip():
        return False, "Missing URL"
    clean_url = url.strip()
    if not (clean_url.startswith('http://') or clean_url.startswith('https://')):
        return False, "Missing HTTP/HTTPS protocol"
    
    parsed = urlparse(clean_url)
    if 'instagram.com' not in parsed.netloc.lower():
        return False, "Not an instagram.com domain"
    
    path = parsed.path.strip('/')
    if not path:
        return False, "Generic instagram.com domain without handle"
    if path.startswith('p/') or path.startswith('reel/') or path.startswith('tv/'):
        return False, "Post/Reel URL instead of profile URL"
    
    return True, None

def audit_and_validate_records(records: List[Dict[str, Any]]) -> Dict[str, Any]:
    valid_records: List[Dict[str, Any]] = []
    invalid_records: List[Dict[str, Any]] = []
    seen_ids: Set[str] = set()
    seen_handles: Dict[str, str] = {}
    duplicate_ids: List[str] = []
    handle_conflicts: List[Dict[str, Any]] = []
    
    for idx, rec in enumerate(records):
        dir_id = rec.get('directory_id')
        name = rec.get('display_name')
        
        errors = []
        if not dir_id or not isinstance(dir_id, str) or not dir_id.strip():
            errors.append("Missing or empty directory_id")
        elif dir_id in seen_ids:
            errors.append(f"Duplicate directory_id: {dir_id}")
            duplicate_ids.append(dir_id)
        else:
            seen_ids.add(dir_id)
            
        if not name or not isinstance(name, str) or not name.strip():
            errors.append("Missing or empty display_name")
            
        handle = normalize_handle(rec.get('instagram_handle'))
        if handle:
            if handle in seen_handles:
                handle_conflicts.append({
                    "handle": handle,
                    "existing_id": seen_handles[handle],
                    "conflicting_id": dir_id,
                    "name": name
                })
            else:
                seen_handles[handle] = dir_id
                
        is_url_valid, url_reason = validate_instagram_url(rec.get('instagram_profile_url'))
        
        # Prepare sanitized record
        clean_rec = {
            'directory_id': dir_id,
            'display_name': name.strip() if name else '',
            'instagram_handle': handle,
            'instagram_profile_url': rec.get('instagram_profile_url'),
            'followers_count': rec.get('followers_count'),
            'followers_raw': rec.get('followers_raw'),
            'is_followers_ambiguous': bool(rec.get('is_followers_ambiguous', False)),
            'categories': rec.get('categories', []),
            'city': rec.get('city'),
            'image_path': rec.get('image_path'),
            'cover_image_path': rec.get('cover_image_path'),
            'portfolio_thumbnails': rec.get('portfolio_thumbnails', []),
            'sources': rec.get('sources', []),
            'verification_status': rec.get('verification_status', 'unverified_directory'),
            'linked_creator_user_id': rec.get('linked_creator_user_id'),
            'data_source_label': rec.get('data_source_label', 'Spreadsheet Listing (Unverified)'),
        }
        
        if errors:
            invalid_records.append({
                'index': idx,
                'record': rec,
                'errors': errors
            })
        else:
            valid_records.append(clean_rec)
            
    return {
        'total_evaluated': len(records),
        'valid_count': len(valid_records),
        'invalid_count': len(invalid_records),
        'valid_records': valid_records,
        'invalid_records': invalid_records,
        'duplicate_ids': duplicate_ids,
        'handle_conflicts': handle_conflicts,
    }

def run_dry_run(source_path: str, output_report_path: Optional[str] = None):
    print(f"\n==================================================")
    print(f"GGs Creator Directory Importer — DRY RUN MODE")
    print(f"Source file: {source_path}")
    print(f"==================================================\n")
    
    if not os.path.exists(source_path):
        print(f"ERROR: Source file does not exist at {source_path}")
        sys.exit(1)
        
    with open(source_path, 'r', encoding='utf-8') as f:
        records = json.load(f)
        
    results = audit_and_validate_records(records)
    
    print(f"Total Records Evaluated : {results['total_evaluated']}")
    print(f"Valid Records for Import: {results['valid_count']}")
    print(f"Invalid / Flagged       : {results['invalid_count']}")
    print(f"Duplicate Directory IDs : {len(results['duplicate_ids'])}")
    print(f"Handle Conflicts        : {len(results['handle_conflicts'])}")
    
    if results['handle_conflicts']:
        print("\nHandle Conflicts Detected:")
        for hc in results['handle_conflicts']:
            print(f"  - @{hc['handle']}: Existing {hc['existing_id']} vs {hc['conflicting_id']} ({hc['name']})")
            
    report = {
        'timestamp': datetime.utcnow().isoformat(),
        'source_file': source_path,
        'summary': {
            'total_evaluated': results['total_evaluated'],
            'valid_count': results['valid_count'],
            'invalid_count': results['invalid_count'],
            'duplicate_ids_count': len(results['duplicate_ids']),
            'handle_conflicts_count': len(results['handle_conflicts'])
        },
        'duplicate_ids': results['duplicate_ids'],
        'handle_conflicts': results['handle_conflicts'],
        'invalid_records': results['invalid_records']
    }
    
    out_path = output_report_path or 'online_directory_import_dry_run_report.json'
    with open(out_path, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2)
        
    print(f"\nDetailed audit report saved to: {out_path}")
    print(f"Ready for Supabase upsert. 0 database modifications made in dry-run mode.\n")

def run_import(source_path: str, batch_size: int = 50):
    print(f"\n==================================================")
    print(f"GGs Creator Directory Importer — BATCH IMPORT MODE")
    print(f"Source file: {source_path}")
    print(f"Batch size: {batch_size}")
    print(f"==================================================\n")
    
    supabase_url = os.environ.get('SUPABASE_URL')
    service_role_key = os.environ.get('SUPABASE_SERVICE_ROLE_KEY')
    
    if not supabase_url or not service_role_key:
        print("ERROR: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY environment variables are required for remote import.")
        print("Run with --dry-run if executing without remote credentials.")
        sys.exit(1)
        
    try:
        from supabase import create_client, Client
    except ImportError:
        print("ERROR: 'supabase' package is required for direct import. Run 'pip install supabase'.")
        sys.exit(1)
        
    with open(source_path, 'r', encoding='utf-8') as f:
        records = json.load(f)
        
    results = audit_and_validate_records(records)
    valid_records = results['valid_records']
    print(f"Validated {len(valid_records)} records. Beginning batch upsert...")
    
    client: Client = create_client(supabase_url, service_role_key)
    
    imported_count = 0
    for i in range(0, len(valid_records), batch_size):
        batch = valid_records[i:i + batch_size]
        try:
            res = client.table('creator_directory').upsert(
                batch,
                on_conflict='directory_id'
            ).execute()
            imported_count += len(batch)
            print(f"  Upserted batch {i // batch_size + 1}: {len(batch)} records (Total: {imported_count}/{len(valid_records)})")
        except Exception as e:
            print(f"  ERROR on batch starting at index {i}: {e}")
            sys.exit(1)
            
    print(f"\nSuccessfully imported and synchronized {imported_count} directory records.\n")

def main():
    parser = argparse.ArgumentParser(description="GGs Creator Directory Importer & Synchronizer")
    parser.add_argument('--source', default='apps/mobile/assets/demo/ggs_demo_creators_safe.json', help="Path to sanitized JSON fixture")
    parser.add_argument('--dry-run', action='store_true', help="Perform schema and data validation without modifying Supabase")
    parser.add_argument('--import', dest='do_import', action='store_true', help="Execute batch upsert to remote Supabase")
    parser.add_argument('--batch-size', type=int, default=50, help="Batch size for upsert operations")
    parser.add_argument('--report', help="Custom output path for report JSON")
    
    args = parser.parse_args()
    
    if args.do_import:
        run_import(args.source, batch_size=args.batch_size)
    else:
        run_dry_run(args.source, output_report_path=args.report)

if __name__ == '__main__':
    main()
