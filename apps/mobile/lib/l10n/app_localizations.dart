import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'GGs Platform'**
  String get appTitle;

  /// No description provided for @demoMode.
  ///
  /// In en, this message translates to:
  /// **'DEMO MODE'**
  String get demoMode;

  /// No description provided for @demoBadge.
  ///
  /// In en, this message translates to:
  /// **'DEMO'**
  String get demoBadge;

  /// No description provided for @viewingAs.
  ///
  /// In en, this message translates to:
  /// **'Viewing as {role}'**
  String viewingAs(String role);

  /// No description provided for @interactiveSandbox.
  ///
  /// In en, this message translates to:
  /// **'Interactive Sandbox'**
  String get interactiveSandbox;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @creator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get creator;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @discoverWork.
  ///
  /// In en, this message translates to:
  /// **'Discover Work'**
  String get discoverWork;

  /// No description provided for @campaigns.
  ///
  /// In en, this message translates to:
  /// **'Campaigns'**
  String get campaigns;

  /// No description provided for @applications.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get applications;

  /// No description provided for @shortlists.
  ///
  /// In en, this message translates to:
  /// **'Shortlists'**
  String get shortlists;

  /// No description provided for @talent.
  ///
  /// In en, this message translates to:
  /// **'Talent'**
  String get talent;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsAndPreferences.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get settingsAndPreferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi (हिंदी)'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi (मराठी)'**
  String get marathi;

  /// No description provided for @languageChangedNotice.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get languageChangedNotice;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @saveName.
  ///
  /// In en, this message translates to:
  /// **'Save Name'**
  String get saveName;

  /// No description provided for @nameSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Display name updated successfully!'**
  String get nameSavedSuccess;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @productUpdates.
  ///
  /// In en, this message translates to:
  /// **'Product Updates & Notifications'**
  String get productUpdates;

  /// No description provided for @productUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive optional news, alerts & platform announcements.'**
  String get productUpdatesDesc;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @brandWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Brand Workspace'**
  String get brandWorkspace;

  /// No description provided for @creatorHome.
  ///
  /// In en, this message translates to:
  /// **'Creator Home'**
  String get creatorHome;

  /// No description provided for @agencyWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Agency Workspace'**
  String get agencyWorkspace;

  /// No description provided for @activeCampaigns.
  ///
  /// In en, this message translates to:
  /// **'Active Campaigns'**
  String get activeCampaigns;

  /// No description provided for @discoverCreators.
  ///
  /// In en, this message translates to:
  /// **'Discover Creators'**
  String get discoverCreators;

  /// No description provided for @totalApplications.
  ///
  /// In en, this message translates to:
  /// **'Total Applications'**
  String get totalApplications;

  /// No description provided for @activeCollaborations.
  ///
  /// In en, this message translates to:
  /// **'Active Collaborations'**
  String get activeCollaborations;

  /// No description provided for @openOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Open Opportunities'**
  String get openOpportunities;

  /// No description provided for @myDeliverables.
  ///
  /// In en, this message translates to:
  /// **'My Deliverables'**
  String get myDeliverables;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @managedTalent.
  ///
  /// In en, this message translates to:
  /// **'Managed Talent'**
  String get managedTalent;

  /// No description provided for @clientBriefs.
  ///
  /// In en, this message translates to:
  /// **'Client Briefs'**
  String get clientBriefs;

  /// No description provided for @searchCreators.
  ///
  /// In en, this message translates to:
  /// **'Search creators by handle, name...'**
  String get searchCreators;

  /// No description provided for @searchWork.
  ///
  /// In en, this message translates to:
  /// **'Search briefs by title, brand...'**
  String get searchWork;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @primaryCategory.
  ///
  /// In en, this message translates to:
  /// **'Primary Category'**
  String get primaryCategory;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @followersRange.
  ///
  /// In en, this message translates to:
  /// **'Followers Range'**
  String get followersRange;

  /// No description provided for @engagementRate.
  ///
  /// In en, this message translates to:
  /// **'Engagement Rate'**
  String get engagementRate;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @verifiedOnly.
  ///
  /// In en, this message translates to:
  /// **'Verified Only'**
  String get verifiedOnly;

  /// No description provided for @hasRateCard.
  ///
  /// In en, this message translates to:
  /// **'Has Rate Card'**
  String get hasRateCard;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @allLocations.
  ///
  /// In en, this message translates to:
  /// **'All Locations'**
  String get allLocations;

  /// No description provided for @noCreatorsFound.
  ///
  /// In en, this message translates to:
  /// **'No creators found'**
  String get noCreatorsFound;

  /// No description provided for @noCreatorsFoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search query or filters to discover matching profiles.'**
  String get noCreatorsFoundDesc;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @shortlist.
  ///
  /// In en, this message translates to:
  /// **'Shortlist'**
  String get shortlist;

  /// No description provided for @shortlisted.
  ///
  /// In en, this message translates to:
  /// **'Shortlisted'**
  String get shortlisted;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @pitchRate.
  ///
  /// In en, this message translates to:
  /// **'Pitch Rate'**
  String get pitchRate;

  /// No description provided for @startingAt.
  ///
  /// In en, this message translates to:
  /// **'Starting at'**
  String get startingAt;

  /// No description provided for @verifiedCreator.
  ///
  /// In en, this message translates to:
  /// **'Verified Creator'**
  String get verifiedCreator;

  /// No description provided for @selfReported.
  ///
  /// In en, this message translates to:
  /// **'Self-Reported'**
  String get selfReported;

  /// No description provided for @createNewCampaign.
  ///
  /// In en, this message translates to:
  /// **'Create New Campaign'**
  String get createNewCampaign;

  /// No description provided for @campaignTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaign Title'**
  String get campaignTitle;

  /// No description provided for @campaignObjective.
  ///
  /// In en, this message translates to:
  /// **'Campaign Objective'**
  String get campaignObjective;

  /// No description provided for @deliverables.
  ///
  /// In en, this message translates to:
  /// **'Deliverables'**
  String get deliverables;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @slots.
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get slots;

  /// No description provided for @publishCampaign.
  ///
  /// In en, this message translates to:
  /// **'Publish Campaign'**
  String get publishCampaign;

  /// No description provided for @draftCampaign.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get draftCampaign;

  /// No description provided for @applicants.
  ///
  /// In en, this message translates to:
  /// **'Applicants'**
  String get applicants;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @reviewApplicants.
  ///
  /// In en, this message translates to:
  /// **'Review Applicants'**
  String get reviewApplicants;

  /// No description provided for @submitApplication.
  ///
  /// In en, this message translates to:
  /// **'Submit Application'**
  String get submitApplication;

  /// No description provided for @proposedRate.
  ///
  /// In en, this message translates to:
  /// **'Proposed Rate'**
  String get proposedRate;

  /// No description provided for @pitchNote.
  ///
  /// In en, this message translates to:
  /// **'Pitch Note'**
  String get pitchNote;

  /// No description provided for @explainWhyGoodFit.
  ///
  /// In en, this message translates to:
  /// **'Explain why you are the best fit for this brief...'**
  String get explainWhyGoodFit;

  /// No description provided for @submitPitch.
  ///
  /// In en, this message translates to:
  /// **'Submit Pitch'**
  String get submitPitch;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm Action'**
  String get confirmAction;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'GGs AI Assistant'**
  String get aiAssistant;

  /// No description provided for @aiDraftHelp.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant Help'**
  String get aiDraftHelp;

  /// No description provided for @aiSuggest.
  ///
  /// In en, this message translates to:
  /// **'Get AI Suggestions'**
  String get aiSuggest;

  /// No description provided for @aiApplySuggestion.
  ///
  /// In en, this message translates to:
  /// **'Accept & Apply Suggestion'**
  String get aiApplySuggestion;

  /// No description provided for @aiDiscardSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Discard Suggestion'**
  String get aiDiscardSuggestion;

  /// No description provided for @aiReviewNotice.
  ///
  /// In en, this message translates to:
  /// **'Review this AI suggestion before applying it to your data:'**
  String get aiReviewNotice;

  /// No description provided for @aiUnavailable.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant is currently offline or not configured.'**
  String get aiUnavailable;

  /// No description provided for @aiRateLimited.
  ///
  /// In en, this message translates to:
  /// **'AI assistant rate limit reached. Please wait a moment.'**
  String get aiRateLimited;

  /// No description provided for @aiDraftPitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Draft Application Pitch'**
  String get aiDraftPitchTitle;

  /// No description provided for @aiDraftBriefTitle.
  ///
  /// In en, this message translates to:
  /// **'Refine Campaign Brief'**
  String get aiDraftBriefTitle;

  /// No description provided for @aiSuggestDeliverables.
  ///
  /// In en, this message translates to:
  /// **'Suggest Deliverable Requirements'**
  String get aiSuggestDeliverables;

  /// No description provided for @aiProfileImprovements.
  ///
  /// In en, this message translates to:
  /// **'Suggest Profile Improvements'**
  String get aiProfileImprovements;

  /// No description provided for @aiExplainFilters.
  ///
  /// In en, this message translates to:
  /// **'Explain Search Filters'**
  String get aiExplainFilters;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @emptyState.
  ///
  /// In en, this message translates to:
  /// **'No records found'**
  String get emptyState;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
