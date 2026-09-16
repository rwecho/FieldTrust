# FieldTrust Data Model

## 1. Principles

- Local SQLite is authoritative for offline field work.
- Cloud metadata is a synchronized projection, not the source of truth during capture.
- Media identity is based on stable IDs / object keys, not provider URLs.
- Proof metadata should be append-safe and difficult to mutate accidentally.

## 2. Local tables

### projects

```text
id TEXT PRIMARY KEY
name TEXT NOT NULL
address TEXT NULL
latitude REAL NULL
longitude REAL NULL
location_radius_m REAL NULL
status TEXT NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
cloud_id TEXT NULL
sync_state TEXT NOT NULL
```

### photos

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL
capture_type TEXT NOT NULL
local_original_path TEXT NOT NULL
local_thumbnail_path TEXT NULL
sha256 TEXT NOT NULL
captured_at INTEGER NOT NULL
latitude REAL NULL
longitude REAL NULL
location_accuracy_m REAL NULL
location_source TEXT NULL
used_project_location_fallback INTEGER NOT NULL DEFAULT 0
low_accuracy_acknowledged INTEGER NOT NULL DEFAULT 0
note_raw TEXT NULL
note_clean TEXT NULL
created_by_local_user_id TEXT NULL
cloud_object_key TEXT NULL
cloud_thumbnail_key TEXT NULL
sync_state TEXT NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

`capture_type` values initially:

- before
- after
- progress
- issue

### photo_links

Used for Before/After relationships.

```text
id TEXT PRIMARY KEY
before_photo_id TEXT NOT NULL
after_photo_id TEXT NOT NULL
created_at INTEGER NOT NULL
```

### sync_jobs

```text
id TEXT PRIMARY KEY
entity_type TEXT NOT NULL
entity_id TEXT NOT NULL
operation TEXT NOT NULL
state TEXT NOT NULL
attempt_count INTEGER NOT NULL DEFAULT 0
next_attempt_at INTEGER NULL
last_error_code TEXT NULL
last_error_message TEXT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### reports

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL
title TEXT NOT NULL
manifest_version INTEGER NOT NULL
manifest_json TEXT NOT NULL
report_hash TEXT NULL
local_pdf_path TEXT NULL
cloud_object_key TEXT NULL
verification_id TEXT NULL
sync_state TEXT NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### report_items

```text
id TEXT PRIMARY KEY
report_id TEXT NOT NULL
photo_id TEXT NOT NULL
sort_order INTEGER NOT NULL
include_note INTEGER NOT NULL DEFAULT 1
layout_group TEXT NULL
```

## 3. Firestore collections

Proposed cloud model:

```text
/users/{userId}
/organizations/{orgId}
/organizations/{orgId}/members/{memberId}
/projects/{projectId}
/projects/{projectId}/photos/{photoId}
/reports/{reportId}
/verifications/{verificationId}
```

This may evolve for query and security-rule efficiency.

## 4. Project document

Suggested fields:

```text
id
ownerId
organizationId?
name
address?
latitude?
longitude?
locationRadiusM?
status
createdAt
updatedAt
```

## 5. Photo cloud document

Suggested fields:

```text
id
projectId
capturedBy
captureType
capturedAt
latitude?
longitude?
locationAccuracyM?
locationSource?
usedProjectLocationFallback
sha256
objectKey
thumbnailKey?
noteRaw?
noteClean?
beforePhotoId?
afterPhotoId?
createdAt
syncedAt
```

Do not use public download URLs as permanent IDs.

## 6. Verification document

Suggested fields:

```text
verificationId
reportId
reportHash
manifestVersion
generatedAt
projectDisplayName
recordCount
verificationStatus
revokedAt?
```

Public verification endpoints should reveal only information intentionally designed for sharing.

## 7. Sync invariants

For a photo to become `synced`:

1. local original must still exist
2. local SHA-256 must be known
3. cloud object upload must succeed or be confirmed idempotently
4. cloud metadata must reference the same stable object key
5. cloud metadata hash must match local hash

The UI may independently display:

- saved locally
- backed up to cloud

These are different guarantees.

## 8. Storage abstraction

Recommended domain model:

```text
MediaObjectRef {
  provider
  bucket_or_namespace
  object_key
  variant
}
```

Providers may initially contain `firebase_storage` and later `r2`.

Do not persist temporary signed URLs as durable identity.

## 9. Future fields to anticipate without prematurely implementing

- semantic embedding reference
- AI image description
- work area / room
- custom tags
- organization template ID
- camera orientation / focal metadata
- C2PA manifest reference
- deletion / retention policy
- archive storage tier

Schema migrations should remain explicit and versioned.
