# Phase 1 architecture decisions

## Modular monolith

- Requirement: a simple foundation that can scale without a rewrite.
- Choice: one Flutter application organized by feature, backed by one Supabase/PostgreSQL project.
- Reason: preserves clear module boundaries without deployment or operational overhead.
- Alternative considered: separate services or packages per feature.
- Impact: future features add vertical modules and repository interfaces; service extraction remains possible only when justified.

## Authorization source of truth

- Requirement: client UI restrictions are insufficient; admin cannot be self-assigned.
- Choice: Supabase Auth proves identity, while normalized role rows, transactional RPCs and PostgreSQL RLS decide authorization.
- Reason: a modified mobile client cannot bypass database policy or trusted role assignment.
- Alternative considered: auth metadata and route-only authorization.
- Impact: privileged changes require a reviewed server/operations path; the client contains no service-role credential.

## Cache boundary

- Requirement: Drift/SQLite supports fast and offline UI while the server stays authoritative.
- Choice: cache only the signed-in user's display summary for up to 24 hours; omit avatar data and clear on logout, identity mismatch, restricted state, malformed data and non-connectivity failures.
- Reason: minimizes stale or sensitive local data and prevents cache fallback from masking authorization/server errors.
- Alternative considered: caching full account/settings responses or indefinite stale-while-revalidate.
- Impact: offline mode is explicitly read-only and intentionally limited.

## Session persistence

- Requirement: secure session lifecycle and logout cleanup.
- Choice: replace Supabase's default local persistence with `flutter_secure_storage` for sessions and PKCE verifiers, namespaced per environment.
- Reason: prevents environment collisions and avoids plain preference storage for bearer material.
- Alternative considered: SDK default storage.
- Impact: platform secure-storage capabilities are required; logout always attempts cache/role cleanup even if the auth adapter reports failure.

## Environment identity

- Requirement: local, staging and production isolation.
- Choice: validated Dart define JSON, Android product flavors, and an ignored generated iOS xcconfig selected from tracked non-secret identities.
- Reason: logical API/auth settings and native bundle/callback identifiers cannot drift silently.
- Alternative considered: a single bundle identifier with runtime-only switches.
- Impact: iOS builds must run the selector before Flutter; CI does this explicitly.

## Deletion semantics

- Requirement: provide a secure account-deletion foundation without claiming asynchronous erasure is complete.
- Choice: an actor-derived, idempotent PostgreSQL request plus a bearer-validating Deno endpoint; the app currently invokes the same RLS-controlled RPC directly because no elevated privilege is needed.
- Reason: the request immediately restricts the account and creates an immutable receipt without accepting a target user ID.
- Alternative considered: mobile-supplied user ID or immediate cascading deletion.
- Impact: a later reviewed operations process must complete legal/physical deletion and report status.

## Observability

- Requirement: analytics, crashes and performance monitoring without sensitive logs.
- Choice: fixed event enum, allow-listed trace names, sanitized failure kinds/correlation IDs, no event parameters and no-op adapters unless Firebase is explicitly enabled.
- Reason: minimizes accidental PII collection and prevents telemetry failure from breaking product flows.
- Alternative considered: direct Firebase calls throughout features.
- Impact: staging Firebase configuration and live console evidence remain an external exit-gate step.
