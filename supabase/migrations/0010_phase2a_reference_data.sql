-- Phase 2A: Reference Data Seeding
-- 0010_phase2a_reference_data.sql

-- Normalized Categories & Subcategories
insert into public.categories (id, parent_id, name, slug, sort_order) values
  ('c0000001-0000-0000-0000-000000000001', null, 'Fashion', 'fashion', 1),
  ('c0000001-0000-0000-0000-000000000002', 'c0000001-0000-0000-0000-000000000001', 'Streetwear', 'streetwear', 1),
  ('c0000001-0000-0000-0000-000000000003', 'c0000001-0000-0000-0000-000000000001', 'Luxury Fashion', 'luxury-fashion', 2),
  ('c0000001-0000-0000-0000-000000000004', 'c0000001-0000-0000-0000-000000000001', 'Men''s Fashion', 'mens-fashion', 3),
  ('c0000001-0000-0000-0000-000000000005', 'c0000001-0000-0000-0000-000000000001', 'Ethnic & Traditional', 'ethnic-traditional', 4),

  ('c0000002-0000-0000-0000-000000000001', null, 'Beauty & Skincare', 'beauty-skincare', 2),
  ('c0000002-0000-0000-0000-000000000002', 'c0000002-0000-0000-0000-000000000001', 'Skincare', 'skincare', 1),
  ('c0000002-0000-0000-0000-000000000003', 'c0000002-0000-0000-0000-000000000001', 'Makeup Tutorials', 'makeup-tutorials', 2),
  ('c0000002-0000-0000-0000-000000000004', 'c0000002-0000-0000-0000-000000000001', 'Haircare', 'haircare', 3),

  ('c0000003-0000-0000-0000-000000000001', null, 'Lifestyle', 'lifestyle', 3),
  ('c0000003-0000-0000-0000-000000000002', 'c0000003-0000-0000-0000-000000000001', 'Daily Vlogs', 'daily-vlogs', 1),
  ('c0000003-0000-0000-0000-000000000003', 'c0000003-0000-0000-0000-000000000001', 'Home Decor', 'home-decor', 2),

  ('c0000004-0000-0000-0000-000000000001', null, 'Fitness & Health', 'fitness-health', 4),
  ('c0000004-0000-0000-0000-000000000002', 'c0000004-0000-0000-0000-000000000001', 'Gym & Workout', 'gym-workout', 1),
  ('c0000004-0000-0000-0000-000000000003', 'c0000004-0000-0000-0000-000000000001', 'Yoga & Wellness', 'yoga-wellness', 2),
  ('c0000004-0000-0000-0000-000000000004', 'c0000004-0000-0000-0000-000000000001', 'Nutrition & Diet', 'nutrition-diet', 3),

  ('c0000005-0000-0000-0000-000000000001', null, 'Food & Beverage', 'food-beverage', 5),
  ('c0000005-0000-0000-0000-000000000002', 'c0000005-0000-0000-0000-000000000001', 'Recipes & Cooking', 'recipes-cooking', 1),
  ('c0000005-0000-0000-0000-000000000003', 'c0000005-0000-0000-0000-000000000001', 'Food Reviews & Travel', 'food-reviews', 2),

  ('c0000006-0000-0000-0000-000000000001', null, 'Travel', 'travel', 6),
  ('c0000006-0000-0000-0000-000000000002', 'c0000006-0000-0000-0000-000000000001', 'Backpacking & Budget', 'backpacking', 1),
  ('c0000006-0000-0000-0000-000000000003', 'c0000006-0000-0000-0000-000000000001', 'Luxury Stays & Resorts', 'luxury-travel', 2),

  ('c0000007-0000-0000-0000-000000000001', null, 'Technology & Gadgets', 'technology', 7),
  ('c0000007-0000-0000-0000-000000000002', 'c0000007-0000-0000-0000-000000000001', 'Smartphones & Reviews', 'smartphone-reviews', 1),
  ('c0000007-0000-0000-0000-000000000003', 'c0000007-0000-0000-0000-000000000001', 'Software & AI Tools', 'software-ai', 2),

  ('c0000008-0000-0000-0000-000000000001', null, 'Gaming & Esports', 'gaming', 8),
  ('c0000008-0000-0000-0000-000000000002', 'c0000008-0000-0000-0000-000000000001', 'Live Streaming', 'live-streaming', 1),
  ('c0000008-0000-0000-0000-000000000003', 'c0000008-0000-0000-0000-000000000001', 'Game Walkthroughs', 'game-walkthroughs', 2),

  ('c0000009-0000-0000-0000-000000000001', null, 'Finance & Business', 'finance', 9),
  ('c0000009-0000-0000-0000-000000000002', 'c0000009-0000-0000-0000-000000000001', 'Personal Finance & Investing', 'personal-finance', 1),
  ('c0000009-0000-0000-0000-000000000003', 'c0000009-0000-0000-0000-000000000001', 'Startups & Entrepreneurship', 'startups', 2),

  ('c0000010-0000-0000-0000-000000000001', null, 'Education & Knowledge', 'education', 10),
  ('c0000011-0000-0000-0000-000000000001', null, 'Entertainment & Comedy', 'entertainment', 11),
  ('c0000012-0000-0000-0000-000000000001', null, 'Parenting & Family', 'parenting', 12),
  ('c0000013-0000-0000-0000-000000000001', null, 'Sports & Outdoor', 'sports', 13)
on conflict (slug) do nothing;

-- Normalized Languages (with Indian regional language emphasis)
insert into public.languages (code, name, native_name, sort_order) values
  ('en', 'English', 'English', 1),
  ('hi', 'Hindi', 'हिन्दी', 2),
  ('bn', 'Bengali', 'বাংলা', 3),
  ('te', 'Telugu', 'తెలుగు', 4),
  ('mr', 'Marathi', 'मराठी', 5),
  ('ta', 'Tamil', 'தமிழ்', 6),
  ('ur', 'Urdu', 'اردو', 7),
  ('gu', 'Gujarati', 'ગુજરાતી', 8),
  ('kn', 'Kannada', 'ಕನ್ನಡ', 9),
  ('ml', 'Malayalam', 'മലയാളം', 10),
  ('pa', 'Punjabi', 'ਪੰਜਾਬੀ', 11),
  ('or', 'Odia', 'ଓଡ଼ିଆ', 12),
  ('as', 'Assamese', 'অসমীয়া', 13),
  ('es', 'Spanish', 'Español', 20),
  ('fr', 'French', 'Français', 21),
  ('de', 'German', 'Deutsch', 22),
  ('ar', 'Arabic', 'العربية', 23),
  ('ja', 'Japanese', '日本語', 24),
  ('ko', 'Korean', '한국어', 25)
on conflict (code) do nothing;
