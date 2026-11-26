# Sumi Planner — Product Idea, Architecture & Master Plan

> **Document Purpose**: Authoritative product vision, user workflow, UI-to-architecture blueprint, and competitive feature & data-collection benchmark for **Sumi Planner** (*Mindful Digital Paper & Eisenhower Matrix*).
>
> **Visual Companion**: Full-screen, unclipped captures of all 20 application screens, tabs, and modal sheets are stored in [`/full_screen_screenshots/`](../full_screen_screenshots/) (with primary captures also mirrored in [`/screenshots/`](../screenshots/)).

---

## 1. Core App Idea & Product Vision

**Sumi Planner** (*Sumi* = Japanese calligraphy ink) bridges the tactile calm of physical Japanese stationery (**Kokuyo Jibun Techo** / 5mm dot-grid bullet journals) with modern cognitive productivity science and cross-platform mobile/web persistence.

Most digital task managers fail knowledge workers because they create **infinite guilt lists**—hundreds of unprioritized checkboxes with zero respect for human working-memory limits, daily time capacity, or cognitive fatigue. Sumi Planner solves this by enforcing three core guardrails directly in its UI:

1. **The Top-3 Commitment Constraint**: Each day highlights at most **3 Top Priorities** alongside categorized Brain Dump capture ledgers.
2. **Visual Time Realism (14-Hour Paper Ruler)**: Every priority must fit onto a realistic `06:00–20:00` timeblock ruler, with automatic detection of unscheduled tasks and optional two-way Google Calendar sync.
3. **Cognitive Load & Rest Guardrails**: Tasks larger than 3 hours trigger decomposition into either **Same-Day Intraday Sessions** (connected by a restorative break bracket) or **Linked Multi-Day Threads** (enforcing an overnight memory-consolidation buffer and sequential dependency gates).

---

## 2. Who Are the Main Users? (Target Personas)

| Persona | Profile & Pain Points | How Sumi Planner Helps |
| :--- | :--- | :--- |
| **1. Software Engineers & Technical Architects** | Juggle deep-focus coding blocks, PR reviews, architecture spikes, and cross-team syncs; suffer from context-switching and underestimated multi-day tasks. | 2×2 Eisenhower triage, multi-day thread decomposition with dependency gates, Git/Obsidian Markdown export, and distraction-free 25m–90m focus sprints. |
| **2. Indie Makers, Founders & Solo Creators** | Wear every hat (product, writing, client calls); struggle to separate urgent noise from high-leverage deep work. | Top-3 daily focus cap, Brain Dump Master Inbox for rapid idea capture, and Weekly Spread drag-and-drop capacity balancing. |
| **3. Neurodivergent / ADHD-Mindful Knowledge Workers** | Easily overwhelmed by cluttered UIs and time-blindness; thrive with visual timeblocks, tactile stationery cues, and gentle ambient soundscapes. | Calm sage/paper low-glare palette, procedural Kyoto Rain & Brown Noise Web Audio synthesis, physical haptic feedback, and evening shutdown check-ins. |
| **4. Hybrid Digital + Analog Journalers** | Love fountain pens and A5/B5 Kokuyo dot-grid paper, but need cloud sync, Google Calendar compatibility, and mobile notifications on the go. | Printable 5mm dot-grid stationery spreads (`@media print`), camera capture of physical handwritten notes (`/api/device/upload-photo`), and Android/iOS Capacitor support. |

---

## 3. How the App Works (End-to-End Daily & Weekly Workflow)

Sumi Planner guides the user through a continuous, calm **5-Stage Daily & Weekly Loop**:

```
  [1. CAPTURE]               [2. TRIAGE]                 [3. COMMIT & TIMEBLOCK]
  Brain Dump Inbox    ───►   Eisenhower 2x2 Matrix ───►  Today Top-3 + 14h Timeline
  Inline Quick-Add           Urgency x Importance        Built-in or Google Calendar
        ▲                                                         │
        │                                                         ▼
  [5. CLOSE & REVIEW]        [4. EXECUTE & PROTECT]
  Evening Shutdown    ◄───   Mindful Focus Sprint + Same-Day / Multi-Day Split
  & 7-Day Weekly Spread      Web Audio Soundscapes + Restorative Break Guardrails
```

### Step-by-Step Operational Flow
1. **Capture Anywhere (`Inbox` & Inline Quick-Add)**: Unstructured thoughts, incoming Slack/client requests, or whiteboard sketches (via native camera) go straight into the Brain Dump ledger without cluttering today's focus.
2. **Prioritize with Intention (`Prioritize` Tab)**: Users inspect the 2×2 **Eisenhower Matrix** (`Do First`, `Schedule`, `Delegate`, `Eliminate`) and select exactly **3 commitments** to push to the Today ledger.
3. **Commit & Timeblock (`Today` Tab — Priorities & Timeline Modes)**:
   - In **Priorities Mode**, users check off their Top 3 (rewarded with confetti + optional haptics) and scan category-grouped Brain Dump items.
   - Switching to **Daily Timeline Mode** maps tasks onto the `06:00–20:00` ruler. Users can keep their calendar strictly local (**Built-in Paper Calendar**) or toggle **Google Calendar 2-Way Live Sync**.
4. **Split Heavy Work & Enter Deep Focus (`Split Task`, `Multi-Day Thread`, `Focus Sprint`)**:
   - Oversized tasks split into paired **Morning + Afternoon blocks** (visually linked with SVG spine brackets across a 60m–120m restorative break) or into **2–3 Day Linked Threads** with dependency locks.
   - Launching **Focus Sprint** opens a circular SVG Pomodoro timer (`25m` / `45m` / `90m`) backed by offline procedural Web Audio (`Rain` and `Brown Noise`) and a Tibetan singing bowl completion chime.
5. **Reflect, Measure & Rebalance (`Evening Shutdown` & `Review` Tab)**:
   - At day's end, the **Evening Shutdown Check-In** captures Daily Anchor Habits, Mood, Energy (1–5), Focus Quality (1–5), Today's Win, and Tomorrow's #1 Intention.
   - On the **7-Day Weekly Spread**, users drag and drop tasks (or tap touch reallocation pills on mobile) across Monday–Sunday while watching daily hour capacity gauges and the **Focus Telemetry & Reflection Ledger**.

---

## 4. Complete UI Screen & Feature Inventory

All 20 screens, sub-tabs, and modals below have full-height, unclipped captures in [`/full_screen_screenshots/`](../full_screen_screenshots/):

| # | Screen / Modal Name | Purpose & Key UI Elements | Full-Screen Screenshot |
| :--- | :--- | :--- | :--- |
| 1 | **Today — Priorities & Brain Dump** | Top-3 commitment checkboxes with confetti, `Reorder` mode, inline `+` Brain Dump capture, category-grouped task ledgers, Linked Thread banner. | [`01-today-priorities.png`](../full_screen_screenshots/01-today-priorities.png) |
| 2 | **Today — 14-Hour Daily Timeline** | `06:00–20:00` ruled grid, current-time indicator, scheduled vs open hours summary, paired SVG split-session brackets, Google Calendar toggle. | [`02-daily-timeline.png`](../full_screen_screenshots/02-daily-timeline.png) |
| 3 | **Prioritize — Eisenhower Matrix** | Interactive 2×2 matrix (`Do First`, `Schedule`, `Delegate`, `Eliminate`), Top-3 candidate selector, `Apply Top 3 to Daily Planner` CTA. | [`03-prioritize-eisenhower.png`](../full_screen_screenshots/03-prioritize-eisenhower.png) |
| 4 | **Brain Dump Master Inbox** | Full backlog ledger, real-time keyword search, category pills, status filter (`All`/`Pending`/`Completed`), one-click scheduling. | [`04-brain-dump-inbox.png`](../full_screen_screenshots/04-brain-dump-inbox.png) |
| 5 | **Weekly Review & Telemetry Ledger** | 7-day spread (`Mon–Sun`), HTML5 drag-and-drop & mobile touch reallocation, dynamic capacity gauges, **Focus Telemetry & Reflection Ledger**. | [`05-weekly-review-spread.png`](../full_screen_screenshots/05-weekly-review-spread.png) |
| 6 | **Evening Shutdown & Reflection** | End-of-day ritual modal: Daily Anchor Habits checklist, mood selector, Energy/Focus 1–5 scales, Win / Lesson / Tomorrow's Intention journal prompts. | [`06-evening-reflection-modal.png`](../full_screen_screenshots/06-evening-reflection-modal.png) |
| 7 | **Mindful Focus Sprint Timer** | Full-screen distraction-free circular SVG countdown (`25m`/`45m`/`90m`), offline Web Audio Rain/Brown Noise synthesizer, subtask tracker. | [`07-mindful-focus-session.png`](../full_screen_screenshots/07-mindful-focus-session.png) |
| 8 | **Linked Multi-Day Thread Sheet** | Progress bar across days, `+30m Done` logger, locked Dependency Gate banner, `Shift +1 Day` / `Merge` / `Add Part 3` rebalancing controls. | [`08-linked-multiday-thread.png`](../full_screen_screenshots/08-linked-multiday-thread.png) |
| 9 | **Stationery Export — Print Spread** | Kokuyo 5mm dot-grid A5/B5 print layout preview and system print dialog trigger. | [`09-stationery-export-print.png`](../full_screen_screenshots/09-stationery-export-print.png) |
| 10 | **Stationery Export — Markdown** | Obsidian & Notion Markdown generator with one-click copy and JSON backup export. | [`10-stationery-export-markdown.png`](../full_screen_screenshots/10-stationery-export-markdown.png) |
| 11 | **Native Device Hub — Status** | Cross-platform Capacitor OS/battery/network telemetry and permission readiness indicators. | [`11-device-hub-status.png`](../full_screen_screenshots/11-device-hub-status.png) |
| 12 | **Native Device Hub — Camera Notes** | Native camera stationery/whiteboard capture and `/api/device/upload-photo` synchronization. | [`12-device-hub-camera.png`](../full_screen_screenshots/12-device-hub-camera.png) |
| 13 | **Native Device Hub — GPS Location** | Location coordinates, geofenced workspace tracking, and breadcrumb logging. | [`13-device-hub-location.png`](../full_screen_screenshots/13-device-hub-location.png) |
| 14 | **Supabase Cloud Sync Config** | Cloud database connection wizard, SSRF-protected endpoint validator, and push sync controls. | [`14-supabase-cloud-sync.png`](../full_screen_screenshots/14-supabase-cloud-sync.png) |
| 15 | **Server Security & Health Audit** | Live server health diagnostics, Helmet CSP, Rate Limiter, SSRF shield, and XSS filter verification. | [`15-supabase-security-audit.png`](../full_screen_screenshots/15-supabase-security-audit.png) |
| 16 | **Google Calendar 2-Way Sync** | Master ON/OFF sync toggle, Firebase Google OAuth sign-in, inbound event reader, and Focus Sprint push controls. | [`16-google-calendar-sync.png`](../full_screen_screenshots/16-google-calendar-sync.png) |
| 17 | **Quick Add Task Sheet** | Structured task capture modal with urgency/importance auto-matrix calculation, duration picker, and category tags. | [`17-quick-add-modal.png`](../full_screen_screenshots/17-quick-add-modal.png) |
| 18 | **Task Details & Subtasks Editor** | Rich task sheet displaying `Why Now`, editable notes, micro-task checklist, and Split action. | [`18-task-details-modal.png`](../full_screen_screenshots/18-task-details-modal.png) |
| 19 | **Split Task — Same-Day Intraday** | Same-day session splitter with duration sliders, restorative interval picker (`60m–120m`), and SVG timeline preview. | [`19-split-task-same-day.png`](../full_screen_screenshots/19-split-task-same-day.png) |
| 20 | **Split Task — Multi-Day Thread** | Multi-day session distribution across days with sequential dependency gates and weekly cognitive impact chart. | [`20-split-task-multi-day.png`](../full_screen_screenshots/20-split-task-multi-day.png) |

---

## 5. Industry Benchmark: What Similar Apps Use (Features, Backend & Data Collection)

To evaluate **Sumi Planner** against leading products in the mindful daily-planning category (**Sunsama**, **Akiflow**, **Structured**, **Motion**, **Things 3**, and **Kokuyo Jibun Techo**), below is an industry comparison of standard features, backend infrastructure, and data-collection practices—and how each fits Sumi Planner.

### A. Feature & UX Patterns in Similar Apps
| Standard Category Feature | Used By | Fits Sumi Planner? | Status in Project |
| :--- | :--- | :--- | :--- |
| **Daily Shutdown / Evening Reflection Ritual** (mood, energy, daily win, tomorrow intention) | Sunsama, Jibun Techo | **Yes — Core Fit** | **Implemented** (`EveningReflectionModal.tsx`, `ReviewWeeklyView.tsx`, `/api/reflections`) |
| **Daily Anchor Habits / Ritual Checklists** (morning plan, midday walk, evening close) | Jibun Techo, Structured | **Yes — Core Fit** | **Implemented** (`db.getHabits()`, `db.toggleHabit()`, `/api/habits`) |
| **Focus Timer + Ambient Soundscapes** | Sunsama, Forest, Endel | **Yes — Core Fit** | **Implemented** (`MindfulFocusSessionModal.tsx` + offline `audioEngine.ts`) |
| **Calendar 2-Way Sync + Timeblocking** | Sunsama, Akiflow, Motion | **Yes (Opt-In)** | **Implemented** (`GoogleCalendarSyncModal.tsx` with Built-In vs Live toggle) |
| **Weekly Capacity & Drag-Drop Reallocation** | Sunsama, Motion | **Yes — Core Fit** | **Implemented** (`ReviewWeeklyView.tsx`) |
| **Auto-Scheduling AI Blackbox** | Motion | **No (Avoided intentionally)** | Deliberately excluded to preserve human mindfulness; replaced with transparent user-approved suggestions & cognitive guardrails. |

### B. Backend Architecture Patterns in Similar Apps
1. **Local-First Offline Queue + Batch Synchronization**: Mobile/desktop planners use an optimistic local store (`localStorage` / Capacitor `Preferences`) paired with an idempotent `/api/device/events-sync` batch endpoint so airplane-mode edits never get lost.
2. **Server-Side Security Perimeter**: Helmet CSP, dual-tier rate limiting (`express-rate-limit`), input sanitization (`sanitizeText`), and **Anti-SSRF validators** (`/api/supabase/validate`) when validating user-supplied external endpoints.
3. **Media Attachment & Push Notification Pipelines**: `/api/device/upload-photo` for handwritten note/whiteboard captures and `/api/device/push-token` for APNs/FCM token registration.
4. **Reflection & Habit Persistence Endpoints**: `/api/reflections` and `/api/habits` to store structured daily check-ins alongside tasks.

### C. Data Collection & Telemetry Features in Similar Apps (Privacy-First Model)
In comparable productivity apps, **two very different kinds of data collection** exist:
1. **Invasive Third-Party Ad/Behavioral Tracking** *(Rejected for Sumi Planner)*: Cross-app ad SDKs, third-party session replay trackers, selling behavioral profiles. This violates the calm, trustworthy ethos of mindful stationery software.
2. **Privacy-First Personal Productivity Telemetry** *(Ideal Fit — Implemented in Sumi Planner)*:
   - **What is collected (when user opts in)**:
     - `task_created` & `task_completed` events (category, Eisenhower quadrant, planned `durationMinutes`).
     - `focus_sprint_completed` events (actual session minutes + chosen ambient soundscape `rain` / `brown_noise` / `none`).
     - `reflection_saved` & `habit_completed` events (energy score 1–5, focus quality 1–5, mood tag, anchor streak).
     - Hardware-assisted context (opt-in only via OS permissions): camera stationery note uploads, optional GPS workspace breadcrumbs, and walking step/activity estimates during restorative breaks.
   - **How it benefits the user**:
     - Computes **Planned vs. Actual Time Accuracy** (curing time-blindness).
     - Tracks **Eisenhower Quadrant Balance** (ensuring Q2 high-leverage work isn't crowded out by Q1 fires).
     - Surfaces **Anchor Habit Streaks** and **Focus Minutes Logged** inside the Weekly Review screen.
   - **Strict User Governance**:
     - Explicit **Telemetry ON / OFF toggle** directly on the Weekly Review Insights Ledger (`db.setAnalyticsPreferences()` synced to `PUT /api/analytics/preferences`). When OFF, both client and `/api/analytics/events` refuse to record telemetry events.

---

## 6. Technical Architecture & Roadmap Plan

### Current Production Stack
- **Frontend**: React 19, TypeScript 5.8, Tailwind CSS v4, Vite, Motion, Canvas Confetti, Web Audio DSP.
- **Backend**: Express 4 (`server.ts` on port 3000) with Helmet CSP, CORS, dual rate limiters, SSRF guard, input sanitization, and REST endpoints for Tasks, Threads, Timeline, Categories, Reflections, Habits, Analytics Telemetry, Backup/Restore, and Native Device Sync.
- **Database & Cloud**: Local-first Observer Store (`src/services/db.ts`) + optional Supabase PostgreSQL (RLS enabled) + Client-side Firebase Google OAuth (`calendar.events`).
- **Native Mobile (Android & iOS)**: Capacitor 8.6 with configured `/android` (Gradle 8.11.1, Java 17, compileSdk 35) and `/ios` (`AppDelegate.swift`, `Info.plist` privacy strings, Swift Package plugins) plus `src/platform/device/` abstraction layer.

### Phased Forward Plan
| Phase | Focus Area | Key Milestones |
| :--- | :--- | :--- |
| **Phase 1 (Complete)** | Core Planner & Aesthetic System | Kokuyo grid tokens, Today Top-3, 14h Timeline, Eisenhower Matrix, Brain Dump Inbox, Weekly Spread. |
| **Phase 2 (Complete)** | Cognitive Guardrails & Focus | Same-Day Intraday Splitter + SVG Brackets, Linked Multi-Day Threads, Web Audio Focus Sprint, Stationery Print/MD Export. |
| **Phase 3 (Complete)** | Full-Stack Security & Cloud | Express shield (Helmet, Rate Limit, SSRF filter), Supabase DDL/sync, Google Calendar 2-way toggle. |
| **Phase 4 (Complete)** | Native Android & iOS (Capacitor) | `/android` & `/ios` builds, Camera/GPS/Motion/Haptics/Local & Push Notifications, Offline Event Queue Sync. |
| **Phase 5 (Complete)** | Mindful Analytics & Shutdown Loop | Evening Shutdown Check-In modal, Daily Anchor Habits, Privacy-First Telemetry Engine (`/api/analytics/*`, `/api/reflections`, `/api/habits`). |
| **Phase 6 (Planned)** | Multi-Week Insights & Wearables | 30-day energy-vs-focus correlation charts, encrypted E2E Supabase sync for reflections, WatchOS/WearOS focus sprint companion. |
