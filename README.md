# FieldTrust

**Trusted proof from the field.**

FieldTrust is a local-first work photo and proof app for contractors and small field teams. It helps workers capture trustworthy job photos, organize them by project, compare before/after work, add fast voice notes, generate professional reports, and keep records safely backed up.

## Product principles

1. **Never lose proof** — a photo is captured only after it has been safely persisted locally.
2. **Offline first** — cloud synchronization must never block field work.
3. **Fast in the field** — common actions should take seconds, not forms.
4. **Trust is visible** — location accuracy, timestamps, sync state, and report verification are explicit.
5. **Simple before powerful** — FieldTrust serves solo contractors and small crews before enterprise workflows.

## MVP

- Projects and nearby project suggestions
- Camera with time/GPS metadata
- GPS accuracy warnings
- Before / After / Progress capture modes
- Ghost overlay alignment for After photos
- Local-first photo storage and durable sync queue
- Voice notes with AI cleanup
- Project gallery and search-ready metadata
- Shareable / PDF reports
- Verification badge and report integrity page
- Cloud backup

## Tech stack

- **Flutter**
- **shadcn_ui**
- **Riverpod**
- **go_router**
- **Drift / SQLite**
- **Firebase Auth**
- **Cloud Firestore**
- **Firebase Storage** initially
- **Cloudflare R2** planned for large-object / archive storage
- **Firebase Crashlytics / Analytics / FCM / Remote Config** as needed

## Repository docs

- [`AGENTS.md`](./AGENTS.md) — engineering rules for coding agents
- [`docs/PRD.md`](./docs/PRD.md) — product requirements
- [`docs/DESIGN.md`](./docs/DESIGN.md) — UI/UX and design system
- [`docs/ARCHITECTURE.md`](./docs/ARCHITECTURE.md) — technical architecture
- [`docs/DATA_MODEL.md`](./docs/DATA_MODEL.md) — local and cloud data model
- [`docs/MVP.md`](./docs/MVP.md) — MVP scope and build order

## Non-goals for v1

FieldTrust is not a CRM, ERP, time-tracking platform, invoicing system, social network, or full construction management suite. Those features must not distract from the core workflow:

**Project → Capture → Proof → Report**
