# Tempo

Offline-first time tracker: one-tap timer, projects with weekly goals, reports.
Designs live in [`../prototype`](../prototype) (screens, user flow, Flutter handoff).

## Getting started

```sh
flutter pub get
dart run build_runner build   # drift + freezed code generation
flutter test
flutter run
```

Re-run `build_runner` (or keep `dart run build_runner watch` open) after
changing a drift table or a freezed model.

## Architecture

Layered MVVM following the Flutter architecture guide: **UI → (Domain) → Data**.
Riverpod (from the handoff) is both the DI container and the ViewModel base.

```text
lib/
├── main.dart                 # async init (prefs), ProviderScope
├── app.dart                  # MaterialApp.router, theme mode
├── config/dependencies.dart  # providers: services -> repositories, app-wide state
├── routing/                  # go_router config + Routes path constants
├── data/
│   ├── services/database/    # drift AppDatabase + tables (rows: *Row)
│   └── repositories/         # Project / TimeEntry / Settings repositories
├── domain/
│   └── models/               # freezed models: Project, TimeEntry, AppSettings
└── ui/
    ├── core/                 # theme tokens, formatters, shared widgets
    └── features/<feature>/
        ├── view_models/      # Notifier classes + their providers
        └── views/            # widgets; read state, call ViewModel commands
```

Rules of thumb:

- **Views** render state and forward user intent; no data access, no business logic.
- **ViewModels** (`Notifier` / `AsyncNotifier`) read repositories through `ref`,
  expose immutable state and command methods. See
  `ui/features/onboarding/view_models/onboarding_view_model.dart`.
- **Repositories** are the single source of truth. They map drift rows to
  domain models; nothing above the data layer sees a `*Row` class.
- **Services** wrap external things (SQLite via drift, shared preferences;
  notifications later).
- Add `domain/use_cases/` only when logic is shared across ViewModels or
  spans repositories (e.g. weekly totals per project for Projects and Reports).

### Data model

- `Project`: id, name, color (ARGB), weeklyGoalMinutes, countsTowardDailyGoal, archived
- `TimeEntry`: id, projectId?, description, startAt, endAt?, tags, note.
  The running timer is the one entry whose `endAt` is null (enforced by a
  partial unique index). Elapsed time is derived from `startAt`, so a timer
  survives the app being closed.
- Tags are normalised (`tags` + `entry_tags`); repositories expose them as `List<String>`.
- `AppSettings` lives in shared preferences (onboarding flag, goals, reminders, theme).

### Routes

| Path | Screen |
| --- | --- |
| `/onboarding` | Onboarding (first launch only, router redirect) |
| `/` · `/projects` · `/reports` · `/settings` | Bottom tabs (`StatefulShellRoute`) |
| `/projects/new` | New project bottom sheet |
| `/timer` | Running timer |
| `/entry/new` · `/entry/:id` | Add / edit entry |

### Theme

Tokens from the handoff are in `ui/core/themes/` (`AppColors`, `AppTheme`).
Manrope is bundled in `assets/fonts` as a regular font family. It is not
loaded through `google_fonts`, so it works offline and
`style.copyWith(fontWeight: …)` picks the real weight.

## Build order

1. ✅ Theme, models and the drift database
2. Timer: Today's quick start + running timer ViewModel (ticks from `startAt`)
3. Today + Running timer screens
4. Entry editor and Projects (+ new project sheet)
5. Reports (`fl_chart`), then Settings and reminders (`flutter_local_notifications`)

Screens not built yet render `ScreenPlaceholder`. Delete it once all are done.

## Notes

- `freezed` is pinned to `4.0.0-dev.3`: stable 4.x needs Dart ≥ 3.13 and 3.x
  conflicts with drift_dev's analyzer. Move to `^4.0.3` after the next Flutter upgrade.
- Web is not configured for drift (needs `sqlite3.wasm` + worker); mobile is the target.
- The dark theme is seed-derived until it is designed.
