# FieldTrust Product Requirements Document

## 1. Product summary

**FieldTrust** is a local-first work photo and proof app for contractors and small field teams.

**Tagline:** Trusted proof from the field.

The product helps workers document real-world jobs quickly, reliably, and in a form that can later be searched, compared, reported, and verified.

## 2. Target users

Primary:

- solo contractors
- small construction crews
- HVAC technicians
- plumbers
- electricians
- handymen
- property maintenance teams
- commercial cleaners
- inspection / field-service workers

Initial ideal customer profile: **1–10 person field team** that takes job photos every day but finds enterprise tools too expensive or heavy.

## 3. Core problems

1. Job photos become scattered across Camera Roll, WhatsApp, email, and cloud folders.
2. Workers cannot easily find a specific photo months later.
3. Weak connectivity can interrupt uploads or create uncertainty about whether photos were saved.
4. Location stamps may look precise even when GPS accuracy is poor.
5. Before/After photos are often taken from different angles, reducing their usefulness.
6. Typing detailed notes on-site is too slow.
7. Creating a client-ready report is tedious.
8. Clients, supervisors, or inspectors need confidence that reports have not been casually altered.

## 4. Product promise

FieldTrust should make this workflow feel effortless:

**Arrive → open nearby project → capture → speak a note → keep working → share a trusted report later.**

## 5. MVP user journey

### 5.1 First launch

- short value proposition
- permission explanations for camera and location
- allow local-only start without mandatory registration
- account creation is prompted when cloud backup/team functionality is requested

### 5.2 Create project

Minimum fields:

- project name
- optional address
- optional project location
- optional customer / reference label

If location permission is granted, allow setting current position as the job site.

### 5.3 Nearby project home

Home prioritizes the user's current task:

- suggested nearby project(s)
- recent projects
- primary `Take Photo` action
- unsynced media status

### 5.4 Capture

Capture modes:

- Before
- After
- Progress
- Issue

Overlay metadata shown during capture:

- project
- time
- GPS status / accuracy

Location states:

- good: green
- degraded: yellow
- unreliable: red

Low accuracy must never be hidden.

### 5.5 Ghost alignment

When capturing an `After` photo:

- allow selecting a related Before photo
- overlay it over the live camera view
- default opacity around 30%
- allow toggle and opacity adjustment
- first version is manual alignment only

### 5.6 Post-capture

Immediately after capture:

- persist original locally
- compute SHA-256
- save capture metadata
- queue sync job
- show `Saved locally`

Then offer optional fast actions:

- hold/tap to record voice note
- assign area/tag
- link Before ↔ After

### 5.7 Voice note

The worker can say a short rough note such as:

> south wall conduit done before drywall

AI may clean it to:

> Electrical conduit installed on the south wall prior to drywall installation.

The raw transcript should remain available when practical. AI rewriting must not invent observations.

### 5.8 Project gallery

Gallery supports:

- chronological view
- Before / After / Progress / Issue filters
- sync-state indicator
- list/grid view
- related Before/After pairs

### 5.9 Report

Generate a clean report containing:

- project identity
- optional company logo
- generated timestamp
- Before/After pairs
- selected progress/issues
- notes
- capture dates
- location confidence where relevant
- verification badge

Allow basic ordering before export.

### 5.10 Verification

Each generated verified report receives:

- report ID
- report hash / integrity fingerprint
- QR code / verification URL
- generated time
- count of included records

Verification page must be factual and avoid unsupported legal claims.

## 6. Search direction

Search is strategically important, even if advanced semantic search lands after MVP.

Metadata should be structured from day one so future queries can support:

- project name
- date range
- capture type
- worker
- note text
- area/tag
- future AI image description

Long-term example:

> Find the bathroom before photos from the Johnson job in March.

## 7. Cloud / sync

Cloud services are secondary to local persistence.

Initial cloud purposes:

- backup
- cross-device continuity
- report verification
- team/shared project access later

A cloud outage must not stop local field capture.

## 8. Monetization hypothesis

### Free

- local-first camera
- limited active projects or monthly cloud quota
- basic time/GPS proof
- limited reports

### Pro

Indicative target: **$39–49/year**

- unlimited projects
- cloud backup allowance
- Ghost Alignment
- voice-note cleanup
- custom company branding
- verified reports
- advanced search

### Small Team

Indicative target: **$19–29/month** initially

- shared projects
- multiple members
- team cloud backup
- activity attribution
- centralized reports

Pricing is a hypothesis and must be validated before launch.

## 9. MVP success criteria

The MVP is successful only if real field users repeatedly use it.

Key signals:

- user captures work photos across multiple days
- photos are consistently assigned to projects
- reports are generated/shared
- users return after 7 days
- users specifically value speed, reliability, searchability, or proof
- several testers say they would prefer FieldTrust to Camera Roll / generic timestamp camera / a heavier competitor

## 10. Stop / rethink criteria

Do not continue building a large SaaS merely because the app works technically.

Reassess if field testing shows:

- workers prefer ordinary Camera Roll and messaging workflows
- capture adds too much friction
- reports are rarely shared
- proof metadata is not valued
- users will not pay even modestly for backup / reporting / organization

## 11. Explicit non-goals for v1

- CRM
- estimating / quoting
- invoicing
- payroll
- workforce time tracking
- scheduling
- BIM
- full construction ERP
- customer messaging platform
- social portfolio network
- complex video workflows

FieldTrust wins by doing a narrow workflow exceptionally well.
