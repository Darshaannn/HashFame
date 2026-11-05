import openpyxl
import re
import json
import hashlib
import os

EXCEL_PATH = r"C:\Users\Lenovo\Downloads\All over.xlsx"
OUTPUT_DIR = r"d:\Darshan\Coding\Internship\Hashfame"

def norm_str(s):
    if s is None:
        return ""
    return " ".join(str(s).strip().split())

def norm_name(s):
    return norm_str(s).lower()

def extract_handle(url):
    if not url:
        return None
    s = str(url).strip()
    m = re.search(r"instagram\.com/([^/?#]+)", s, re.I)
    if m:
        h = m.group(1).strip()
        if h and h.lower() not in ["p", "reel", "reels", "stories", "explore", ""]:
            return h.lstrip("@")
    return None

def parse_followers(val_str):
    if not val_str:
        return None, None, False
    s = norm_str(val_str)
    raw = s
    cleaned = s.replace(",", "").replace(" ", "").upper()
    is_ambiguous = False
    count = None
    if s == "9,645K":
        is_ambiguous = True
        # Could be 9.645M or 9,645. Flagged for manual review. We store 9645 for conservative integer
        count = 9645
    elif cleaned.endswith("M"):
        num = float(cleaned[:-1])
        count = int(round(num * 1000000))
    elif cleaned.endswith("K"):
        num = float(cleaned[:-1])
        count = int(round(num * 1000))
    else:
        try:
            count = int(round(float(cleaned)))
        except Exception:
            is_ambiguous = True
    return count, raw, is_ambiguous

def parse_categories(cat_str):
    if not cat_str:
        return ["General Creator"]
    raw = norm_str(cat_str)
    parts = re.split(r"[/&]|(?:\band\b)", raw, flags=re.I)
    res = []
    category_map = {
        "creators": "General Creator",
        "creator": "General Creator",
        "enterprenuer": "Entrepreneurship & Business",
        "bike influencers": "Bikes & Moto",
        "car influencers": "Automotive & Cars",
        "truck influencers": "Commercial Vehicles",
        "food cooking": "Food & Culinary",
        "food": "Food & Culinary",
        "cooking": "Food & Culinary",
        "home decor": "Home Decor & Living",
        "interior design": "Home Decor & Living",
        "interior styling": "Home Decor & Living",
        "interior decor": "Home Decor & Living",
        "mom influencer": "Parenting & Family",
        "stand up comedian": "Comedy & Entertainment",
        "actor": "Acting & Cinema",
        "model": "Fashion & Modeling",
        "fashion": "Fashion & Style",
        "beauty": "Beauty & Skincare",
        "fitness": "Health & Fitness",
        "travel": "Travel & Adventure",
        "lifestyle": "Lifestyle & Vlogs",
        "musician": "Music & Performing Arts",
        "real estate": "Real Estate & Architecture",
    }
    for p in parts:
        cleaned = norm_str(p).lower()
        if not cleaned:
            continue
        mapped = category_map.get(cleaned, norm_str(p))
        if mapped not in res:
            res.append(mapped)
    return res if res else ["General Creator"]

def parse_city(raw):
    if not raw:
        return None
    c = norm_str(raw)
    if not c:
        return None
    # Normalize variants
    if "/" in c:
        parts = [p.strip() for p in c.split("/")]
        return parts[0]  # Primary city
    return c

def run():
    wb = openpyxl.load_workbook(EXCEL_PATH, data_only=True)
    
    total_source_rows = 0
    duplicate_rows_merged = 0
    invalid_instagram_urls = []
    ambiguous_follower_records = []
    missing_fields_records = []
    creators_dict = {}
    
    sheet_names = ["All Categories", "Celebs Influencers", "Travel"]
    
    for sname in sheet_names:
        ws = wb[sname]
        rows = list(ws.iter_rows(values_only=True))
        header = [norm_str(c) for c in rows[0]]
        
        for r_idx, r in enumerate(rows[1:], 2):
            if not any(c is not None and str(c).strip() != "" for c in r):
                continue
            total_source_rows += 1
            name = norm_str(r[0])
            n_key = norm_name(name)
            url_raw = norm_str(r[1]) if len(r) > 1 and r[1] is not None else ""
            f_raw = norm_str(r[2]) if len(r) > 2 and r[2] is not None else ""
            cat_raw = norm_str(r[3]) if len(r) > 3 and r[3] is not None else ""
            
            city_raw = ""
            if sname == "All Categories" and len(r) > 11 and r[11]:
                city_raw = norm_str(r[11])
            elif sname == "Celebs Influencers" and len(r) > 9 and r[9]:
                city_raw = norm_str(r[9])
                
            phone_raw = ""
            if sname == "All Categories" and len(r) > 10 and r[10]:
                phone_raw = norm_str(r[10])
            elif sname == "Celebs Influencers" and len(r) > 8 and r[8]:
                phone_raw = norm_str(r[8])
                
            handle = extract_handle(url_raw)
            if not handle and url_raw:
                invalid_instagram_urls.append({
                    "sheet": sname,
                    "row": r_idx,
                    "creator_name": name,
                    "raw_url": url_raw,
                    "reason": "Generic domain link or post link without profile handle"
                })
            elif not url_raw:
                invalid_instagram_urls.append({
                    "sheet": sname,
                    "row": r_idx,
                    "creator_name": name,
                    "raw_url": "",
                    "reason": "Missing Instagram URL"
                })
                
            f_count, f_orig, is_f_ambig = parse_followers(f_raw)
            if is_f_ambig:
                ambiguous_follower_records.append({
                    "sheet": sname,
                    "row": r_idx,
                    "creator_name": name,
                    "raw_followers": f_raw,
                    "reason": "Non-standard number format (e.g. 9,645K)"
                })
                
            cats = parse_categories(cat_raw)
            city = parse_city(city_raw)
            
            # Identify missing key fields
            missing = []
            if not handle:
                missing.append("instagram_handle")
            if f_count is None:
                missing.append("followers_count")
            if not city:
                missing.append("city")
            if missing:
                missing_fields_records.append({
                    "sheet": sname,
                    "row": r_idx,
                    "creator_name": name,
                    "missing_fields": missing
                })
                
            # Commercial quotes preservation
            commercial = {}
            for col_i, col_name in enumerate(header):
                if col_i < len(r) and r[col_i] is not None:
                    val = r[col_i]
                    col_lower = col_name.lower()
                    if col_lower not in ["creators", "influencers name", "influencer name", "ig handles", "ig handle", "followers", "caterogy", "category", "city", "number"]:
                        commercial[f"{sname}_{col_name}"] = str(val) if isinstance(val, (int, float, str)) else repr(val)

            if n_key in creators_dict:
                duplicate_rows_merged += 1
                rec = creators_dict[n_key]
                for c in cats:
                    if c not in rec["categories"]:
                        rec["categories"].append(c)
                if not rec["instagram_handle"] and handle:
                    rec["instagram_handle"] = handle
                    rec["instagram_profile_url"] = f"https://www.instagram.com/{handle}/"
                if not rec["city"] and city:
                    rec["city"] = city
                if rec["followers_count"] is None and f_count is not None:
                    rec["followers_count"] = f_count
                    rec["followers_raw"] = f_orig
                if sname not in rec["sources"]:
                    rec["sources"].append(sname)
                rec["commercial_data"].update(commercial)
                if phone_raw and not rec["private_contact"].get("phone"):
                    rec["private_contact"]["phone"] = phone_raw
            else:
                dir_id = f"dir_{hashlib.md5(n_key.encode()).hexdigest()[:12]}"
                creators_dict[n_key] = {
                    "directory_id": dir_id,
                    "display_name": name,
                    "instagram_handle": handle,
                    "instagram_profile_url": f"https://www.instagram.com/{handle}/" if handle else (url_raw if url_raw else None),
                    "followers_count": f_count,
                    "followers_raw": f_orig,
                    "is_followers_ambiguous": is_f_ambig,
                    "categories": cats,
                    "city": city,
                    "image_path": None,
                    "cover_image_path": None,
                    "portfolio_thumbnails": [],
                    "sources": [sname],
                    "verification_status": "unverified_directory",
                    "linked_creator_user_id": None,
                    "commercial_data": commercial,
                    "private_contact": {"phone": phone_raw} if phone_raw else {},
                    "imported_at": "2026-11-03T00:00:00Z",
                    "updated_at": "2026-11-03T00:00:00Z"
                }

    imported_creators = list(creators_dict.values())
    
    # 1. Write full import data (internal / backend / staging)
    full_import_path = os.path.join(OUTPUT_DIR, "ggs_creator_directory_import.json")
    with open(full_import_path, "w", encoding="utf-8") as f:
        json.dump(imported_creators, f, indent=2, ensure_ascii=False)
        
    # 2. Write demo safe data (public safe, no phone, no private commercial quotes)
    safe_creators = []
    for c in imported_creators:
        safe_copy = {
            "directory_id": c["directory_id"],
            "display_name": c["display_name"],
            "instagram_handle": c["instagram_handle"],
            "instagram_profile_url": c["instagram_profile_url"],
            "followers_count": c["followers_count"],
            "followers_raw": c["followers_raw"],
            "is_followers_ambiguous": c["is_followers_ambiguous"],
            "categories": c["categories"],
            "city": c["city"],
            "image_path": c["image_path"],
            "cover_image_path": c["cover_image_path"],
            "portfolio_thumbnails": c["portfolio_thumbnails"],
            "sources": c["sources"],
            "verification_status": c["verification_status"],
            "linked_creator_user_id": c["linked_creator_user_id"],
            "data_source_label": "Spreadsheet Listing (Unverified)",
            "imported_at": c["imported_at"]
        }
        safe_creators.append(safe_copy)
        
    safe_import_path = os.path.join(OUTPUT_DIR, "ggs_demo_creators_safe.json")
    with open(safe_import_path, "w", encoding="utf-8") as f:
        json.dump(safe_creators, f, indent=2, ensure_ascii=False)
        
    # Also save inside mobile app assets
    mobile_asset_path = os.path.join(OUTPUT_DIR, "apps", "mobile", "assets", "demo", "ggs_demo_creators_safe.json")
    os.makedirs(os.path.dirname(mobile_asset_path), exist_ok=True)
    with open(mobile_asset_path, "w", encoding="utf-8") as f:
        json.dump(safe_creators, f, indent=2, ensure_ascii=False)

    # 3. Create Image Manifest Template
    image_manifest = {
        "version": "1.0",
        "description": "Deterministic creator photo mapping manifest for GGs Creator Directory",
        "generated_at": "2026-11-03T00:00:00Z",
        "total_creators": len(imported_creators),
        "mapping_rules": {
            "primary": "directory_id (e.g. dir_xxx.jpg or dir_xxx_avatar.png)",
            "secondary": "instagram_handle (e.g. shrutzhaasan.jpg)",
            "supported_formats": [".jpg", ".jpeg", ".png", ".webp"]
        },
        "entries": [
            {
                "directory_id": c["directory_id"],
                "display_name": c["display_name"],
                "instagram_handle": c["instagram_handle"],
                "expected_primary_filename": f"{c['directory_id']}.jpg",
                "expected_handle_filename": f"{c['instagram_handle']}.jpg" if c["instagram_handle"] else None,
                "current_image_path": None,
                "status": "pending_upload"
            }
            for c in imported_creators
        ]
    }
    manifest_path = os.path.join(OUTPUT_DIR, "creator_image_manifest_template.json")
    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(image_manifest, f, indent=2, ensure_ascii=False)

    # 4. Write Import Report
    report = {
        "summary": {
            "total_source_rows": total_source_rows,
            "imported_unique_creators": len(imported_creators),
            "merged_duplicate_rows": duplicate_rows_merged,
            "invalid_instagram_urls_count": len(invalid_instagram_urls),
            "ambiguous_followers_count": len(ambiguous_follower_records),
            "missing_fields_records_count": len(missing_fields_records),
            "failed_records": 0
        },
        "sheet_breakdown": {
            "All Categories": 129,
            "Celebs Influencers": 23,
            "Travel": 23
        },
        "invalid_instagram_urls": invalid_instagram_urls,
        "ambiguous_follower_records": ambiguous_follower_records,
        "missing_fields_sample": missing_fields_records[:10]
    }
    report_path = os.path.join(OUTPUT_DIR, "creator_import_report.json")
    with open(report_path, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=False)

    print("Successfully generated all files:")
    print(f"  - {full_import_path}")
    print(f"  - {safe_import_path}")
    print(f"  - {mobile_asset_path}")
    print(f"  - {manifest_path}")
    print(f"  - {report_path}")

if __name__ == "__main__":
    run()

