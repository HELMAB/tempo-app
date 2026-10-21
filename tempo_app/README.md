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
- Add to `domain/use_cases/` only when logic is shared across ViewModels or
  spans repositories. Current ones: `DailyProgress` (Today + Timer) and
  `ProjectTotals` (Projects, and Reports next). Finished time is summed in
  SQL (`watchFinishedTotalsByProject`); only the running entry is added in Dart.
- Form ViewModels (entry editor, project sheet) keep the draft in a field, so
  a rebuild caused by a watched stream never wipes the user's edits.
- In ViewModels, `ref.watch(x.future)` rather than `ref.read(x.future)`.
  Riverpod 3 pauses providers that nobody listens to, so a read can wait
  forever (for example when a deep link opens a sheet before any list
  screen has subscribed).
- Live durations are never stored or ticked in state: `ClockBuilder` rebuilds
  the view once a second while a timer runs, and the view asks the state for
  `durationAt(now)`. Inject time through `clockProvider` so tests can freeze it.

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
| `/projects/new` · `/projects/:id` | New / edit project bottom sheet |
| `/timer` | Running timer |
| `/entry/new` · `/entry/:id` | Add / edit entry |

### Theme

Tokens from the handoff are in `ui/core/themes/` (`AppColors`, `AppTheme`).
The typeface is **Google Sans**, which covers both Latin and Khmer. It is
bundled in `assets/fonts` as static weights 400–700 (unmodified files from
Google Fonts, OFL), not loaded through `google_fonts`, so it works offline and
`style.copyWith(fontWeight: …)` picks the real weight. Google Sans has no 800,
so the handoff's 800 styles use 700. The four files are ~1.9 MB each because
they cover many scripts; subsetting them to Latin + Khmer would cut that a lot.

`AppTheme.light(locale)` / `dark(locale)` give Khmer 1.3× taller line heights
(stacked vowels and subscript consonants need the room) and no letter-spacing,
which would break Khmer shaping.

### Localization

**Khmer is the primary language.** `AppSettings.language` defaults to
`AppLanguage.khmer` and decides the app's locale; the device locale is
ignored. English can be picked in Settings › Language.

- Strings live in `lib/l10n/app_en.arb` (template, with descriptions) and
  `app_km.arb`. Every key must exist in both. `flutter pub get` or
  `flutter gen-l10n` regenerates `AppLocalizations`.
- In widgets: `context.l10n.navToday` (`ui/core/localization.dart`).
- Durations and dates go through `ui/core/formatters/`, which take the
  `AppLocalizations` (`5h 42m` / `5 ម៉ោង 42 នាទី`, `អង្គារ, 20 តុលា`).
- Digits are Western (0–9) in both languages. Switch to Khmer numerals
  (០–៩) in the formatters if wanted.
- The Khmer translations were written alongside the code. Have a native
  speaker review `app_km.arb`.

## Build order

1. ✅ Theme, models and the drift database
2. ✅ Timer logic: `TodayViewModel`, `TimerViewModel`, `DailyProgress` use case
3. ✅ Today + Running timer screens
4. ✅ Entry editor and Projects (+ new / edit project sheet)
5. Reports (`fl_chart`), then Settings and reminders (`flutter_local_notifications`)

Screens not built yet render `ScreenPlaceholder`. Delete it once all are done.

## Notes

- `freezed` is pinned to `4.0.0-dev.3`: stable 4.x needs Dart ≥ 3.13 and 3.x
  conflicts with drift_dev's analyzer. Move to `^4.0.3` after the next Flutter upgrade.
- Web: drift loads `web/sqlite3.wasm` and `web/drift_worker.js`, both from the
  [drift release](https://github.com/simolus3/drift/releases) matching the
  `drift` version in `pubspec.lock` (currently 2.35.2). Download both again
  whenever drift is upgraded. A mismatched pair fails at runtime.
- The dark theme is seed-derived until it is designed.
- Pause stops the running entry; Resume starts a new one with the same
  project, description and tags. This keeps "the running timer is the entry
  with no `endAt`" true, so a paused session is two entries.
- The timer ring's "focus goal" is `AppSettings.focusGoalMinutes` (default 2h).
  It has no settings row yet.
- Today's calendar button is left out until the flow says what it opens.
- Entry editor: a new entry defaults to the hour before now. The end must be
  after the start (no entries across midnight yet), and the start can't be in
  the future. Editing a running entry keeps it running (End shows
  "Running"). Changing only the text keeps the original seconds.
- Projects: tapping a card opens the same sheet in edit mode, with Archive or
  Restore. The prototype doesn't show this; it's how archived projects come
  back. Weekly goals step by whole hours (0–80h). "This week" follows
  `AppSettings.weekStartsOn`.
- Segmented controls use `PillSegmentedControl` (grey track, white pill), not
  `SegmentedButton`, to match the prototype.
- Widget tests go through `testApp` (`test/testing/app_tester.dart`). It runs
  at the 390 × 844 prototype size and unmounts the app, so drift's stream
  timers finish before the test ends.
