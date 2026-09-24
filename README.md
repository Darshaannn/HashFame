# GGs Phase 1 Foundation

This repository is the production-oriented technical foundation for the GGs mobile product. Phase 1 deliberately contains identity, role-aware routing, account settings, private local caching, observability adapters, Supabase schema/security, and delivery automation only. Marketplace, campaigns, messaging, deals, payments, search infrastructure, and matching are outside this phase.

## Toolchain

- Flutter 3.47.5 stable / Dart 3.13.4 (the current compatible patch release)
- Android SDK with Java 17
- Xcode and CocoaPods for iOS builds (macOS only)
- Supabase CLI 2.117.0 and Docker for local backend work
- Deno 2 for Edge Function checks
- PostgreSQL client (`psql`) for the RLS suite

Package versions are locked in `apps/mobile/pubspec.lock` and `supabase/functions/deno.lock`. Do not commit production secrets, signing material, Firebase platform files, or generated environment overrides.

## Repository map

```text
apps/mobile/             Flutter modular monolith
  lib/app/               composition, providers and guarded router
  lib/core/              config, errors, design system, cache, telemetry
  lib/features/          vertical feature modules (data/domain/presentation)
apps/admin, apps/web/    reserved boundaries; no Phase-2 implementation
config/                  safe Dart define examples and iOS native identities
docs/                    checklist, architecture and validation handoff
scripts/                 local database and iOS environment helpers
supabase/migrations/     ordered, immutable PostgreSQL changes
supabase/functions/      trusted TypeScript/Deno operations
supabase/tests/          constraints, positive RLS and negative RLS tests
```

The mobile dependency direction is:

```text
UI -> controller/state -> repository -> remote/local data source
```

Widgets do not import or query Supabase. PostgreSQL is authoritative; Drift stores only a bounded own-account summary for a maximum of 24 hours and is cleared on logout, identity mismatch, restricted state, or non-connectivity failures.

## Configure environments

Copy an example before supplying real public configuration:

```bash
cp config/local.example.json config/local.json
cp config/staging.example.json config/staging.json
cp config/production.example.json config/production.json
```

The copied files are ignored. Only a Supabase publishable key (or legacy anonymous key) belongs in a mobile configuration. Never put a `service_role` secret in Flutter. Firebase values are public app identifiers, but the platform files and environment-specific values remain ignored.

Environment invariants are validated at startup:

- `APP_ENV` is `local`, `staging`, or `production`.
- Supabase uses HTTPS except for known emulator/loopback hosts in `local`.
- the auth callback is exactly `com.ggs.mobile.<environment>://auth/callback`.
- support URLs use HTTPS.
- Firebase collection is opt-in through `FIREBASE_ENABLED=true`.

Android has matching `local`, `staging`, and `production` product flavors. Before an iOS build, generate the ignored native override:

```bash
bash scripts/select-ios-environment.sh local
```

Replace `local` with `staging` or `production`; use the same environment's Dart JSON in the build command.

## Run the mobile app

Start Supabase first, copy the local config, then run:

```bash
cd apps/mobile
flutter pub get
flutter run --flavor local --dart-define-from-file=../../config/local.json
```

Android emulators use `10.0.2.2` to reach the host. For an iOS simulator or physical device, change the local URL to a host reachable by that device. OAuth providers also require their client IDs and redirect allow-list entries in Supabase; those external credentials are intentionally absent. Email OTP and Google are the launch authentication paths, with Apple shown on iOS. The repository contract is phone-OTP-ready, but phone verification is deliberately not exposed in Phase 1 because SMS must not be a launch dependency. Any later SMS provider credentials remain server-side and untracked.

## Local Supabase and migrations

```bash
supabase start
supabase db reset --local
psql postgresql://postgres:postgres@127.0.0.1:54322/postgres \
  --set ON_ERROR_STOP=1 --file supabase/tests/foundation.sql
```

`db reset` applies all eight migrations in filename order and then `supabase/seed.sql`. The seed uses only `.invalid` synthetic identities and is never a production migration. Make every schema change as a new ordered migration; do not edit a deployed migration or rely on dashboard-only changes.

For a standalone PostgreSQL instance with Supabase's minimum platform fixture, run `npm install`, set `PGHOST`, `PGPORT`, `PGUSER`, and `PGPASSWORD` if needed, then run `npm run test:postgres`. The script creates and removes two uniquely named disposable databases.

## Quality checks

```bash
cd apps/mobile
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test --coverage
dart run build_runner build

cd ../../supabase/functions
deno fmt --check
deno lint
deno check request-deletion/index.ts
deno test request-deletion/handler_test.ts
```

Build checks:

```bash
cd apps/mobile
flutter build apk --debug --flavor local --dart-define-from-file=../../config/local.json
flutter build apk --debug --flavor staging --dart-define-from-file=../../config/staging.json

# macOS only, after selecting the matching native environment
flutter build ios --simulator --debug --dart-define-from-file=../../config/staging.json
```

GitHub Actions repeats formatting, code generation consistency, analysis, Flutter tests, local/staging Android builds, a staging iOS simulator build, two clean database rebuilds with RLS tests, Edge Function checks, and a repository secret scan.

## Authentication and authorization

Email OTP, phone OTP, Google OAuth and Apple OAuth are represented behind `AuthRepository`. Phone numbers use E.164 format. A person explicitly selects one of four self-service professional roles; `admin` is server-assigned only. The database transaction `complete_onboarding` creates the primary role, activates the profile, and writes an audit event. Client metadata is never trusted for authorization.

The router distinguishes loading, unauthenticated, onboarding, active, restricted, expired/invalid, and error states. It redirects cross-role routes to the server-stored role. RLS remains the enforcement boundary even if a modified client bypasses the UI.

Admin assignment must be performed by a trusted operational process directly against the database and must create both the `professional_roles` row and matching `profiles.primary_role_label` in one reviewed transaction. There is intentionally no mobile/admin self-elevation endpoint.

## Operations and security

- Keep both storage buckets private. `verification` is default-deny until its later-phase trusted workflow exists.
- Treat account deletion as a request, not completed erasure. The Edge Function validates the bearer and calls the actor-derived RPC; support must complete the separate deletion runbook.
- Never log emails, tokens, raw exceptions, profile payloads, or arbitrary analytics parameters.
- Enable Firebase only after installing environment-specific native files and verifying a synthetic staging event, nonfatal crash, and performance trace contain no PII.
- Rotate a leaked credential immediately, remove it from history, and rerun the secret scan.
- When a user signs out or a session is invalid, both secure auth state and the Drift profile cache are cleared.

See [architecture decisions](docs/architecture-decisions.md), [the Phase-1 checklist](docs/phase1-checklist.md), and [validation handoff](docs/phase1-handoff.md) for rationale, current evidence, and blockers.
