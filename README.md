# Tempo

**Know where your hours go.**

Tempo is a simple, offline-first time tracker. Start a timer in one tap, sort
your time by project, and see your day, week or month at a glance. It runs on
Android and iOS (and also builds for web, macOS, Windows and Linux), and it
speaks **Khmer** and **English**.

<p align="center">
  <img src="prototype/02%20%C2%B7%20Today%20(Home).png" alt="Today screen" width="220">
  <img src="prototype/03%20%C2%B7%20Running%20timer.png" alt="Running timer" width="220">
  <img src="prototype/07%20%C2%B7%20Reports.png" alt="Reports" width="220">
</p>

## Is it free?

**Yes.** Tempo is completely free to use:

- No price, no subscription, no in-app purchases
- No ads
- No account or sign-up
- No internet connection needed — everything is stored on your own device

## How it works

1. **Get started.** The first time you open Tempo, a short welcome screen
   shows what the app does. Tap **Get started**, or restore a previous backup
   if you used Tempo before.
2. **Track your time.** On the **Today** screen, tap to start a timer, pick a
   project and add a description or tags. Tap again to stop. Pause and resume
   whenever you need a break. The timer keeps counting even if you close the
   app.
3. **Fix or add entries.** Forgot to start the timer? Add an entry by hand, or
   edit the start and end time of any entry later.
4. **Organise with projects.** Create projects with their own colour and a
   weekly goal (for example "Work — 40h a week"). Tempo shows how close you
   are to each goal. Old projects can be archived and restored.
5. **Check your reports.** The **Reports** tab shows charts by day, week or
   month, a breakdown by project, your daily average, and how you compare with
   the previous period.
6. **Make it yours.** In **Settings** you can change the daily goal, which day
   the week starts on, the language (Khmer / English) and the theme (light /
   dark).

### Helpful extras

- **Idle detection** — if you leave the app for 10+ minutes with a timer
  running, Tempo asks whether to keep that time or stop the timer when you
  left, so your records stay honest.
- **Reminders** — an optional weekday reminder to start tracking, and a
  notification that shows the running timer on your lock screen
  (Android, iOS and macOS).
- **Export & backup** — export your entries as a CSV file for Excel or Google
  Sheets, and back up / restore all your projects and entries as a file.

## Why use Tempo?

- **See where your time really goes.** Most people guess wrong about how long
  tasks take. Real numbers help you plan better and spot time-wasters.
- **Stay focused and motivated.** Daily and weekly goals, with a progress
  ring, give you a clear target and a sense of progress every day.
- **Bill and report accurately.** Freelancers and students can turn tracked
  hours into invoices, timesheets or study logs with the CSV export.
- **Private by design.** Your data never leaves your phone. There is no
  server, no tracking and no account that could be leaked.
- **Works anywhere.** Because it is offline-first, Tempo works on a plane, in
  the countryside, or anywhere without Wi-Fi or mobile data.
- **Made for Khmer speakers.** Khmer is the default language, with a font that
  displays Khmer text clearly. English is one tap away.

## For developers

The Flutter app lives in [`tempo_app/`](tempo_app). Quick start:

```sh
cd tempo_app
flutter pub get
dart run build_runner build   # drift + freezed code generation
flutter run
```

See [`tempo_app/README.md`](tempo_app/README.md) for the architecture (MVVM
with Riverpod, go_router, drift/SQLite), localization and implementation
notes. The designs and user flow are in [`prototype/`](prototype).
