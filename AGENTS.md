# FieldTrust Agent Guide

This document defines non-negotiable product and engineering rules for any coding agent working in this repository.

## Product definition

FieldTrust is a **local-first work proof camera** for solo contractors and small field teams (roughly 1–10 people).

Core workflow:

**Project → Capture → Proof → Report**

Do not turn FieldTrust into a general-purpose construction management suite.

## Non-negotiable engineering rules

### 1. Local persistence comes first

> A photo is considered captured only after it has been safely persisted locally.

Cloud upload success must never determine whether capture is considered complete.

### 2. Offline-first behavior

All core field workflows must function with no network connection:

- open/create projects
- capture photos
- assign capture type
- read/write notes
- browse existing locally available photos
- queue sync jobs
- generate a basic local report where feasible

Cloud synchronization must never block field work.

### 3. Durable sync queue

Every upload is represented as a durable local sync job. Jobs must survive process death, device reboot, app upgrades, and temporary authentication/network failures.

Expected state progression:

`local_saved → queued → uploading → object_uploaded → metadata_synced → synced`

Retries must be idempotent.

### 4. Proof metadata is immutable by default

Capture metadata must preserve:

- captured timestamp
- latitude / longitude when available
- reported location accuracy
- location source
- project ID
- capture mode (`before`, `after`, `progress`, `issue`)
- device / capture context where legally and technically appropriate
- SHA-256 of the locally persisted original

Do not silently rewrite capture metadata after the fact.

### 5. Be honest about location confidence

Never present low-confidence positioning as precise GPS proof.

UI should distinguish at least:

- good accuracy
- degraded accuracy
- unreliable / unavailable

Persist the actual reported accuracy value and source.

### 6. Mobile-first, field-first UI

Use `shadcn_ui` as the component system, not as a reason to make the product look like a desktop SaaS dashboard.

The camera surface should remain camera-first with minimal chrome. Large touch targets and one-handed use matter more than dense information.

### 7. Prefer simple workflows

A worker should not need to complete multi-field forms during capture. Prefer:

- project auto-selection / nearby suggestion
- one-tap capture modes
- voice notes
- sensible defaults

### 8. Privacy and data ownership

Users own their job media and reports. Export must not be artificially blocked. Sensitive location data must be handled deliberately and documented.

### 9. Avoid premature platform complexity

For MVP, use Firebase for cloud services and keep storage abstraction clean enough to move large-object archival to Cloudflare R2 later.

Do not add R2 complexity until required, but do not couple domain models to Firebase Storage URLs.

### 10. No speculative feature creep

Do not add CRM, invoicing, employee time tracking, scheduling, payroll, social feeds, complex BIM, or enterprise admin features unless explicitly approved.

## Required Flutter stack

Unless a documented architecture decision changes this:

- Flutter
- Riverpod
- go_router
- shadcn_ui
- Drift / SQLite for durable local state
- Firebase Auth
- Cloud Firestore
- Firebase Storage initially

## Suggested source organization

```text
lib/
  app/
  core/
    database/
    storage/
    sync/
    location/
    security/
  features/
    onboarding/
    projects/
    capture/
    gallery/
    reports/
    search/
    settings/
  shared/
    widgets/
    theme/
```

Features should depend on abstractions in `core`, not directly on Firebase SDKs where practical.

## Definition of done for capture

A successful capture means:

1. camera result exists
2. file is atomically persisted to app-managed local storage
3. SHA-256 is computed and stored
4. local photo row is committed
5. capture UI confirms `Saved locally`
6. sync job is queued independently

Only after these steps may background cloud sync begin.

## Verification language

Use wording such as:

- `Verified by FieldTrust`
- `Report integrity verified`
- `Timestamp and hash recorded`

Do not claim legal admissibility, legal validity, chain-of-custody status, or evidentiary guarantees unless a future legal review explicitly supports those claims.

## Testing priorities

Prioritize tests around failure modes:

- capture while offline
- kill app immediately after capture
- upload interruption / resume
- duplicate retry
- low storage
- low GPS accuracy
- auth expiration
- partial sync
- report generated from partially synced media

Reliability tests are more important than snapshot-heavy UI tests in the MVP.
