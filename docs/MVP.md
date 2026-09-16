# FieldTrust MVP Plan

## Goal

Validate whether field workers will repeatedly use FieldTrust instead of ordinary Camera Roll / timestamp camera workflows.

The MVP is not successful because it compiles. It is successful when real users keep using it across multiple workdays.

## Milestone 0 — Foundation

- Flutter app bootstrapped
- shadcn_ui theme
- Riverpod
- go_router
- Drift database
- app-managed media directory
- basic error logging

## Milestone 1 — Projects

- create/edit project
- optional project address/location
- recent projects
- nearby project suggestion
- project detail

Acceptance:

- user can create a project entirely offline
- project remains after app restart

## Milestone 2 — Reliable Camera

- camera preview
- Before / After / Progress / Issue modes
- GPS metadata capture
- GPS accuracy state
- local original persistence
- SHA-256 calculation
- local photo DB record
- `Saved locally` confirmation

Acceptance:

- capture works offline
- killing the app after save does not lose the photo
- photo appears in project gallery after restart

## Milestone 3 — Ghost Alignment

- After mode can select a Before reference
- 30% default overlay
- opacity adjustment
- overlay toggle
- saved relationship between Before and After

Acceptance:

- user can reproduce a visually similar viewpoint without leaving camera flow

## Milestone 4 — Notes

- quick text note
- record voice note
- speech-to-text integration
- AI note cleanup
- raw note/transcript preservation where feasible

Acceptance:

- AI/network failure never prevents the photo from remaining usable

## Milestone 5 — Gallery & Comparison

- project gallery
- filters by capture type
- sync state badges
- Before/After pair view
- simple side-by-side comparison

## Milestone 6 — Reports

- select photos
- reorder
- report title/project information
- simple layout options
- company branding
- PDF generation
- report manifest/hash
- verification badge/QR placeholder or first online verification flow

Acceptance:

- a user can generate a client-ready report from an offline project

## Milestone 7 — Firebase Cloud Backup

- Firebase Auth
- optional sign-in
- Firestore cloud metadata
- Firebase Storage
- durable sync queue worker
- retry/recovery
- backup state UI

Acceptance:

- capture stays fully functional with cloud disabled/unavailable
- queued uploads resume after reconnect/restart
- duplicate retries do not create duplicate photo records

## Milestone 8 — Verification

- verification record
- QR/URL
- public-safe verification page/service
- report integrity status

Do not claim legal admissibility or evidence guarantees.

## Milestone 9 — Field Pilot

Recruit 10–20 real users from one or two focused segments, ideally contractors / HVAC / handyman / construction.

Observe:

- photos per workday
- repeat usage across 7 days
- project assignment rate
- report generation/share rate
- note usage
- Ghost Alignment usage
- sync/reliability incidents
- willingness to pay

## MVP metrics

Primary:

- D1 and D7 retained field users
- active project days per user
- captures per active day
- percentage of captures assigned to a project
- percentage of projects with a generated/shared report

Qualitative:

- `This is faster than my current workflow.`
- `I trust that my photos are saved.`
- `I can find things later.`
- `I would keep using this.`
- `I would pay for backup/report/team features.`

## Stop conditions

Pause or reposition if real field users consistently show that:

- normal camera + messages is faster enough
- project organization adds friction without value
- verified reports are rarely needed
- users do not return after several days
- price sensitivity makes cloud/reporting uneconomic

## v1 non-goals

Do not add before MVP validation:

- CRM
- invoicing
- quoting
- payroll
- workforce scheduling
- full team admin
- BIM
- 360 capture
- complex video
- social feed
- portfolio marketplace

## Recommended implementation sequence

```text
Foundation
  ↓
Projects
  ↓
Reliable local camera
  ↓
GPS confidence
  ↓
Ghost alignment
  ↓
Gallery / Before-After
  ↓
Report
  ↓
Cloud sync
  ↓
Voice AI
  ↓
Verification
  ↓
Field pilot
```

Reliability outranks feature count at every milestone.
