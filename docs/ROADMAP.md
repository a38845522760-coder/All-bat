# Iron Yard — Development Roadmap

## Phase 1 — Foundation

- [x] Create the Godot 4 project skeleton.
- [x] Establish folder boundaries and project conventions.
- [x] Add application-wide autoload service stubs.
- [x] Add persistent settings and versioned save-data foundations.
- [x] Document architecture, graphics-profile intent, and future game-mode boundaries.
- [ ] Import and run in the Godot editor on the developer's machine.
- [ ] Verify the project on at least one target Android device.

## Phase 2 — Playable core

- First-person player controller and camera.
- Touch controls plus keyboard/mouse input.
- Collision, interaction, and player-state foundations.
- A small test arena for movement and performance validation.

## Phase 3 — World and rendering

- Industrial test map with authored scale and navigation space.
- Modular structures, props, materials, lighting, and environment effects.
- Spawn-point definitions and map boundaries.
- LOD/visibility strategy and performance profiling.

## Phase 4 — AI and match framework

- AI navigation and basic game-simulation behavior.
- Teams, match lifecycle, scoring, timers, and results.
- Reusable match contract shared by game modes.

## Phase 5 — Inventory and progression

- Game-only inventory, equipment definitions, credits, score, unlocks, and shop transactions.
- In-map shop stations and save-data migration tests.

## Phase 6 — Core multiplayer modes

- Free For All, Team Deathmatch, Capture the Flag, and Bomb Mode.
- Match selection, lobby flow, scoreboard, and results.

## Phase 7 — Local multiplayer

- Host/client session over local Wi-Fi/hotspot.
- 2–4 player room flow, state replication, host validation, reconnect handling, and device testing.
- No internet dependency for a local match.

## Phase 8 — Zombie mode

- Implement after receiving the designer's story and mode specifications.
- Reuse shared systems only through clear interfaces.

## Phase 9 — UI and UX

- Main menu, map/mode selection, lobby, HUD, inventory/shop, settings, and results.

## Phase 10 — Graphics and optimization

- Connect Low/Medium/High/Ultra profiles to real renderer/game settings.
- Test sustained performance, thermal behavior, and memory on multiple devices.

## Phase 11 — Audio and polish

- Music, environmental audio, UI feedback, animation polish, and accessibility options.

## Phase 12 — QA and Android release

- Functional, multiplayer, save migration, installation, and performance testing.
- Configure Android export, signing outside the repository, and release artifacts.

A phase is not complete merely because its files exist. It is complete only after its acceptance checks have been run and documented.
