# Test Plan

## Phase 1 smoke checks

Run these in Godot Editor after importing the project:

1. Project Manager imports `project.godot` without parse/import errors.
2. Press Run Project; `scenes/boot/boot.tscn` opens.
3. Confirm all four autoloads initialize without script errors.
4. Change a setting through `SettingsManager`, restart, and confirm it persists.
5. Write a temporary test value through `SaveManager.save_game()`, restart, and confirm it reloads.
6. Confirm no `.godot/`, export output, or signing secrets are tracked by Git.

## Later test suites

- Player movement/input tests.
- Map spawn/collision/navigation tests.
- Match lifecycle and scoring tests.
- Save schema migration tests.
- Local Wi-Fi/hotspot tests with 2, 3, and 4 physical devices.
- Sustained Android frame-time, memory, and thermal tests for each graphics profile.
