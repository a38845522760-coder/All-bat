# Development Setup

## Required tools

- Godot Engine **4.4 or newer** (standard editor build).
- Git for version control.
- Android SDK/JDK configured through Godot Editor settings when Android export work begins.

Do not commit local SDK paths, keystores, passwords, signing files, or `export_presets.cfg` containing private values.

## First launch

1. Extract the project folder.
2. Import `project.godot` in Godot Project Manager.
3. Allow Godot to complete its initial import.
4. Run the project (F6 is not required; use the main-project Run button).
5. Confirm that the Iron Yard foundation screen appears and no autoload errors are printed.

## Coding conventions

- Use typed GDScript for public method parameters and return types where practical.
- Use `snake_case` for files, functions, and variables; use `PascalCase` for classes and node types.
- Keep autoloads limited to cross-scene application services.
- Prefer composition and small scenes/scripts over one large manager.
- Keep secrets and generated builds out of Git.
- Add a brief test note to the relevant feature change.

## Android and performance policy

Android export is not configured in Phase 1. Package ID, orientation, minimum API, export template, signing, and required permissions must be finalized and tested in the Android phase. The intended OS floor is Android 8.1, but actual compatibility must be verified on representative devices and GPU drivers.

Do not use a desktop FPS result as proof of mobile performance. Record device model, Android version, renderer, graphics profile, average frame time, frame-time spikes, memory use, and thermal behavior during sustained tests.
