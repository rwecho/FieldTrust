# FieldTrust Technical Architecture

## 1. Architecture goals

FieldTrust must prioritize field reliability over cloud convenience.

Primary goals:

- local-first capture
- offline-first workflows
- durable background synchronization
- clear separation between local domain state and cloud providers
- low operational cost
- simple path from solo-user MVP to small-team SaaS

## 2. High-level architecture

```text
Flutter App
  ├─ UI / Features
  ├─ Domain / Repositories
  ├─ Local Persistence
  │   ├─ Drift / SQLite
  │   └─ App-managed media files
  ├─ Sync Engine
  ├─ Location / Camera / Hashing
  └─ Cloud Adapters
      ├─ Firebase Auth
      ├─ Firestore
      └─ Firebase Storage (initial)

Future large-object path:
  Cloudflare R2
```

## 3. Flutter application layers

Suggested structure:

```text
lib/
  app/
    app.dart
    router.dart
    bootstrap.dart
  core/
    database/
    storage/
    sync/
    location/
    camera/
    security/
    network/
    firebase/
  features/
    onboarding/
    projects/
    capture/
    gallery/
    reports/
    search/
    settings/
  shared/
    theme/
    widgets/
    models/
```

Feature code should consume repositories/services rather than calling Firebase directly.

## 4. Local persistence

### Drift / SQLite

Use for:

- projects
- photo records
- tags / areas
- before-after relationships
- notes
- sync jobs
- report drafts
- local settings

### App-managed file storage

Persist capture files to deterministic app-controlled paths before considering capture complete.

Suggested shape:

```text
media/
  projects/{projectId}/
    originals/{photoId}.jpg
    thumbs/{photoId}.jpg
```

Use atomic write/move semantics where platform APIs allow it.

## 5. Capture transaction

Expected sequence:

1. camera plugin returns a temporary capture
2. generate `photoId`
3. move/copy to app-managed local storage
4. verify file exists and is readable
5. compute SHA-256
6. obtain location snapshot and accuracy metadata
7. commit local photo row
8. enqueue sync job
9. return success to UI: `Saved locally`

If any step before local DB commit fails, surface capture failure clearly.

Cloud operations never participate in this transaction.

## 6. Location model

Persist:

- latitude
- longitude
- horizontal accuracy
- captured location timestamp
- source / provider where exposed
- project-location fallback usage
- user acknowledgement when continuing with low accuracy, if implemented

Suggested confidence bands are product-configurable rather than hard-coded everywhere.

Initial example:

- good: <= 15 m
- degraded: >15 m and <=50 m
- unreliable: >50 m

The exact thresholds should be tested in real environments.

## 7. Sync engine

Sync jobs are durable rows in SQLite.

Example states:

```text
queued
uploading_object
object_uploaded
syncing_metadata
synced
retry_wait
permanent_error
```

Requirements:

- idempotent retries
- exponential backoff with jitter
- network-aware execution
- auth refresh handling
- checksums / object identity to avoid duplicate uploads
- ability to resume after process death
- visible user status for stuck jobs

## 8. Firebase role

### Firebase Auth

Used for account and future team identity.

MVP should allow local-only use before sign-in if practical.

### Firestore

Use for cloud metadata:

- users
- organizations
- memberships
- projects
- photo metadata
- report metadata
- verification records

Do not treat Firestore offline cache as the authoritative local database.

### Firebase Storage

Initial media cloud target for speed of implementation.

Keep a storage abstraction so the rest of the app stores object keys / media references, not Firebase-specific download URLs as domain identity.

### Crashlytics / Analytics

Useful after core flows work. Do not delay MVP capture reliability to integrate analytics deeply.

## 9. Cloudflare R2 path

R2 is planned for cost control once media volume justifies additional complexity.

Potential policy:

- thumbnails remain optimized for frequent access
- compressed display originals remain hot
- full-resolution originals archive to R2
- Firestore stores object metadata and provider-agnostic keys

Do not implement multi-provider storage until operational cost or product requirements justify it.

## 10. Media processing

On device, where practical:

- preserve original local file
- generate display-sized image (e.g. max long edge around 2560 px)
- generate small thumbnail (e.g. around 512 px)

Exact compression settings must be tested for field readability and cost.

Never overwrite the local proof original when creating optimized variants.

## 11. Hashing and verification

For each original:

- compute SHA-256 after local persistence
- store hash locally
- sync hash with metadata

For reports:

- generate stable report manifest
- hash canonical manifest / exported artifact according to documented versioned rules
- store report verification record
- generate verification URL/QR

Verification implementation must be versioned so future format changes do not invalidate historical reports.

## 12. AI architecture

AI is an enhancement, not a capture dependency.

Initial use:

- speech-to-text
- cleanup of rough field notes

Rules:

- AI failure must never block saving a note/photo
- preserve or make available raw source text when feasible
- AI must not invent facts not present in user input or media

Future:

- image description
- semantic search
- before/after change summaries

## 13. Security

- use Firebase security rules with explicit ownership/team membership checks
- no public writable buckets
- verification pages expose only intended report metadata
- use signed / controlled object access where appropriate
- sensitive exact location must not become public accidentally through share links

## 14. Background execution

Mobile OS background limits differ by platform. Design the sync engine to make progress when app is active and opportunistically in background, without promising uninterrupted background upload.

Always show truthful sync state.

## 15. Failure cases to design first

- user captures while completely offline
- app killed one second after capture
- phone reboots with queued uploads
- upload completes but metadata write fails
- metadata write succeeds after duplicate retry
- auth token expires mid-sync
- low disk space
- user revokes location permission
- location accuracy degrades indoors
- cloud quota/storage error

These are product flows, not edge cases.
