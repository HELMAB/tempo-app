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

## Deploying the web app (Vercel)

Production web hosting is on Vercel, built by Vercel from Git.

**One-time setup** (Vercel dashboard → Add New → Project):

1. Import the `HELMAB/tempo-app` repository.
2. **Root Directory:** `tempo_app`. Framework preset: **Other**. Leave the
   build, install and output settings alone; `vercel.json` sets them.
3. Optional environment variable `FLUTTER_VERSION` (default `3.44.6`).
   Change it together with your local Flutter.
4. Deploy. Pushes to the production branch (usually `main`) deploy to
   production; other branches and pull requests get preview URLs.

**What the config does**

- `scripts/vercel-build.sh install` clones the pinned Flutter SDK (Vercel's
  image has none) and runs `pub get`; `build` runs
  `flutter build web --release --wasm --no-web-resources-cdn`. A cold build
  takes a few minutes, mostly cloning Flutter.
- `--wasm` ships WebAssembly with an automatic JavaScript fallback for
  older browsers; `--no-web-resources-cdn` self-hosts CanvasKit/skwasm.
- `vercel.json` rewrites unknown paths to `index.html`, because the app
  uses clean URLs (`usePathUrlStrategy()`: `/projects`, not `/#/projects`).
  Its headers enable **cross-origin isolation** (COOP `same-origin` + COEP
  `require-corp`). That lets drift store data in OPFS, its fastest and most
  durable web storage, and lets Wasm render multi-threaded. Basic security
  headers are set too, and the entry files are `no-cache` (Flutter's
  filenames aren't content-hashed).
- `.vercelignore` keeps native platform folders, tests and tools out of the
  build upload.

**Before turning those headers off or changing them:** drift picks its
storage from what the page allows. Without isolation it falls back to
IndexedDB, and data saved in OPFS would no longer be found. Treat the
storage choice as fixed once real users have data. Anything cross-origin
that the app loads must send CORS or CORP headers under COEP.

**Preview a production build locally**

```sh
flutter build web --release --wasm --no-web-resources-cdn
python3 tool/serve_web.py build/web   # http://127.0.0.1:8767
```

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
- **Services** wrap external things: SQLite (drift), shared preferences,
  `NotificationService` (flutter_local_notifications + timezone) and
  `FileService` (share_plus to save or share, file_selector to pick).
- Add to `domain/use_cases/` only when logic is shared across ViewModels or
  spans repositories. Current ones: `DailyProgress` (Today + Timer) and
  `ProjectTotals` (Projects), `PeriodReport` / `ReportRange` (Reports),
  `encodeEntriesCsv` and `BackupFormat`. Finished time is summed in
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

App-wide pieces outside the routes: `IdleWatcher` (in `MaterialApp.builder`)
and the `reminderSyncProvider` / `runningTimerNotificationSyncProvider`,
which the app root listens to.

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

### Brand, splash and motion

- **Logo:** `TempoLogo` (white stopwatch on brand blue) is the single source.
  `tool/generate_brand_assets.dart` renders it into `web/favicon.png`,
  `web/icons/*` (incl. maskable) and `branding/splash_*.png`. Regenerate:

  ```sh
  flutter test tool/generate_brand_assets.dart
  dart run flutter_native_splash:create --path=flutter_native_splash.yaml
  ```

- **Splash:** native splash (Android incl. 12+, iOS, web) is brand blue
  (`#1E3CB8` in dark mode) with the stopwatch at 96 dp. `main()` holds it
  while preferences load, then `LaunchOverlay` takes over on an identical
  first frame and plays a ~1.3 s intro: a ring sweeps round the stopwatch,
  the logo lifts away, and a circle opens to reveal the app.
- **Motion tokens:** `AppMotion` (durations + Material 3 easing). Always go
  through `AppMotion.of(context, …)`: it returns zero when the OS
  "reduce motion" setting is on, and the launch intro, pulses and
  entrances are then skipped.
- **Shared pieces** (`ui/core/widgets/motion.dart`): `FadeSlideIn`
  (staggered list entrance; key it by id so only new rows animate),
  `CountUpDuration`, `AnimatedProgressBar`, `PulsingDot`, `ScaleSwitcher`
  and `SmoothSize`. Use `SmoothSize` rather than `AnimatedSize`, which asserts
  with a zero duration. `ProgressRing` sweeps in and glides; the timer runs it
  linearly over each second so it moves continuously.
- **Navigation:** routes use Material 3 fade-forwards (Cupertino slide on
  iOS / macOS); tabs fade through (`FadeThroughBranches`) and keep their
  state. Segmented controls slide their pill.
- **Haptics** (`ui/core/haptics.dart`) on start / stop / pause; fire-and-forget,
  so a platform without haptics can't block the action.
- **Tests:** `testApp` turns reduce-motion on by default so `pumpAndSettle`
  never waits on repeating animations; pass `reduceMotion: false` to test the
  motion itself (see `test/ui/core/motion_test.dart`).

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
5. ✅ Reports (`fl_chart`), then Settings and reminders (`flutter_local_notifications`)

Every screen in the prototype is built.

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
- Reports: weeks are calendar weeks starting on Settings › Week starts on, so
  future days show empty bars. (The prototype shows the last 7 days.) The
  "vs last week" chip compares with the *same part* of the previous period,
  so Tuesday evening is compared with last Monday–Tuesday evening, not the
  whole of last week. Entries are split across hour/day buckets.
- Export: Reports › download exports the shown period, Settings › Export as
  CSV everything. Column names stay English. Backup is versioned JSON
  (projects + entries, not settings); restore replaces everything after a
  confirmation and keeps ids. Onboarding can start from a backup.
- Notifications work on Android, iOS and macOS only. Elsewhere (web, Linux,
  Windows) the two reminder switches are disabled and say why. Turning
  either one on asks for permission; if refused it stays off.
  - "Remind me to start": Monday–Friday at the chosen time, inexact (no
    exact-alarm permission needed).
  - "Running timer notification": ongoing, with a live chronometer on
    Android. It has no Stop/Pause buttons; those would need a background
    isolate with database access. The subtitle says "Shows the running timer
    on the lock screen" instead of the prototype's "Stop or pause…".
- Idle detection on a phone means "away from the app": coming back after
  10+ minutes with a timer running asks to keep the time or stop the timer
  when you left. It only works while the OS keeps the app process alive.
- Daily goal steps by 30 min (1h–16h).
- Native setup already done: Android desugaring, boot / scheduled receivers,
  `RECEIVE_BOOT_COMPLETED`, `res/raw/keep.xml` for the notification icon in
  release builds. iOS sets the notification centre delegate. macOS has the
  user-selected-file entitlement for restore. The app is named "Tempo" on
  Android and iOS.
- Widget tests go through `testApp` (`test/testing/app_tester.dart`). It runs
  at the 390 × 844 prototype size and unmounts the app, so drift's stream
  timers finish before the test ends.
