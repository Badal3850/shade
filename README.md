# shade

Your digital shade — a pet that roasts your life using real data.

## Tech Stack

- **Framework:** Flutter 3.41.9 (Dart 3.11.5)
- **AI:** Claude API (pet voice, story generation)
- **Storage:** SQLite via Drift
- **Sensors:** sensors_plus, pedometer, battery_plus
- **Weather:** Open-Meteo API (free)

## Architecture

Feature-first Clean Architecture:

```
lib/
  core/          # Shared infrastructure (theme, constants, DB, DI)
  features/
    pet/         # Pet state machine, decay logic
    sensors/     # Accelerometer, battery, steps
    weather/     # Open-Meteo integration
    story/       # AI-generated content pipeline
    onboarding/  # First-time setup flow
```

## Setup

```bash
flutter pub get
dart run build_runner build
flutter run
```

## CI/CD

GitHub Actions builds signed APKs and publishes to GitHub Releases on push to main.
