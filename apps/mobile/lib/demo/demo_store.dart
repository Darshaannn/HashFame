import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/brand/domain/brand_profile.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/creator/domain/collaboration.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_member.dart';

import 'demo_raw_csv_data.dart';
import 'demo_sheet_creator_importer.dart';

class DemoStore {
  DemoStore._() {
    reset();
  }

  static final DemoStore instance = DemoStore._();

  // Current active role in Demo Mode
  ProfessionalRole currentRole = ProfessionalRole.brandMarketer;

  // Master lists
  final List<Category> categories = [];
  final List<Language> languages = [];
  final Map<String, CreatorProfile> creatorProfiles = {};
  final List<CreatorDiscoveryItem> discoveryItems = [];
  final Map<String, Shortlist> shortlists = {};
  final Map<String, List<ShortlistMember>> shortlistMembers = {};
  final Map<String, Campaign> campaigns = {};
  final Map<String, CampaignApplication> applications = {};
  final Map<String, List<CampaignApplicationStatusHistory>>
  applicationHistories = {};

  // User Accounts for switching
  late Account brandAccount;
  late Account creatorAccount;
  late Account agencyAccount;
  late BrandMarketerProfile brandProfile;
  late AgencyProfile agencyProfile;

  void reset() {
    categories.clear();
    languages.clear();
    creatorProfiles.clear();
    discoveryItems.clear();
    shortlists.clear();
    shortlistMembers.clear();
    campaigns.clear();
    applications.clear();
    applicationHistories.clear();

    _seedReferenceData();
    _seedAccounts();
    _seedCreators();
    _seedShortlists();
    _seedCampaigns();
    _seedApplications();
  }

  void _seedReferenceData() {
    categories.addAll(const [
      Category(
        id: 'cat_fashion',
        name: 'Fashion & Style',
        slug: 'fashion',
        sortOrder: 1,
      ),
      Category(
        id: 'cat_beauty',
        name: 'Beauty & Skincare',
        slug: 'beauty',
        sortOrder: 2,
      ),
      Category(
        id: 'cat_lifestyle',
        name: 'Lifestyle & Vlogs',
        slug: 'lifestyle',
        sortOrder: 3,
      ),
      Category(
        id: 'cat_food',
        name: 'Food & Culinary',
        slug: 'food',
        sortOrder: 4,
      ),
      Category(
        id: 'cat_fitness',
        name: 'Health & Fitness',
        slug: 'fitness',
        sortOrder: 5,
      ),
      Category(
        id: 'cat_travel',
        name: 'Travel & Adventure',
        slug: 'travel',
        sortOrder: 6,
      ),
      Category(
        id: 'cat_tech',
        name: 'Technology & Gadgets',
        slug: 'tech',
        sortOrder: 7,
      ),
      Category(
        id: 'cat_finance',
        name: 'Personal Finance & Fintech',
        slug: 'finance',
        sortOrder: 8,
      ),
      Category(
        id: 'cat_gaming',
        name: 'Gaming & Esports',
        slug: 'gaming',
        sortOrder: 9,
      ),
    ]);

    languages.addAll(const [
      Language(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        sortOrder: 1,
      ),
      Language(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी', sortOrder: 2),
      Language(code: 'mr', name: 'Marathi', nativeName: 'मराठी', sortOrder: 3),
      Language(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்', sortOrder: 4),
      Language(code: 'te', name: 'Telugu', nativeName: 'తెలుగు', sortOrder: 5),
      Language(code: 'kn', name: 'Kannada', nativeName: 'ಕನ್ನಡ', sortOrder: 6),
    ]);
  }

  void _seedAccounts() {
    brandAccount = Account(
      id: 'demo_brand_user_id',
      displayName: 'Sarah Jenkins',
      primaryRoleLabel: ProfessionalRole.brandMarketer,
      accountState: AccountState.active,
      updatedAt: DateTime.utc(2026, 3, 1),
    );

    brandProfile = const BrandMarketerProfile(
      userId: 'demo_brand_user_id',
      displayName: 'Sarah Jenkins',
      jobTitle: 'Head of Influencer Marketing',
      workEmail: 'sarah.j@novabeauty.in',
      phone: '+919820011223',
      bio: 'Leading brand partnerships & digital campaigns across India for Nova Consumer Brands.',
      organizationName: 'Nova Beauty India',
      managedBrands: [
        CompanyBrand(
          id: 'b1',
          organizationId: 'demo_brand_user_id',
          name: 'Nova Glow',
          industry: 'Beauty & Skincare',
          headquarters: 'Mumbai',
        ),
        CompanyBrand(
          id: 'b2',
          organizationId: 'demo_brand_user_id',
          name: 'Nova Active',
          industry: 'Fitness & Wellness',
          headquarters: 'Bengaluru',
        ),
      ],
    );

    creatorAccount = Account(
      id: 'demo_creator_user_id',
      displayName: 'Aisha Mehta',
      primaryRoleLabel: ProfessionalRole.creator,
      accountState: AccountState.active,
      updatedAt: DateTime.utc(2026, 3, 1),
    );

    agencyAccount = Account(
      id: 'demo_agency_user_id',
      displayName: 'Karan Mehra',
      primaryRoleLabel: ProfessionalRole.agency,
      accountState: AccountState.active,
      updatedAt: DateTime.utc(2026, 3, 1),
    );

    agencyProfile = const AgencyProfile(
      userId: 'demo_agency_user_id',
      agencyName: 'Pulse Talent & Media',
      website: 'https://pulsemedia.example.com',
      description: 'Premier digital talent representation & influencer strategy house headquartered in Mumbai.',
    );
  }

  void _seedCreators() {
    final creatorDefs = [
      _CreatorSeed(
        id: 'demo_creator_user_id',
        name: 'Aisha Mehta',
        handle: 'aishamehta',
        city: 'Mumbai',
        state: 'Maharashtra',
        bio: 'Festive fashion styling, luxury beauty unboxings & conscious lifestyle aesthetic. Creating meaningful brand stories.',
        categories: ['cat_fashion', 'cat_beauty'],
        categoryNames: ['Fashion & Style', 'Beauty & Skincare'],
        languages: ['en', 'hi'],
        languageNames: ['English', 'Hindi'],
        platform: SocialPlatform.instagram,
        followers: 142000,
        startingRate: 25000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r1',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 25000,
            description: '1x 60s Reel with organic collaboration tag',
            isActive: true,
          ),
          RateItem(
            id: 'r2',
            userId: userId,
            deliverableType: DeliverableType.instagramStory,
            priceAmount: 8000,
            description: '3x Story frames with swipe-up link',
            isActive: true,
          ),
          RateItem(
            id: 'r3',
            userId: userId,
            deliverableType: DeliverableType.instagramPost,
            priceAmount: 18000,
            description: '1x Carousel post with in-depth product review',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p1',
            userId: userId,
            title: 'Festive Glam Lookbook',
            description:
                'Diwali fusion styling in collaboration with Raw Mango.',
            platform: SocialPlatform.instagram,
            brandName: 'Raw Mango',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
          PortfolioItem(
            id: 'p2',
            userId: userId,
            title: '10-Step Glass Skin Routine',
            description: 'Clean hydration routine showing morning skincare.',
            platform: SocialPlatform.instagram,
            brandName: 'Laneige India',
            contentType: PortfolioContentType.video,
            sortOrder: 2,
          ),
          PortfolioItem(
            id: 'p3',
            userId: userId,
            title: 'Sustainable Wardrobe Essentials',
            description: 'Curating timeless silhouettes for Indian summers.',
            platform: SocialPlatform.instagram,
            brandName: 'Nicobar',
            contentType: PortfolioContentType.image,
            sortOrder: 3,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c1',
            userId: userId,
            brandName: 'Nykaa Beauty',
            campaignName: 'Summer Glow Fest',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
          PastCollaboration(
            id: 'c2',
            userId: userId,
            brandName: 'FabIndia',
            campaignName: 'Heritage Silks',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramPost,
          ),
        ],
        isRepresented: true,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_riya_kapoor',
        name: 'Riya Kapoor',
        handle: 'riyakapoor_beauty',
        city: 'Delhi',
        state: 'Delhi',
        bio: 'Dermat-friendly skincare tips, honest beauty reviews & makeup tutorials for Indian skin tones.',
        categories: ['cat_beauty', 'cat_lifestyle'],
        categoryNames: ['Beauty & Skincare', 'Lifestyle & Vlogs'],
        languages: ['en', 'hi'],
        languageNames: ['English', 'Hindi'],
        platform: SocialPlatform.instagram,
        followers: 215000,
        startingRate: 35000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r4',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 35000,
            description: '1x 90s In-depth Skincare breakdown',
            isActive: true,
          ),
          RateItem(
            id: 'r5',
            userId: userId,
            deliverableType: DeliverableType.youtubeShort,
            priceAmount: 20000,
            description: '1x YouTube Short',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p4',
            userId: userId,
            title: 'Monsoon Skincare SOS',
            description: 'Preventing breakouts during humid weather.',
            platform: SocialPlatform.instagram,
            brandName: 'The Derma Co',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
          PortfolioItem(
            id: 'p5',
            userId: userId,
            title: 'Sunscreen Testing Guide',
            description: 'Testing 5 Indian sunscreens under UV camera.',
            platform: SocialPlatform.youtube,
            brandName: 'Dot & Key',
            contentType: PortfolioContentType.video,
            sortOrder: 2,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c3',
            userId: userId,
            brandName: 'L\'Oréal Paris',
            campaignName: 'Hyaluronic Hero',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_rohan_tech',
        name: 'Rohan Sharma',
        handle: 'techwithrohan',
        city: 'Bengaluru',
        state: 'Karnataka',
        bio: 'Clear, unbiased tech reviews, smartphone teardowns & productivity desk setups.',
        categories: ['cat_tech', 'cat_gaming'],
        categoryNames: ['Technology & Gadgets', 'Gaming & Esports'],
        languages: ['en', 'hi', 'kn'],
        languageNames: ['English', 'Hindi', 'Kannada'],
        platform: SocialPlatform.youtube,
        followers: 480000,
        startingRate: 60000,
        rateDeliverable: DeliverableType.youtubeVideo,
        rates: (userId) => [
          RateItem(
            id: 'r6',
            userId: userId,
            deliverableType: DeliverableType.youtubeVideo,
            priceAmount: 60000,
            description: 'Full dedicated 8-10 min review video',
            isActive: true,
          ),
          RateItem(
            id: 'r7',
            userId: userId,
            deliverableType: DeliverableType.youtubeIntegration,
            priceAmount: 30000,
            description: '60s Mid-roll integration',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p6',
            userId: userId,
            title: 'Flagship Killer Showdown',
            description: 'Detailed camera and battery stress testing.',
            platform: SocialPlatform.youtube,
            brandName: 'OnePlus',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c4',
            userId: userId,
            brandName: 'Samsung India',
            campaignName: 'Galaxy Ecosystem',
            collaborationYear: 2025,
            deliverableType: DeliverableType.youtubeVideo,
          ),
        ],
        isRepresented: true,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_neha_rao',
        name: 'Neha Rao',
        handle: 'neha_fit_life',
        city: 'Bengaluru',
        state: 'Karnataka',
        bio: 'Holistic strength training, functional Indian nutrition and corporate wellness.',
        categories: ['cat_fitness', 'cat_food'],
        categoryNames: ['Health & Fitness', 'Food & Culinary'],
        languages: ['en', 'kn', 'ta'],
        languageNames: ['English', 'Kannada', 'Tamil'],
        platform: SocialPlatform.instagram,
        followers: 95000,
        startingRate: 18000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r8',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 18000,
            description: 'Workout & recipe Reel',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p7',
            userId: userId,
            title: 'High Protein Vegetarian Meals',
            description: '5 Easy Indian lunch ideas with 25g+ protein.',
            platform: SocialPlatform.instagram,
            brandName: 'Epigamia',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c5',
            userId: userId,
            brandName: 'Myfitness',
            campaignName: 'Peanut Butter Fuel',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_aditya_food',
        name: 'Aditya Kulkarni',
        handle: 'pune_foodie_aditya',
        city: 'Pune',
        state: 'Maharashtra',
        bio: 'Exploring traditional Maharashtrian recipes, heritage street food and artisanal regional kitchens.',
        categories: ['cat_food', 'cat_travel'],
        categoryNames: ['Food & Culinary', 'Travel & Adventure'],
        languages: ['mr', 'en', 'hi'],
        languageNames: ['Marathi', 'English', 'Hindi'],
        platform: SocialPlatform.instagram,
        followers: 128000,
        startingRate: 22000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r9',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 22000,
            description: 'Culinary showcase Reel',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p8',
            userId: userId,
            title: 'Lost Recipes of Kolhapur',
            description: 'Documenting authentic spices and heirloom recipes.',
            platform: SocialPlatform.instagram,
            brandName: 'Tata Sampann',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c6',
            userId: userId,
            brandName: 'Swiggy Gourmet',
            campaignName: 'Regional Delights',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_priya_travel',
        name: 'Priya Sundaram',
        handle: 'priya_wanderlust',
        city: 'Chennai',
        state: 'Tamil Nadu',
        bio: 'Solo female travel itineraries, sustainable staycations & southern coastal narratives.',
        categories: ['cat_travel', 'cat_lifestyle'],
        categoryNames: ['Travel & Adventure', 'Lifestyle & Vlogs'],
        languages: ['ta', 'en'],
        languageNames: ['Tamil', 'English'],
        platform: SocialPlatform.instagram,
        followers: 175000,
        startingRate: 30000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r10',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 30000,
            description: 'Travel montage Reel with voiceover',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p9',
            userId: userId,
            title: '48 Hours in Chettinad',
            description: 'Heritage mansion stays and architecture trail.',
            platform: SocialPlatform.instagram,
            brandName: 'Airbnb India',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c7',
            userId: userId,
            brandName: 'MakeMyTrip',
            campaignName: 'Hidden Gems South',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: true,
        availStatus: AvailabilityStatus.limited,
      ),
      _CreatorSeed(
        id: 'creator_vikram_finance',
        name: 'Vikram Joshi',
        handle: 'fintech_vikram',
        city: 'Mumbai',
        state: 'Maharashtra',
        bio: 'Simplifying index investing, tax saving strategies and credit card rewards for young professionals.',
        categories: ['cat_finance', 'cat_tech'],
        categoryNames: ['Personal Finance & Fintech', 'Technology & Gadgets'],
        languages: ['en', 'hi'],
        languageNames: ['English', 'Hindi'],
        platform: SocialPlatform.youtube,
        followers: 340000,
        startingRate: 50000,
        rateDeliverable: DeliverableType.youtubeVideo,
        rates: (userId) => [
          RateItem(
            id: 'r11',
            userId: userId,
            deliverableType: DeliverableType.youtubeVideo,
            priceAmount: 50000,
            description: 'Educational deep-dive video',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p10',
            userId: userId,
            title: 'Zero-Cost Term Insurance Guide',
            description: 'Objective comparison of policies.',
            platform: SocialPlatform.youtube,
            brandName: 'Ditto Insurance',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c8',
            userId: userId,
            brandName: 'Groww',
            campaignName: 'Direct SIP Journey',
            collaborationYear: 2025,
            deliverableType: DeliverableType.youtubeVideo,
          ),
        ],
        isRepresented: true,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_sneha_fashion',
        name: 'Sneha Reddy',
        handle: 'sneha_styles_hyderabad',
        city: 'Hyderabad',
        state: 'Telangana',
        bio: 'Modern ethnic wear, handloom revival and wedding guest styling inspiration.',
        categories: ['cat_fashion', 'cat_lifestyle'],
        categoryNames: ['Fashion & Style', 'Lifestyle & Vlogs'],
        languages: ['te', 'en', 'hi'],
        languageNames: ['Telugu', 'English', 'Hindi'],
        platform: SocialPlatform.instagram,
        followers: 188000,
        startingRate: 32000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r12',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 32000,
            description: '1x High production fashion Reel',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p11',
            userId: userId,
            title: 'Pochampally Ikat Drapes',
            description: 'Contemporary ways to style traditional Ikats.',
            platform: SocialPlatform.instagram,
            brandName: 'Kalki Fashion',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c9',
            userId: userId,
            brandName: 'Tanishq',
            campaignName: 'Rivaah Brides',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_kabir_gaming',
        name: 'Kabir Singhania',
        handle: 'kabir_plays',
        city: 'Delhi',
        state: 'Delhi',
        bio: 'Competitive mobile esports, hardware reviews and interactive livestream highlights.',
        categories: ['cat_gaming', 'cat_tech'],
        categoryNames: ['Gaming & Esports', 'Technology & Gadgets'],
        languages: ['hi', 'en'],
        languageNames: ['Hindi', 'English'],
        platform: SocialPlatform.youtube,
        followers: 520000,
        startingRate: 75000,
        rateDeliverable: DeliverableType.youtubeVideo,
        rates: (userId) => [
          RateItem(
            id: 'r13',
            userId: userId,
            deliverableType: DeliverableType.youtubeVideo,
            priceAmount: 75000,
            description: 'Dedicated gaming hardware test',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p12',
            userId: userId,
            title: '144Hz Gaming Phone Test',
            description: 'Thermal throttling test in 40C Delhi weather.',
            platform: SocialPlatform.youtube,
            brandName: 'ASUS ROG',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c10',
            userId: userId,
            brandName: 'Red Bull India',
            campaignName: 'Game On',
            collaborationYear: 2025,
            deliverableType: DeliverableType.youtubeVideo,
          ),
        ],
        isRepresented: true,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_tanvi_beauty',
        name: 'Tanvi Deshmukh',
        handle: 'tanvi_naturals',
        city: 'Mumbai',
        state: 'Maharashtra',
        bio: 'Ayurvedic hair care formulations, clean ingredient breakdowns & DIY hair masks.',
        categories: ['cat_beauty', 'cat_lifestyle'],
        categoryNames: ['Beauty & Skincare', 'Lifestyle & Vlogs'],
        languages: ['mr', 'en', 'hi'],
        languageNames: ['Marathi', 'English', 'Hindi'],
        platform: SocialPlatform.instagram,
        followers: 110000,
        startingRate: 20000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r14',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 20000,
            description: 'Haircare routine Reel',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p13',
            userId: userId,
            title: 'Root Oiling Masterclass',
            description: 'Traditional scalp massage techniques.',
            platform: SocialPlatform.instagram,
            brandName: 'Forest Essentials',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c11',
            userId: userId,
            brandName: 'Kama Ayurveda',
            campaignName: 'Bringadi Ritual',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_manoj_fitness',
        name: 'Manoj Pillai',
        handle: 'manoj_calisthenics',
        city: 'Chennai',
        state: 'Tamil Nadu',
        bio: 'Bodyweight training, calisthenics progressions and injury prevention guides.',
        categories: ['cat_fitness'],
        categoryNames: ['Health & Fitness'],
        languages: ['ta', 'en'],
        languageNames: ['Tamil', 'English'],
        platform: SocialPlatform.instagram,
        followers: 78000,
        startingRate: 15000,
        rateDeliverable: DeliverableType.instagramReel,
        rates: (userId) => [
          RateItem(
            id: 'r15',
            userId: userId,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 15000,
            description: 'Calisthenics tutorial Reel',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p14',
            userId: userId,
            title: 'First Muscle-Up in 30 Days',
            description: 'Step by step progressive workout plan.',
            platform: SocialPlatform.instagram,
            brandName: 'Cult.fit',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c12',
            userId: userId,
            brandName: 'MuscleBlaze',
            campaignName: 'Fuel The Beast',
            collaborationYear: 2025,
            deliverableType: DeliverableType.instagramReel,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
      _CreatorSeed(
        id: 'creator_shreya_ugc',
        name: 'Shreya Bansal',
        handle: 'shreya_creates_ugc',
        city: 'Delhi',
        state: 'Delhi',
        bio: 'High-converting UGC video creator specializing in D2C consumer brands and unboxings.',
        categories: ['cat_beauty', 'cat_lifestyle', 'cat_tech'],
        categoryNames: [
          'Beauty & Skincare',
          'Lifestyle & Vlogs',
          'Technology & Gadgets',
        ],
        languages: ['hi', 'en'],
        languageNames: ['Hindi', 'English'],
        platform: SocialPlatform.instagram,
        followers: 45000,
        startingRate: 10000,
        rateDeliverable: DeliverableType.ugcVideo,
        rates: (userId) => [
          RateItem(
            id: 'r16',
            userId: userId,
            deliverableType: DeliverableType.ugcVideo,
            priceAmount: 10000,
            description:
                '1x Raw UGC hook + problem + solution video with rights',
            isActive: true,
          ),
        ],
        portfolio: (userId) => [
          PortfolioItem(
            id: 'p15',
            userId: userId,
            title: 'Viral Unboxing Concept',
            description:
                'Dynamic unboxing concept with voiceover for Meta ads.',
            platform: SocialPlatform.instagram,
            brandName: 'Minimalist',
            contentType: PortfolioContentType.video,
            sortOrder: 1,
          ),
        ],
        collabs: (userId) => [
          PastCollaboration(
            id: 'c13',
            userId: userId,
            brandName: 'Foxtale',
            campaignName: 'Acne Spot Zero',
            collaborationYear: 2025,
            deliverableType: DeliverableType.ugcVideo,
          ),
        ],
        isRepresented: false,
        availStatus: AvailabilityStatus.open,
      ),
    ];

    for (final seed in creatorDefs) {
      final primaryCats = seed.categories
          .map(
            (cid) => categories.firstWhere(
              (c) => c.id == cid,
              orElse: () => Category(id: cid, name: cid, slug: cid),
            ),
          )
          .toList();
      final langList = seed.languages
          .map(
            (code) => languages.firstWhere(
              (l) => l.code == code,
              orElse: () => Language(code: code, name: code, nativeName: code),
            ),
          )
          .toList();

      final profile = CreatorProfile(
        userId: seed.id,
        displayName: seed.name,
        professionalName: seed.handle,
        bio: seed.bio,
        location: LocationData(
          city: seed.city,
          state: seed.state,
          country: 'IN',
        ),
        availability: CreatorAvailability(status: seed.availStatus),
        isRepresented: seed.isRepresented,
        onboardingStep: 5,
        onboardingCompleted: true,
        primaryCategories: primaryCats,
        languages: langList,
        socialAccounts: [
          SocialAccount(
            id: 'soc_${seed.id}',
            userId: seed.id,
            platform: seed.platform,
            handle: seed.handle,
            userProvidedFollowerCount: seed.followers,
            connectionStatus: SocialConnectionStatus.connected,
          ),
        ],
        rateCard: seed.rates(seed.id),
        portfolio: seed.portfolio(seed.id),
        pastCollaborations: seed.collabs(seed.id),
        verificationSummary: const VerificationSummary(
          identityStatus: FieldVerificationStatus.verified,
          emailStatus: FieldVerificationStatus.verified,
        ),
      );

      creatorProfiles[seed.id] = profile;

      discoveryItems.add(
        CreatorDiscoveryItem(
          creatorId: seed.id,
          displayName: seed.name,
          professionalName: seed.handle,
          city: seed.city,
          state: seed.state,
          country: 'IN',
          primaryCategoryNames: seed.categoryNames,
          languageNames: seed.languageNames,
          primaryPlatform: seed.platform,
          totalFollowers: seed.followers,
          startingRate: seed.startingRate,
          startingRateDeliverable: seed.rateDeliverable,
          availabilityStatus: seed.availStatus,
          isRepresented: seed.isRepresented,
        ),
      );
    }

    // Ingest real creator entries supplied from the official Google Sheet
    final sheetProfiles = DemoSheetCreatorImporter.parseSheetProfiles(
      demoCreatorsCsvData,
      categories,
      languages,
    );
    creatorProfiles.addAll(sheetProfiles);

    final sheetDiscovery = DemoSheetCreatorImporter.parseSheetDiscoveryItems(
      demoCreatorsCsvData,
      categories,
    );
    discoveryItems.addAll(sheetDiscovery);
  }

  void _seedShortlists() {
    final sl1 = Shortlist(
      id: 'sl_festive_beauty',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      name: 'Summer Beauty Launch',
      description: 'Curated skincare & beauty influencers for the Q2 Summer Glow campaign.',
      createdAt: DateTime.utc(2026, 2, 10),
      updatedAt: DateTime.utc(2026, 2, 28),
      memberCount: 3,
    );

    final sl2 = Shortlist(
      id: 'sl_mumbai_fitness',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      name: 'Mumbai Fitness Campaign',
      description: 'Regional health and wellness creators based in Mumbai/Pune for local activations.',
      createdAt: DateTime.utc(2026, 2, 15),
      updatedAt: DateTime.utc(2026, 2, 25),
      memberCount: 2,
    );

    final sl3 = Shortlist(
      id: 'sl_tech_influencers',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      name: 'Tech & Gadgets Q3 Roster',
      description: 'Long-form YouTube reviewers and gadget creators for upcoming hardware product drops.',
      createdAt: DateTime.utc(2026, 2, 20),
      updatedAt: DateTime.utc(2026, 2, 26),
      memberCount: 2,
    );

    shortlists[sl1.id] = sl1;
    shortlists[sl2.id] = sl2;
    shortlists[sl3.id] = sl3;

    shortlistMembers[sl1.id] = [
      ShortlistMember(
        id: 'sm_1',
        shortlistId: sl1.id,
        creatorId: 'demo_creator_user_id',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.reviewing,
        notes:
            'Aesthetic matches our palette perfectly. Sent preliminary brief.',
        createdAt: DateTime.utc(2026, 2, 11),
        updatedAt: DateTime.utc(2026, 2, 20),
        creatorDisplayName: 'Aisha Mehta',
        creatorCity: 'Mumbai',
        creatorPrimaryCategory: 'Fashion & Style',
      ),
      ShortlistMember(
        id: 'sm_2',
        shortlistId: sl1.id,
        creatorId: 'creator_riya_kapoor',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.confirmed,
        notes: 'Agreed to participate in 1x Reel + 2x Stories bundle.',
        createdAt: DateTime.utc(2026, 2, 12),
        updatedAt: DateTime.utc(2026, 2, 24),
        creatorDisplayName: 'Riya Kapoor',
        creatorCity: 'Delhi',
        creatorPrimaryCategory: 'Beauty & Skincare',
      ),
      ShortlistMember(
        id: 'sm_3',
        shortlistId: sl1.id,
        creatorId: 'creator_tanvi_beauty',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.potential,
        notes: 'Evaluate engagement rate on last 3 videos.',
        createdAt: DateTime.utc(2026, 2, 14),
        updatedAt: DateTime.utc(2026, 2, 14),
        creatorDisplayName: 'Tanvi Deshmukh',
        creatorCity: 'Mumbai',
        creatorPrimaryCategory: 'Beauty & Skincare',
      ),
    ];

    shortlistMembers[sl2.id] = [
      ShortlistMember(
        id: 'sm_4',
        shortlistId: sl2.id,
        creatorId: 'creator_neha_rao',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.potential,
        notes: 'Great regional reach across south/west.',
        createdAt: DateTime.utc(2026, 2, 16),
        updatedAt: DateTime.utc(2026, 2, 16),
        creatorDisplayName: 'Neha Rao',
        creatorCity: 'Bengaluru',
        creatorPrimaryCategory: 'Health & Fitness',
      ),
      ShortlistMember(
        id: 'sm_5',
        shortlistId: sl2.id,
        creatorId: 'creator_aditya_food',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.reviewing,
        notes: 'Inquired for Pune marathon partner booth.',
        createdAt: DateTime.utc(2026, 2, 17),
        updatedAt: DateTime.utc(2026, 2, 22),
        creatorDisplayName: 'Aditya Kulkarni',
        creatorCity: 'Pune',
        creatorPrimaryCategory: 'Food & Culinary',
      ),
    ];

    shortlistMembers[sl3.id] = [
      ShortlistMember(
        id: 'sm_6',
        shortlistId: sl3.id,
        creatorId: 'creator_rohan_tech',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.potential,
        notes: 'Top tier review credibility.',
        createdAt: DateTime.utc(2026, 2, 21),
        updatedAt: DateTime.utc(2026, 2, 21),
        creatorDisplayName: 'Rohan Sharma',
        creatorCity: 'Bengaluru',
        creatorPrimaryCategory: 'Technology & Gadgets',
      ),
      ShortlistMember(
        id: 'sm_7',
        shortlistId: sl3.id,
        creatorId: 'creator_kabir_gaming',
        addedBy: 'demo_brand_user_id',
        status: ShortlistMemberStatus.potential,
        notes: 'Targeting Gen-Z gaming audience.',
        createdAt: DateTime.utc(2026, 2, 22),
        updatedAt: DateTime.utc(2026, 2, 22),
        creatorDisplayName: 'Kabir Singhania',
        creatorCity: 'Delhi',
        creatorPrimaryCategory: 'Gaming & Esports',
      ),
    ];
  }

  void _seedCampaigns() {
    final c1 = Campaign(
      id: 'camp_glow_forward',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      title: 'Glow Forward — Festive Beauty Creator Campaign',
      objective: 'Drive brand awareness & sampling for Nova Glow Hydration Serum across tier-1 cities.',
      description: 'We are looking for creative beauty & fashion creators to showcase our all-new 10% Niacinamide Hydration Serum in their festive prep routines. Creators should highlight product texture, unboxing, and real skin glow over 7 days.',
      status: CampaignStatus.live,
      compensationType: CampaignCompensationType.paidAndBarter,
      currency: 'INR',
      budgetMin: 25000,
      budgetMax: 50000,
      barterValue: 5000,
      barterDescription: 'Nova Glow Luxury Gift Hamper (Full skincare range + personalized vanity pouch)',
      creatorSlots: 5,
      targetCity: 'Mumbai',
      targetState: 'Maharashtra',
      targetCountry: 'IN',
      minFollowers: 50000,
      categoryIds: ['cat_beauty', 'cat_fashion'],
      categoryNames: ['Beauty & Skincare', 'Fashion & Style'],
      languageCodes: ['en', 'hi'],
      languageNames: ['English', 'Hindi'],
      deliverables: [
        const CampaignDeliverable(
          id: 'del_1',
          campaignId: 'camp_glow_forward',
          deliverableType: CampaignDeliverableType.instagramReel,
          platform: 'Instagram',
          quantity: 1,
          description:
              '1x 60s Reel with aesthetic application and voiceover review.',
        ),
        const CampaignDeliverable(
          id: 'del_2',
          campaignId: 'camp_glow_forward',
          deliverableType: CampaignDeliverableType.instagramStory,
          platform: 'Instagram',
          quantity: 2,
          description:
              '2x Story frames with exclusive 15% discount tracking link.',
        ),
      ],
      usageRights: const CampaignUsageRights(
        organicRepostingAllowed: true,
        paidUsageRequired: true,
        whitelistingRequired: false,
        usageDurationMonths: 3,
        usageTerritory: 'India',
        contentApprovalRequired: true,
        disclosureRequired: true,
      ),
      applicationDeadline: DateTime.now().add(const Duration(days: 14)),
      contentDeadline: DateTime.now().add(const Duration(days: 30)),
      campaignStartDate: DateTime.now().add(const Duration(days: 5)),
      campaignEndDate: DateTime.now().add(const Duration(days: 45)),
      applicantCount: 3,
      selectedCount: 1,
      brandName: 'Nova Beauty India',
      createdAt: DateTime.utc(2026, 2, 18),
      updatedAt: DateTime.utc(2026, 2, 28),
      publishedAt: DateTime.utc(2026, 2, 19),
    );

    final c2 = Campaign(
      id: 'camp_active_fuel',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      title: 'Nova Active — Morning Workout Fuel Sprint',
      objective: 'Launch of plant protein smoothie premix among fitness athletes & trainers.',
      description: 'Looking for disciplined fitness, crossfit, and yoga creators to document their post-workout recovery routines incorporating Nova Active Plant Fuel.',
      status: CampaignStatus.live,
      compensationType: CampaignCompensationType.paid,
      currency: 'INR',
      budgetMin: 20000,
      budgetMax: 40000,
      creatorSlots: 4,
      targetCity: 'Bengaluru',
      targetState: 'Karnataka',
      minFollowers: 30000,
      categoryIds: ['cat_fitness', 'cat_food'],
      categoryNames: ['Health & Fitness', 'Food & Culinary'],
      languageCodes: ['en', 'kn', 'hi'],
      languageNames: ['English', 'Kannada', 'Hindi'],
      deliverables: [
        const CampaignDeliverable(
          id: 'del_3',
          campaignId: 'camp_active_fuel',
          deliverableType: CampaignDeliverableType.instagramReel,
          platform: 'Instagram',
          quantity: 1,
          description: 'High energy workout montage + smoothie prep.',
        ),
      ],
      usageRights: const CampaignUsageRights(
        organicRepostingAllowed: true,
        paidUsageRequired: false,
        contentApprovalRequired: true,
      ),
      applicationDeadline: DateTime.now().add(const Duration(days: 10)),
      contentDeadline: DateTime.now().add(const Duration(days: 25)),
      applicantCount: 2,
      selectedCount: 0,
      brandName: 'Nova Active',
      createdAt: DateTime.utc(2026, 2, 20),
      publishedAt: DateTime.utc(2026, 2, 21),
    );

    final c3 = Campaign(
      id: 'camp_travel_vlog',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      title: 'Coastal Heritage Staycation Campaign',
      objective: 'Document luxury weekend getaways in South India.',
      description: 'Invite creators for an all-expenses-paid weekend staycation at heritage beachfront villas.',
      status: CampaignStatus.live,
      compensationType: CampaignCompensationType.barter,
      currency: 'INR',
      barterValue: 45000,
      barterDescription: '3D/2N Premium Villa Stay with breakfast, dinner & spa vouchers for two.',
      creatorSlots: 3,
      targetCity: 'Chennai',
      categoryIds: ['cat_travel'],
      categoryNames: ['Travel & Adventure'],
      deliverables: [
        const CampaignDeliverable(
          id: 'del_4',
          campaignId: 'camp_travel_vlog',
          deliverableType: CampaignDeliverableType.instagramReel,
          platform: 'Instagram',
          quantity: 2,
          description: 'Vlog reel + room tour reel.',
        ),
      ],
      applicantCount: 0,
      selectedCount: 0,
      brandName: 'Nova Escapes',
      createdAt: DateTime.utc(2026, 2, 25),
      publishedAt: DateTime.utc(2026, 2, 26),
    );

    final c4 = Campaign(
      id: 'camp_d2c_ugc',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      title: 'UGC Ad Creative Sprint — Meta & YouTube Shorts',
      objective:
          'Create 10 high CTR performance ad creatives for paid media testing.',
      description: 'Seeking direct-response UGC creators to record authentic unboxings, 3-second hook variations, and problem-solution demos for digital ads.',
      status: CampaignStatus.live,
      compensationType: CampaignCompensationType.paid,
      currency: 'INR',
      budgetMin: 10000,
      budgetMax: 20000,
      creatorSlots: 6,
      categoryIds: ['cat_beauty', 'cat_lifestyle'],
      categoryNames: ['Beauty & Skincare', 'Lifestyle & Vlogs'],
      deliverables: [
        const CampaignDeliverable(
          id: 'del_5',
          campaignId: 'camp_d2c_ugc',
          deliverableType: CampaignDeliverableType.ugcVideo,
          platform: 'UGC Video',
          quantity: 2,
          description:
              '2x 30s UGC Ad creatives with 3 different opening hooks.',
        ),
      ],
      usageRights: const CampaignUsageRights(
        organicRepostingAllowed: true,
        paidUsageRequired: true,
        usageDurationMonths: 6,
      ),
      applicationDeadline: DateTime.now().add(const Duration(days: 20)),
      applicantCount: 1,
      selectedCount: 0,
      brandName: 'Nova Beauty India',
      createdAt: DateTime.utc(2026, 2, 24),
      publishedAt: DateTime.utc(2026, 2, 25),
    );

    final c5 = Campaign(
      id: 'camp_tech_flagship',
      organizationId: 'demo_brand_user_id',
      createdBy: 'demo_brand_user_id',
      title: 'NextGen Pro Audio Wireless Earbuds Launch',
      objective:
          'Comprehensive unboxing, ANC benchmark and studio microphone review.',
      description: 'Reviewing next-gen wireless earbuds focusing on spatial audio, battery endurance and low latency gaming.',
      status: CampaignStatus.live,
      compensationType: CampaignCompensationType.paidAndBarter,
      currency: 'INR',
      budgetMin: 35000,
      budgetMax: 70000,
      barterValue: 18000,
      barterDescription: 'Flagship ANC Wireless Earbuds (Black Edition)',
      creatorSlots: 4,
      targetCity: 'Bengaluru',
      categoryIds: ['cat_tech'],
      categoryNames: ['Technology & Gadgets'],
      deliverables: [
        const CampaignDeliverable(
          id: 'del_6',
          campaignId: 'camp_tech_flagship',
          deliverableType: CampaignDeliverableType.youtubeVideo,
          platform: 'YouTube',
          quantity: 1,
          description: 'Dedicated 8-minute review video.',
        ),
      ],
      applicationDeadline: DateTime.now().add(const Duration(days: 15)),
      applicantCount: 1,
      selectedCount: 0,
      brandName: 'Nova Audio Labs',
      createdAt: DateTime.utc(2026, 2, 26),
      publishedAt: DateTime.utc(2026, 2, 27),
    );

    campaigns[c1.id] = c1;
    campaigns[c2.id] = c2;
    campaigns[c3.id] = c3;
    campaigns[c4.id] = c4;
    campaigns[c5.id] = c5;
  }

  void _seedApplications() {
    final app1 = CampaignApplication(
      id: 'app_aisha_glow',
      campaignId: 'camp_glow_forward',
      creatorId: 'demo_creator_user_id',
      status: CampaignApplicationStatus.submitted,
      pitch: 'I love Nova Glow\'s clean ingredient ethos! I have an upcoming festive styling series with 80k+ avg reach where I can naturally integrate the Niacinamide serum into my morning glam prep.',
      proposedRate: 28000,
      currency: 'INR',
      createdAt: DateTime.utc(2026, 2, 22),
      campaignTitle: 'Glow Forward — Festive Beauty Creator Campaign',
      brandName: 'Nova Beauty India',
      creatorDisplayName: 'Aisha Mehta',
      creatorCity: 'Mumbai',
      creatorPrimaryCategories: ['Fashion & Style', 'Beauty & Skincare'],
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_1',
          applicationId: 'app_aisha_glow',
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.utc(2026, 2, 22),
          reason: 'Application submitted by creator',
        ),
      ],
    );

    final app2 = CampaignApplication(
      id: 'app_riya_glow',
      campaignId: 'camp_glow_forward',
      creatorId: 'creator_riya_kapoor',
      status: CampaignApplicationStatus.selected,
      pitch: 'Would love to do an educational breakdown comparing serum formulation stability. My audience loves dermatological reviews and has high buy-intent for niacinamide products.',
      proposedRate: 35000,
      currency: 'INR',
      createdAt: DateTime.utc(2026, 2, 20),
      reviewedAt: DateTime.utc(2026, 2, 24),
      campaignTitle: 'Glow Forward — Festive Beauty Creator Campaign',
      brandName: 'Nova Beauty India',
      creatorDisplayName: 'Riya Kapoor',
      creatorCity: 'Delhi',
      creatorPrimaryCategories: ['Beauty & Skincare'],
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_2a',
          applicationId: 'app_riya_glow',
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.utc(2026, 2, 20),
          reason: 'Application submitted',
        ),
        CampaignApplicationStatusHistory(
          id: 'hist_2b',
          applicationId: 'app_riya_glow',
          fromStatus: CampaignApplicationStatus.submitted,
          toStatus: CampaignApplicationStatus.selected,
          createdAt: DateTime.utc(2026, 2, 24),
          reason: 'Selected for campaign slot',
        ),
      ],
    );

    final app3 = CampaignApplication(
      id: 'app_tanvi_glow',
      campaignId: 'camp_glow_forward',
      creatorId: 'creator_tanvi_beauty',
      status: CampaignApplicationStatus.underReview,
      pitch: 'My focus is on holistic Ayurveda and natural skin barrier healing. Nova Glow will fit perfectly into my morning skincare ritual series.',
      proposedRate: 20000,
      currency: 'INR',
      createdAt: DateTime.utc(2026, 2, 23),
      campaignTitle: 'Glow Forward — Festive Beauty Creator Campaign',
      brandName: 'Nova Beauty India',
      creatorDisplayName: 'Tanvi Deshmukh',
      creatorCity: 'Mumbai',
      creatorPrimaryCategories: ['Beauty & Skincare'],
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_3',
          applicationId: 'app_tanvi_glow',
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.utc(2026, 2, 23),
          reason: 'Application submitted',
        ),
      ],
    );

    final app4 = CampaignApplication(
      id: 'app_neha_active',
      campaignId: 'camp_active_fuel',
      creatorId: 'creator_neha_rao',
      status: CampaignApplicationStatus.shortlisted,
      pitch: 'Certified nutritionist and CrossFit athlete in Bengaluru. I drink plant protein post workout every day and my audience regularly asks for supplement recommendations.',
      proposedRate: 22000,
      currency: 'INR',
      createdAt: DateTime.utc(2026, 2, 22),
      campaignTitle: 'Nova Active — Morning Workout Fuel Sprint',
      brandName: 'Nova Active',
      creatorDisplayName: 'Neha Rao',
      creatorCity: 'Bengaluru',
      creatorPrimaryCategories: ['Health & Fitness'],
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_4',
          applicationId: 'app_neha_active',
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.utc(2026, 2, 22),
        ),
        CampaignApplicationStatusHistory(
          id: 'hist_4b',
          applicationId: 'app_neha_active',
          fromStatus: CampaignApplicationStatus.submitted,
          toStatus: CampaignApplicationStatus.shortlisted,
          createdAt: DateTime.utc(2026, 2, 24),
        ),
      ],
    );

    final app5 = CampaignApplication(
      id: 'app_shreya_ugc',
      campaignId: 'camp_d2c_ugc',
      creatorId: 'creator_shreya_ugc',
      status: CampaignApplicationStatus.submitted,
      pitch: 'I have delivered 100+ high-performing UGC creatives for Indian skincare brands with an average 2.8% CTR on Meta Ads. Ready to shoot within 48h of product delivery.',
      proposedRate: 15000,
      currency: 'INR',
      createdAt: DateTime.utc(2026, 2, 26),
      campaignTitle: 'UGC Ad Creative Sprint — Meta & YouTube Shorts',
      brandName: 'Nova Beauty India',
      creatorDisplayName: 'Shreya Bansal',
      creatorCity: 'Delhi',
      creatorPrimaryCategories: ['Beauty & Skincare'],
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_5',
          applicationId: 'app_shreya_ugc',
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.utc(2026, 2, 26),
        ),
      ],
    );

    applications[app1.id] = app1;
    applications[app2.id] = app2;
    applications[app3.id] = app3;
    applications[app4.id] = app4;
    applications[app5.id] = app5;
  }
}

class _CreatorSeed {
  const _CreatorSeed({
    required this.id,
    required this.name,
    required this.handle,
    required this.city,
    required this.state,
    required this.bio,
    required this.categories,
    required this.categoryNames,
    required this.languages,
    required this.languageNames,
    required this.platform,
    required this.followers,
    required this.startingRate,
    required this.rateDeliverable,
    required this.rates,
    required this.portfolio,
    required this.collabs,
    required this.isRepresented,
    required this.availStatus,
  });

  final String id;
  final String name;
  final String handle;
  final String city;
  final String state;
  final String bio;
  final List<String> categories;
  final List<String> categoryNames;
  final List<String> languages;
  final List<String> languageNames;
  final SocialPlatform platform;
  final int followers;
  final double startingRate;
  final DeliverableType rateDeliverable;
  final List<RateItem> Function(String userId) rates;
  final List<PortfolioItem> Function(String userId) portfolio;
  final List<PastCollaboration> Function(String userId) collabs;
  final bool isRepresented;
  final AvailabilityStatus availStatus;
}
