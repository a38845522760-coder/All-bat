# Iron Yard

**Iron Yard** is a mobile-first 3D game project built with Godot 4. The project is being designed around scalable graphics, modular game modes, and local multiplayer over a Wi-Fi hotspot.

> **Current status:** Phase 1 — project foundation. This package contains the Godot project skeleton, core autoload services, architecture notes, and development conventions. It is not yet a playable game and does not contain finished maps, characters, weapons, AI, or multiplayer gameplay.

## Open the project

1. Install Godot **4.4 or newer**.
2. Extract this archive.
3. In Godot Project Manager, choose **Import** and select `project.godot` inside the extracted `IronYard` folder.
4. Open and run the project. The current boot screen confirms that the foundation project loads.

The project currently selects Godot's **Mobile** renderer as its primary rendering path. Device compatibility, Android export, and performance still need to be tested on target phones before release. The Compatibility renderer is a possible fallback to evaluate if a target device cannot run the Mobile renderer.

## Current foundation

- Godot 4 project configuration and boot scene.
- Autoload services: `EventBus`, `AppState`, `SettingsManager`, and `SaveManager`.
- Persistent settings stored under `user://iron_yard_settings.cfg`.
- Versioned save-data container stored under `user://iron_yard_save.json`.
- Defined folder boundaries for scenes, scripts, assets, data, and tests.
- Architecture and development documentation.

## Planned game pillars

- First-person 3D gameplay with touch controls and desktop input.
- Large, detailed industrial environment and additional selectable maps.
- AI-controlled opponents and teammates.
- Free For All, Team Deathmatch, Capture the Flag, and Bomb Mode.
- Local 2–4 player matches over a shared Wi-Fi hotspot, without requiring internet access.
- A separate zombie mode. Its story, enemies, equipment, and detailed mechanics will be specified before that mode is implemented.
- Graphics profiles from Low through Ultra, tuned through profiling on real Android devices.

## Project structure

```text
IronYard/
├── project.godot
├── assets/                 # Imported and source art/audio assets
├── data/definitions/       # Data-driven game definitions
├── docs/                   # Architecture, roadmap, and setup notes
├── scenes/
│   ├── boot/
│   ├── game_modes/
│   ├── player/
│   ├── ui/
│   └── world/
├── scripts/
│   ├── autoload/           # App-wide services only
│   ├── boot/
│   ├── core/
│   ├── game_modes/
│   ├── network/
│   └── player/
└── tests/
```

## Important limits at this stage

The graphics profiles are currently configuration definitions; they do not yet change live rendering settings. Save/settings persistence is implemented as a foundation, but the final progression schema is not frozen. The multiplayer and zombie folders are architectural boundaries only. See `docs/PHASE_1_CHECKLIST.md` for the exact scope.
