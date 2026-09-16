# FieldTrust Design System

## 1. Design direction

FieldTrust should feel like a professional field tool, not a social camera and not a dense enterprise dashboard.

Visual principles:

- light-first, clean, high-contrast
- calm neutral surfaces
- dark green as trust / success accent
- restrained mint accent for positive states
- large touch targets
- minimal copy during capture
- clear sync and confidence states

Use `shadcn_ui` as the component foundation, but adapt it to mobile ergonomics.

## 2. Brand

**Name:** FieldTrust

**Tagline:** Trusted proof from the field.

Alternative product line:

**Document the job. Prove the work.**

## 3. Color direction

Suggested starting palette:

- Ink: `#111827`
- Surface: `#FFFFFF`
- Surface muted: `#F6F7F8`
- Border: `#E5E7EB`
- Field green: `#0F6B4B`
- Mint: `#BFE9D7`
- Warning: `#D89B24`
- Danger: `#C2413B`
- Text secondary: `#667085`

Final accessibility contrast must be checked in implementation.

## 4. Typography

Use a modern, neutral sans-serif with strong numeric readability.

Priorities:

- timestamps and GPS values must scan quickly
- body copy should stay compact
- avoid oversized marketing typography inside field workflows

## 5. Navigation

Initial bottom navigation:

- Home
- Projects
- Reports
- Settings

Camera is a primary contextual action, not a fifth information tab.

## 6. Home

Purpose: get the user into the current job quickly.

Priority order:

1. nearby / current project
2. large `Take Photo` CTA
3. unsynced status if relevant
4. recent projects

Avoid dashboards full of analytics in MVP.

## 7. Project screen

Header:

- project name
- address / job reference
- location lock status
- overflow menu

Summary cards may show:

- total photos
- photos today
- unsynced items

Primary action:

- `Take Photo`

Secondary sections:

- Before
- After
- Progress
- Issues
- All

## 8. Camera screen

Camera must remain visually dominant.

Top region:

- close/back
- project name
- GPS status

GPS presentation:

### Good

`GPS locked · ±4 m`

### Degraded

`Low GPS accuracy · ±38 m`

Use yellow styling and explain the source when useful.

### Unreliable

`Location unreliable · ±85 m`

Use red styling and provide options:

- wait for a better fix
- continue with current accuracy
- use locked project location where applicable

Bottom region:

- segmented capture mode: Before / Progress / After / Issue
- shutter
- optional ghost overlay control when After is selected

## 9. Ghost Alignment

When an After capture has a related Before image:

- show `Align with Before`
- overlay historical image at ~30% opacity
- provide on/off button
- provide opacity adjustment
- keep controls minimal

Do not obstruct shutter or GPS confidence.

Future enhancement may add edge extraction or automated alignment, but MVP is manual overlay only.

## 10. Post-capture state

Immediately communicate reliability:

`Saved locally ✓`

Cloud state can appear separately:

- Waiting to sync
- Uploading
- Cloud synced ✓
- Sync failed — retrying

Never imply that an unsynced photo is lost.

Fast actions:

- voice note
- add tag / area
- pair with Before/After

## 11. Before / After presentation

Comparison view should support:

- side-by-side
- swipe / split comparison later
- matching timestamps
- location confidence
- notes

Reports should prioritize clean pairs over decorative layouts.

## 12. Report screen

Report builder needs to be simple but controllable.

MVP controls:

- reorder selected media
- choose 1 / 2 / 4 photos per page where practical
- cover title
- company logo
- include/exclude notes
- include verification badge

Report footer/header should carry a subtle FieldTrust mark.

## 13. Verification badge

Suggested treatment:

`Verified by FieldTrust`

`Scan to verify integrity`

QR code should open a verification page showing factual metadata such as report ID, generated time, included record count, and integrity state.

Do not use courtroom, legal seal, government, police, or certification imagery.

## 14. Settings

Sections:

### Account
- sign in / account
- team later

### Storage & backup
- local storage usage
- cloud sync state
- backup health
- future storage mode

### Capture
- save copy to Camera Roll
- default capture mode
- watermark/report preferences

### Company
- name
- logo
- report branding

### Privacy
- location data explanation
- export
- delete account/data

## 15. Mobile interaction rules

- minimum comfortable touch target around 44–48 px
- important capture actions reachable one-handed
- never require precise tiny taps in the field
- avoid modal chains during capture
- destructive actions need explicit confirmation
- respect system safe areas
- support dark conditions eventually, but light theme is the initial design target

## 16. Empty states

Empty states should be action-oriented.

Example:

**No projects yet**

Create your first job to keep every photo organized from the moment you capture it.

`Create project`

## 17. Accessibility

- do not communicate GPS/sync state with color alone
- support Dynamic Type / text scaling where feasible
- screen-reader labels for capture and sync controls
- maintain contrast for outdoor usage

## 18. Design anti-patterns

Avoid:

- glassmorphism that reduces outdoor readability
- excessive gradients
- tiny metadata
- desktop SaaS sidebars transplanted to mobile
- dozens of watermark templates as the product identity
- AI sparkle icons everywhere
- unclear cloud-only save states

The product should look dependable before it looks clever.
