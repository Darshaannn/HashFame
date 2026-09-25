import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/config/app_config.dart';
import '../core/design_system/gallery_screen.dart';
import '../demo/demo_launcher_screen.dart';
import '../features/account/domain/account.dart';
import '../features/account/presentation/account_screens.dart';
import '../features/activity/presentation/activity_screen.dart';
import '../features/agency/presentation/agency_screens.dart';
import '../features/agency/presentation/agency_talent_screen.dart';
import '../features/agency/presentation/edit_agency_profile_screen.dart';
import '../features/auth/presentation/auth_screens.dart';
import '../features/auth/presentation/session_controller.dart';
import '../features/brand/presentation/brand_screens.dart';
import '../features/brand/presentation/edit_brand_profile_screen.dart';
import '../features/creator/presentation/edit/edit_collaborations_screen.dart';
import '../features/creator/presentation/edit/edit_creator_profile_screen.dart';
import '../features/creator/presentation/edit/edit_portfolio_screen.dart';
import '../features/creator/presentation/edit/edit_rate_card_screen.dart';
import '../features/creator/presentation/edit/edit_socials_screen.dart';
import '../features/creator/presentation/home/creator_home_screen.dart';
import '../features/creator/presentation/onboarding/creator_onboarding_screen.dart';
import '../features/creator/presentation/profile/creator_profile_screen.dart';
import '../features/discovery/presentation/creator_public_detail_screen.dart';
import '../features/discovery/presentation/discover_screen.dart';
import '../features/profile_common/presentation/generic_role_shell.dart';
import '../features/shortlist/presentation/shortlist_detail_screen.dart';
import '../features/shortlist/presentation/shortlists_screen.dart';
import '../features/comparison/presentation/creator_comparison_screen.dart';
import '../features/talent_manager/presentation/talent_manager_screens.dart';
import '../features/campaign/presentation/brand_campaigns_screen.dart';
import '../features/campaign/presentation/campaign_applicant_dashboard_screen.dart';
import '../features/campaign/presentation/campaign_creation_screen.dart';
import '../features/campaign/presentation/campaign_detail_screen.dart';
import '../features/campaign/presentation/creator_application_detail_screen.dart';
import '../features/campaign/presentation/creator_applications_screen.dart';
import '../features/campaign/presentation/creator_opportunities_screen.dart';
import 'providers.dart';

String homePath(ProfessionalRole role) => '/home/${role.wire}';

String? routeRedirect(
  SessionState session,
  String path, {
  ProfessionalRole? selectedRole,
  bool galleryAllowed = false,
}) {
  final destination = switch (session.phase) {
    SessionPhase.loading => path == '/demo' ? '/demo' : '/startup',
    SessionPhase.unauthenticated =>
      ['/welcome', '/roles', '/demo'].contains(path) ||
              (path == '/auth' && selectedRole != null)
          ? path
          : '/welcome',
    SessionPhase.onboarding => '/onboarding',
    SessionPhase.restricted || SessionPhase.error => '/status',
    SessionPhase.ready =>
      (path == homePath(session.snapshot!.account.primaryRoleLabel!) ||
              path == '/demo' ||
              path == '/profile' ||
              path.startsWith('/profile/edit') ||
              path == '/discover' ||
              path.startsWith('/discover/creator/') ||
              path == '/shortlists' ||
              path.startsWith('/shortlists/') ||
              path == '/compare' ||
              path == '/opportunities' ||
              path.startsWith('/opportunities/') ||
              path == '/applications' ||
              path.startsWith('/applications/') ||
              path == '/activity' ||
              path == '/talent' ||
              path == '/campaigns' ||
              path == '/campaigns/new' ||
              path.startsWith('/campaigns/') ||
              (path == '/settings' && session.snapshot?.offline == false) ||
              (path == '/gallery' && galleryAllowed))
          ? path
          : homePath(session.snapshot!.account.primaryRoleLabel!),
  };
  return path == destination ? null : destination;
}

class RouterRefresh extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = RouterRefresh();
  ref.listen(sessionProvider, (_, next) => refresh.refresh());
  ref.listen(selectedRoleProvider, (_, next) => refresh.refresh());
  final router = GoRouter(
    initialLocation: ref.read(configProvider).name == 'GGs Demo'
        ? '/demo'
        : '/startup',
    refreshListenable: refresh,
    redirect: (_, state) => routeRedirect(
      ref.read(sessionProvider),
      state.uri.path,
      selectedRole: ref.read(selectedRoleProvider),
      galleryAllowed:
          ref.read(configProvider).environment != AppEnvironment.production,
    ),
    routes: [
      GoRoute(
        path: '/demo',
        name: 'demo_launcher',
        builder: (_, state) => const DemoLauncherScreen(),
      ),
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (_, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/roles',
        name: 'roles',
        builder: (_, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (_, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) {
          final role = ref.read(selectedRoleProvider);
          if (role == ProfessionalRole.creator) {
            return const CreatorOnboardingScreen();
          }
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/startup',
        name: 'startup',
        builder: (_, state) => const SessionStatusScreen(),
      ),
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (_, state) => const SessionStatusScreen(),
      ),
      GoRoute(
        path: '/status',
        name: 'status',
        builder: (_, state) => const SessionStatusScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          final primaryRole = ref
              .read(sessionProvider)
              .snapshot
              ?.account
              .primaryRoleLabel;
          return switch (primaryRole) {
            ProfessionalRole.creator => const CreatorProfileScreen(),
            ProfessionalRole.brandMarketer => const BrandProfileScreen(),
            ProfessionalRole.agency => const AgencyProfileScreen(),
            ProfessionalRole.talentManager =>
              const TalentManagerProfileScreen(),
            _ => const ProfileScreen(),
          };
        },
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'profile_edit',
        builder: (_, state) => const EditCreatorProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit/brand',
        name: 'profile_edit_brand',
        builder: (_, state) => const EditBrandProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit/agency',
        name: 'profile_edit_agency',
        builder: (_, state) => const EditAgencyProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit/socials',
        name: 'profile_edit_socials',
        builder: (_, state) => const EditSocialsScreen(),
      ),
      GoRoute(
        path: '/profile/edit/rates',
        name: 'profile_edit_rates',
        builder: (_, state) => const EditRateCardScreen(),
      ),
      GoRoute(
        path: '/profile/edit/portfolio',
        name: 'profile_edit_portfolio',
        builder: (_, state) => const EditPortfolioScreen(),
      ),
      GoRoute(
        path: '/profile/edit/collabs',
        name: 'profile_edit_collabs',
        builder: (_, state) => const EditCollaborationsScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/gallery',
        name: 'gallery',
        builder: (_, state) => const GalleryScreen(),
      ),

      // Discovery & Shortlists
      GoRoute(
        path: '/discover',
        name: 'discover',
        builder: (_, state) => const DiscoverScreen(),
      ),
      GoRoute(
        path: '/discover/creator/:creatorId',
        name: 'discover_creator_detail',
        builder: (_, state) => CreatorPublicDetailScreen(
          creatorId: state.pathParameters['creatorId']!,
        ),
      ),
      GoRoute(
        path: '/shortlists',
        name: 'shortlists',
        builder: (_, state) => const ShortlistsScreen(),
      ),
      GoRoute(
        path: '/shortlists/:shortlistId',
        name: 'shortlist_detail',
        builder: (_, state) => ShortlistDetailScreen(
          shortlistId: state.pathParameters['shortlistId']!,
        ),
      ),
      GoRoute(
        path: '/compare',
        name: 'compare',
        builder: (_, state) => const CreatorComparisonScreen(),
      ),

      // Creator Opportunities, Applications & Activity
      GoRoute(
        path: '/opportunities',
        name: 'opportunities',
        builder: (_, state) => const CreatorOpportunitiesScreen(),
      ),
      GoRoute(
        path: '/opportunities/:campaignId',
        name: 'opportunity_detail',
        builder: (_, state) => CampaignDetailScreen(
          campaignId: state.pathParameters['campaignId']!,
        ),
      ),
      GoRoute(
        path: '/applications',
        name: 'my_applications',
        builder: (_, state) => const CreatorApplicationsScreen(),
      ),
      GoRoute(
        path: '/applications/:applicationId',
        name: 'application_detail',
        builder: (_, state) => CreatorApplicationDetailScreen(
          applicationId: state.pathParameters['applicationId']!,
        ),
      ),
      GoRoute(
        path: '/activity',
        name: 'creator_activity',
        builder: (_, state) => const ActivityScreen(),
      ),

      // Agency Talent
      GoRoute(
        path: '/talent',
        name: 'agency_talent',
        builder: (_, state) => const AgencyTalentScreen(),
      ),

      // Brand & Agency Campaigns
      GoRoute(
        path: '/campaigns',
        name: 'brand_campaigns',
        builder: (_, state) => const BrandCampaignsScreen(),
      ),
      GoRoute(
        path: '/campaigns/new',
        name: 'campaign_create',
        builder: (_, state) => const CampaignCreationScreen(),
      ),
      GoRoute(
        path: '/campaigns/:campaignId/edit',
        name: 'campaign_edit',
        builder: (_, state) => CampaignCreationScreen(
          draftCampaignId: state.pathParameters['campaignId'],
        ),
      ),
      GoRoute(
        path: '/campaigns/:campaignId',
        name: 'brand_campaign_detail',
        builder: (_, state) => CampaignDetailScreen(
          campaignId: state.pathParameters['campaignId']!,
        ),
      ),
      GoRoute(
        path: '/campaigns/:campaignId/applicants',
        name: 'campaign_applicants',
        builder: (_, state) => CampaignApplicantDashboardScreen(
          campaignId: state.pathParameters['campaignId']!,
        ),
      ),

      // Primary Role Homes
      GoRoute(
        path: homePath(ProfessionalRole.creator),
        name: 'home_creator',
        builder: (context, state) => const CreatorHomeScreen(),
      ),
      GoRoute(
        path: homePath(ProfessionalRole.brandMarketer),
        name: 'home_brand_marketer',
        builder: (context, state) => const BrandHomeScreen(),
      ),
      GoRoute(
        path: homePath(ProfessionalRole.agency),
        name: 'home_agency',
        builder: (context, state) => const AgencyHomeScreen(),
      ),
      GoRoute(
        path: homePath(ProfessionalRole.talentManager),
        name: 'home_talent_manager',
        builder: (context, state) => GenericRoleShell(
          currentIndex: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          onNavigationIndexChanged: (idx) {
            if (idx == 1) context.go('/profile');
          },
          child: const TalentManagerHomeScreen(),
        ),
      ),
      GoRoute(
        path: homePath(ProfessionalRole.admin),
        name: 'home_admin',
        builder: (_, state) =>
            const RoleHomeScreen(role: ProfessionalRole.admin),
      ),
      GoRoute(
        path: '/callback',
        name: 'auth_callback',
        builder: (_, state) => const SessionStatusScreen(),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});
