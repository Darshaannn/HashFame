# GGs Mobile — Application Flow & Navigation Architecture

## 1. Executive Summary & Top-Level App Flow

The GGs Mobile application is architected around **One Coherent Experience** that separates Production Authentication from Demo Presentation Mode while maintaining unified UX components, seamless 5-tab bottom navigation shells, complete profile & settings management, and safe sign-out/role switching workflows.

```
                  ┌──────────────────────────────┐
                  │          App Start           │
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │       Splash / Startup       │
                  └──────────────┬───────────────┘
                                 │
                  ┌──────────────┴───────────────┐
                  │                              │
         [Production Mode]                 [Demo Mode]
                  │                              │
                  ▼                              ▼
    ┌───────────────────────────┐  ┌───────────────────────────┐
    │ Welcome / Role Select     │  │    Demo Role Launcher     │
    │ OTP Auth / Onboarding     │  │ (Brand / Creator / Agency)│
    └─────────────┬─────────────┘  └─────────────┬─────────────┘
                  │                              │
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │       Role Navigation Shell  │
                  │   (Brand / Creator / Agency) │
                  └──────────────┬───────────────┘
                                 │
        ┌──────────────┬─────────┴────────┬──────────────┐
        ▼              ▼                  ▼              ▼
    [Home]        [Discovery]       [Campaigns]      [Profile]
        │              │                  │              │
        ▼              ▼                  ▼              ▼
  Quick Actions  Search & Filter   Draft & Review   Edit / Settings
                                                         │
                                                         ▼
                                                    [Sign Out]
                                                         │
                                        ┌────────────────┴────────────────┐
                                        ▼                                 ▼
                                  [Production]                         [Demo]
                              Supabase Session Out             Return to Role Launcher
```

---

## 2. Production vs Demo Mode

### Production Mode
- **Entry**: `/startup` → `/welcome` → `/roles` → `/auth` → `/onboarding` → Role Home (`/home/brand_marketer`, `/home/creator`, `/home/agency`).
- **Authentication**: Supabase OTP authentication with strict Row Level Security (RLS) enforcement and cryptographic token persistence.
- **Sign Out**: Explicit confirmation sheet/dialog invoking `authRepository.logout()` and `accountRepository.clearCache()`, resetting state and redirecting to `/welcome`.

### Demo Mode
- **Entry**: `/demo` (Demo Role Launcher).
- **Session**: In-memory deterministic `DemoStore` state. Switching between roles updates active session snapshot immediately without touching production credentials or Supabase auth.
- **Demo Controls**: In-app "Switch Demo Role", "Reset Demo Data" (restores default seed roster), and "Exit Demo" (returns to `/demo`).

---

## 3. Role Information Architecture & Navigation Maps

### A. Brand Navigation (5 Tabs)
1. **Home** (`/home/brand_marketer`):
   - Organization Header (`GGProfileHeader`) displaying active company & marketer title.
   - Quick Action Tiles: *Discover Creators*, *Create Campaign*, *Manage Campaigns*, *Saved Shortlists*.
   - Managed Brand Lines Card displaying active brand portfolio & direct profile access.
2. **Discover** (`/discover`):
   - Live Search, Category/Language chips, City & Rate filters (`/discover/creator/:id`).
   - Shortlist Creator, Compare Creators (`/compare`).
3. **Campaigns** (`/campaigns`):
   - Active Campaign list, Draft creator briefs (`/campaigns/new`), Campaign applicant dashboard (`/campaigns/:id/applicants`).
4. **Shortlists** (`/shortlists`):
   - Curated creator rosters, custom notes, status pipeline (`/shortlists/:id`).
5. **Profile** (`/profile`):
   - Organization & Marketer summary (`GGProfileHeader`).
   - *Edit Brand Profile* (`/profile/edit/brand`) with live validation & form persistence.
   - *Account Settings* (`/settings`), *Help & Support*, *Privacy Policy*, *Sign Out* (`GGSignOutDialog`).

---

### B. Creator Navigation (5 Tabs)
1. **Home** (`/home/creator`):
   - Creator Header & Studio greeting.
   - Profile Completeness progress widget with direct recommendation navigation.
   - Quick Action Tiles: *Discover Brand Opportunities*, *My Campaign Applications*, *Manage Rate Card*, *Add Portfolio Samples*.
2. **Discover Work** (`/opportunities`):
   - Live brand casting calls, compensation badges, category match filters (`/opportunities/:campaignId`).
   - One-tap campaign application flow.
3. **Applications** (`/applications`):
   - Status tracking timeline (Applied → Under Review → Shortlisted → Selected).
   - Application Detail view (`/applications/:applicationId`).
4. **Activity** (`/activity`):
   - Real-time updates & alerts (Application approvals, Shortlist notifications, Rate synchronizations).
5. **Profile** (`/profile`):
   - Creator Public Profile with verification badges and completeness indicator.
   - Full editor sub-flows:
     - *Edit Basic Profile* (`/profile/edit`)
     - *Rate Card* (`/profile/edit/rates`)
     - *Portfolio & Work Samples* (`/profile/edit/portfolio`)
     - *Social Accounts* (`/profile/edit/socials`)
     - *Collaborations* (`/profile/edit/collabs`)
   - Availability Switcher (*Open*, *Limited*, *Unavailable*).
   - *Account Settings* (`/settings`) & *Sign Out* (`GGSignOutDialog`).

---

### C. Agency Navigation (5 Tabs)
1. **Home** (`/home/agency`):
   - Agency Workspace Header with director title & agency organization name.
   - Quick Action Tiles: *Discover & Search Creators*, *Client Campaigns*, *Managed Talent Roster*, *Agency Profile & Services*.
   - Agency Organization summary card.
2. **Discover** (`/discover`):
   - Unified creator intelligence search & scout engine.
3. **Campaigns** (`/campaigns`):
   - Client proposals and campaign management.
4. **Talent** (`/talent`):
   - Managed talent roster showcasing represented creators, follower metrics, and rates.
5. **Profile** (`/profile`):
   - Agency overview, location, website, and services offered.
   - *Edit Agency Profile* (`/profile/edit/agency`) with live validation & form persistence.
   - *Account Settings* (`/settings`), *Priority Support Desk*, *Sign Out* (`GGSignOutDialog`).

---

## 4. Profile & Settings Hierarchy

Settings is unified across all roles and is accessible from the Profile screen and AppBar actions:

```
[Profile Screen]
  ├── GGProfileHeader (Avatar, Name, Role, Organization, Verified Status)
  ├── Role-Specific Cards (Completeness, Bio, Rates, Portfolio, Managed Brands, Agency Overview)
  ├── GGSettingsSection: "Account"
  │     ├── Edit Profile Action Tile (leads to role-specific edit page)
  │     ├── Sub-flow Tiles (Rate Card, Portfolio, Socials, Talent Roster)
  │     ├── Account Settings Tile (leads to /settings)
  │     ├── Help & Support (Snackbars / support URL integration)
  │     └── Sign Out Tile (triggers GGSignOutDialog)
  └── GGDemoControlsCard (Demo Mode only)
        ├── Switch Demo Role
        ├── Reset Demo Data
        └── Exit Demo Mode

[Settings Screen (/settings)]
  ├── Account Information (Display Name Form + Save validation)
  ├── Preferences (Notification switches, System theme display)
  ├── Security (Authentication verification, Account deletion request dialog)
  ├── Support & Legal (Concierge support, Terms of Service, Privacy Policy, About GGs)
  ├── Session (Sign Out Tile)
  └── Demo Controls Card (Demo Mode only)
```

---

## 5. Unified Reusable Components

Located in `lib/features/profile_common/presentation/widgets/unified_profile_widgets.dart`:
- **`GGProfileHeader`**: Standardized header with avatar, name, handle, role/title, organization badge, verification icon, and optional edit button.
- **`GGOrganizationBadge`**: Organization/agency indicator.
- **`GGSettingsSection`**: Clean section container with header and grouped children.
- **`GGAccountActionTile`**: Consistent list tile for navigation actions with subtitles, leading icons, chevron indicators, and destructive styling support.
- **`GGSignOutDialog`**: Polished confirmation dialog with clear destructive action styling.
- **`GGDemoControlsCard`**: Persistent demo switcher card offering Switch Role, Reset Data, and Exit Demo actions.

---

## 6. Route Registry

| Path | Name | Description | Guard / Protection |
|---|---|---|---|
| `/demo` | `demo_launcher` | Demo Role Selector Screen | Public / Demo Mode |
| `/welcome` | `welcome` | Production Welcome Landing | Unauthenticated |
| `/roles` | `roles` | Production Role Choice | Unauthenticated |
| `/auth` | `auth` | Production OTP Authentication | Unauthenticated (Role required) |
| `/onboarding` | `onboarding` | Multi-step user onboarding | Onboarding phase |
| `/home/brand_marketer` | `home_brand_marketer` | Brand 5-Tab Workspace | Ready (Brand) |
| `/home/creator` | `home_creator` | Creator 5-Tab Studio | Ready (Creator) |
| `/home/agency` | `home_agency` | Agency 5-Tab Workspace | Ready (Agency) |
| `/discover` | `discover` | Creator Intelligence Search | Ready (All) |
| `/discover/creator/:id`| `discover_creator_detail` | Public Creator Profile | Ready (All) |
| `/shortlists` | `shortlists` | Shortlist Management | Ready (Brand / Agency) |
| `/compare` | `compare` | Multi-creator comparison | Ready (Brand / Agency) |
| `/opportunities` | `opportunities` | Creator Opportunities Feed | Ready (Creator) |
| `/applications` | `my_applications` | Creator Applications Tracker | Ready (Creator) |
| `/activity` | `creator_activity` | Creator Activity & Notifications | Ready (Creator) |
| `/talent` | `agency_talent` | Agency Represented Roster | Ready (Agency) |
| `/campaigns` | `brand_campaigns` | Campaign Management Feed | Ready (Brand / Agency) |
| `/campaigns/new` | `campaign_create` | Brief Creator Flow | Ready (Brand / Agency) |
| `/profile` | `profile` | Role Profile Root | Ready (All) |
| `/profile/edit` | `profile_edit` | Creator Profile Editor | Ready (Creator) |
| `/profile/edit/brand` | `profile_edit_brand` | Brand Profile Editor | Ready (Brand) |
| `/profile/edit/agency`| `profile_edit_agency` | Agency Profile Editor | Ready (Agency) |
| `/profile/edit/rates` | `profile_edit_rates` | Rate Card Management | Ready (Creator) |
| `/profile/edit/portfolio`| `profile_edit_portfolio`| Portfolio Management | Ready (Creator) |
| `/profile/edit/socials`| `profile_edit_socials` | Social Accounts Editor | Ready (Creator) |
| `/profile/edit/collabs`| `profile_edit_collabs` | Collabs Editor | Ready (Creator) |
| `/settings` | `settings` | Unified App Settings | Ready (All) |
