import os
import re
import json
import shutil
from PIL import Image

"""
Bulk Creator Image Import & Processing CLI
Supports mapping:
  - directory_id -> filename (e.g. dir_2bcf68d0bbd6.jpg) [Preferred]
  - instagram_handle -> filename (e.g. shrutzhaasan.png) [Secondary]

Generates:
  - Matched images
  - Unmatched images
  - Duplicate images
  - Unsupported files
  - Failed uploads
"""

SUPPORTED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.webp'}
MAX_AVATAR_DIM = 512

def process_bulk_images(
    input_folder: str,
    manifest_path: str,
    output_storage_folder: str,
    report_output_path: str
):
    if not os.path.exists(manifest_path):
        print(f"Manifest not found: {manifest_path}")
        return

    with open(manifest_path, 'r', encoding='utf-8') as f:
        manifest = json.load(f)

    entries = manifest.get('entries', [])
    dir_id_map = {e['directory_id']: e for e in entries}
    handle_map = {e['instagram_handle'].lower(): e for e in entries if e.get('instagram_handle')}

    matched = []
    unmatched = []
    duplicates = []
    unsupported = []
    failed = []

    seen_ids = set()
    os.makedirs(output_storage_folder, exist_ok=True)

    for fname in os.listdir(input_folder):
        fpath = os.path.join(input_folder, fname)
        if os.path.isdir(fpath):
            continue

        base_name, ext = os.path.splitext(fname)
        ext_lower = ext.lower()

        if ext_lower not in SUPPORTED_EXTENSIONS:
            unsupported.append({"filename": fname, "reason": f"Unsupported extension {ext}"})
            continue

        # Clean base name (strip avatar, profile, etc.)
        cleaned_key = re.sub(r'(_avatar|_profile|_photo)$', '', base_name.lower().strip())

        matched_entry = None
        match_type = None

        if cleaned_key in dir_id_map:
            matched_entry = dir_id_map[cleaned_key]
            match_type = "directory_id"
        elif cleaned_key in handle_map:
            matched_entry = handle_map[cleaned_key]
            match_type = "instagram_handle"

        if not matched_entry:
            unmatched.append({"filename": fname, "parsed_key": cleaned_key})
            continue

        target_id = matched_entry['directory_id']
        if target_id in seen_ids:
            duplicates.append({"filename": fname, "directory_id": target_id, "matched_entry": matched_entry['display_name']})
            continue

        seen_ids.add(target_id)

        # Process and optimize image
        dest_filename = f"{target_id}.webp"
        dest_path = os.path.join(output_storage_folder, dest_filename)

        try:
            with Image.open(fpath) as img:
                # Convert RGBA/P to RGB if saving WebP/JPEG
                if img.mode in ('RGBA', 'LA') and ext_lower != '.png':
                    background = Image.new('RGB', img.size, (255, 255, 255))
                    background.paste(img, mask=img.split()[-1])
                    img = background
                elif img.mode != 'RGB':
                    img = img.convert('RGB')

                # Thumbnail preserving aspect ratio without distortion
                img.thumbnail((MAX_AVATAR_DIM, MAX_AVATAR_DIM), Image.Resampling.LANCZOS)
                img.save(dest_path, "WEBP", quality=85, method=6)

            matched_entry['current_image_path'] = dest_path
            matched_entry['status'] = 'uploaded'

            matched.append({
                "filename": fname,
                "directory_id": target_id,
                "display_name": matched_entry['display_name'],
                "match_type": match_type,
                "stored_path": dest_path
            })
        except Exception as e:
            failed.append({"filename": fname, "error": str(e)})

    # Update manifest
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    report = {
        "summary": {
            "total_files_scanned": len(os.listdir(input_folder)),
            "matched_count": len(matched),
            "unmatched_count": len(unmatched),
            "duplicate_count": len(duplicates),
            "unsupported_count": len(unsupported),
            "failed_count": len(failed)
        },
        "matched": matched,
        "unmatched": unmatched,
        "duplicates": duplicates,
        "unsupported": unsupported,
        "failed": failed
    }

    with open(report_output_path, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2, ensure_ascii=False)

    print("Image Bulk Ingest Complete:")
    print(f"  Matched: {len(matched)}")
    print(f"  Unmatched: {len(unmatched)}")
    print(f"  Duplicates: {len(duplicates)}")
    print(f"  Unsupported: {len(unsupported)}")
    print(f"  Failed: {len(failed)}")
    print(f"Report saved to: {report_output_path}")

if __name__ == '__main__':
    import sys
    print("Bulk image import utility ready.")

