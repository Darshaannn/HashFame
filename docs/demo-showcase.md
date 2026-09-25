# GGs Mobile — Showcase Demo Guide & Architecture

## 1. Overview & Purpose

The **GGs Showcase Demo** is a fully functional, offline-resilient, boss-presentation-ready mobile experience. It demonstrates the complete two-sided creator economy workflow — from Brand discovery, advanced multi-facet filtering, shortlisting, and multi-creator comparison, to Creator opportunity discovery, application submissions, and dynamic review workflows with instantaneous cross-role status synchronization.

---

## 2. Safe & Isolated Demo Architecture

The production architecture remains untouched:
```
UI (Widgets & Design System)
       ↑
Riverpod Controllers & State Notifiers
       ↑
Domain Repositories (Interface Contracts)
     ↙                     ↘
Supabase Production      In-Memory DemoStore
Repositories             & Demo Repositories
(lib/features/*/data)    (lib/demo/)
```

- **Entrypoint Separation**:
  - `lib/main.dart` boots the live production / local Supabase app with remote data sources, secure PKCE session storage, and database persistence.
  - `lib/main_demo.dart` boots the Demo experience with in-memory `DemoRepository` overrides in `ProviderScope`.
- **Zero Widget-Level Flags**: Widgets do not use `if (demoMode)` checks. Every screen uses the exact same production Riverpod providers and controllers.
- **Security & RLS**: Production authentication rules, role guards, and database migrations remain unaltered.

---

## 3. Demo Launch Experience & Role Switching

1. **GGs Launch Screen**:
   - Displays the GGs brand identity (*"Creator Collaboration, simplified."*).
   - Prominent action cards:
     - **VIEW AS BRAND** (Primary workflow: discover creators, create campaigns, review applications).
     - **VIEW AS CREATOR** (Browse opportunity feed, pitch, submit applications, track review milestones).
     - **VIEW AS AGENCY** (Talent representation profile).
2. **Persistent Demo Top Bar (`DemoTopBanner`)**:
   - An unobtrusive header badge clearly indicates `DEMO MODE` and the active role.
   - Includes a popup menu allowing live role switching without restarting the app.
   - **Reset Demo Data**: Instantaneously resets the in-memory store to its pristine, deterministic seed state.

---

## 4. Seeded Data Summary

- **12 Diverse Indian Creators**: Across Mumbai, Delhi, Bengaluru, Pune, Hyderabad, and Chennai (e.g. *Aisha Mehta, Riya Kapoor, Rohan Sharma, Priya Iyer, Kabir Singhania, Tanvi Deshmukh*).
- **5 Comprehensive Campaigns**:
  1. *Glow Forward — Festive Beauty Creator Campaign* (Nova Beauty India, Paid & Barter, 5 slots).
  2. *Nova Active — Morning Workout Fuel Sprint* (Nova Active, Paid, 4 slots).
  3. *Coastal Heritage Staycation Campaign* (Nova Escapes, Barter, 3 slots).
  4. *UGC Ad Creative Sprint — Meta & YouTube Shorts* (Nova Beauty India, Paid, 6 slots).
  5. *NextGen Pro Audio Wireless Earbuds Launch* (Nova Audio Labs, Paid & Barter, 4 slots).
- **3 Curated Shortlists**: *Festive Beauty Launch*, *Bengaluru Fitness Sprint*, *Tech & Gaming Roster*.
- **Initial Applications**: Realistic application pitches with compensation rates and review audit history.

---

## 5. Boss Demo Presentation Storyline (3–5 Minutes)

### Story A: Brand Discovery, Shortlisting & Comparison
1. Launch app via `main_demo.dart` and tap **VIEW AS BRAND**.
2. Brand Home displays live metrics (*5 Live Campaigns*, *3 Applications to Review*, *7 Saved Creators*).
3. Tap **Discover Creators** (or the bottom navigation *Discover* tab).
4. Type `"Fashion"` or `"Mumbai"` in the search field to filter in real-time.
5. Tap **Filters** to open the filter bottom sheet and toggle categories/cities/rate ranges.
6. Tap on **Aisha Mehta** to inspect her full Creator Profile (Bio, Rate Cards, Portfolio, Verified Socials).
7. Tap **Add to Shortlist** to save her to *Festive Beauty Launch*.
8. Return to Discover, select 2 creators, and tap **Compare Creators** to view side-by-side metric tables.

### Story B: Creator Opportunity Feed & Application Submission
9. In the top bar demo menu, tap **Switch Role → View as Creator**.
10. Navigate to **Discover Work** to view the live brand briefs and opportunity cards.
11. Tap on **Glow Forward — Festive Beauty Campaign**.
12. Review deliverables, compensation (₹25K–₹50K + Hamper), and usage rights.
13. Tap **Apply**, enter a pitch and proposed rate, and submit.
14. A success state confirms submission. Navigate to **My Applications** to verify the `Submitted` milestone badge.

### Story C & D: Live Two-Sided Status Transition
15. Switch back to **Brand** role via the top bar demo menu.
16. Open **Campaigns → Glow Forward → Applicants**.
17. The newly submitted application appears at the top.
18. Change application status to **Under Review**, then **Shortlisted**, then **Selected**.
19. Switch back to **Creator** role.
20. Check **My Applications** — the status immediately reflects **Selected**.

---

## 6. Commands to Run & Build

### Run Demo Mode Locally
```bash
flutter run --flavor local -t lib/main_demo.dart
```

### Build Demo Android APK
```bash
flutter build apk --flavor local --debug -t lib/main_demo.dart
```
**APK Location**: `apps/mobile/build/app/outputs/flutter-apk/app-local-debug.apk`

### Run All Tests & Lint Analysis
```bash
cd apps/mobile
flutter test
flutter analyze lib test
```

---

## 7. Known Demo Scope & Limitations
- All mutations update the in-memory `DemoStore` during the app session; state is intentionally reset when clicking **Reset Demo Data** or restarting the app.
- No network connection or external image server is required (all avatars, badges, and cards use bundled offline vector assets and design tokens).
- Fabricated intelligence metrics (e.g. fake predictive fit percentages or simulated follower fraud scores) are strictly excluded in adherence to product integrity standards.
