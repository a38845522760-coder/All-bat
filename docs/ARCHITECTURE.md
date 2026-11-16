# Iron Yard — Architecture

## 1. Design goals

1. **Mobile-first:** touch input, memory use, thermal load, and frame time are first-class constraints.
2. **Scalable rendering:** Low, Medium, High, and Ultra are explicit profiles. Their real renderer effects must be implemented and measured rather than merely changing labels.
3. **Modular gameplay:** player, world, match rules, AI, progression, UI, and networking remain separate systems.
4. **Offline-capable local multiplayer:** the intended 2–4 player mode uses a host on the same local Wi-Fi/hotspot network. It must not depend on an internet service for a local match.
5. **Extensible modes:** the zombie mode is a separate game-mode module. Its narrative and detailed design remain open until the game designer supplies them.

## 2. Runtime layers

### Application / core

Owns application state, settings, save data, event routing, and scene transitions. It must not contain match-specific rules.

### Gameplay domain

Owns player state, teams, match flow, score, inventory, economy, AI, and mode rules. Match rules should be data-driven where practical. A future shared match contract should allow different modes to reuse player, team, scoring, and result systems without coupling them to a specific map.

### World / presentation

Owns maps, environment props, lighting, materials, animation, audio, HUD, and menus. World scenes should expose clearly named spawn points and gameplay locations rather than embedding match logic in environment art.

### Platform / networking

Owns local peer discovery/connection flow, host authority, connection state, Android-specific platform integration, and persistence boundaries. Gameplay code should call a small networking interface rather than depending on platform APIs directly.

## 3. Autoload service contracts

| Service | Responsibility | Must not become |
|---|---|---|
| `EventBus` | Typed application-wide signals for cross-system events | A storage area for arbitrary game state or business logic |
| `AppState` | Current screen/session metadata and high-level session transitions | A replacement for the match controller |
| `SettingsManager` | Defaults, validation, quality-profile definitions, and settings persistence | A scene-specific UI controller |
| `SaveManager` | Versioned persistent player data and future migrations | A holder for temporary in-match state |

Keep these services small. A gameplay subsystem should own its own state and expose signals or methods to other systems.

## 4. Proposed gameplay boundaries

- `Player`: movement, camera, interaction, health, animation, and input adapters.
- `World`: map composition, spawn locations, navigation data, streaming boundaries, and interactable stations.
- `Match`: lifecycle, teams, timers, score, results, and mode-independent rules.
- `GameModes`: independent rule modules for Free For All, Team Deathmatch, Capture the Flag, Bomb Mode, and later Zombie Mode.
- `AI`: navigation, perception, decision-making, and team role selection. AI behavior is game simulation, not a real-world tactics model.
- `Inventory / Economy`: game-only equipment, ammunition counts, credits, unlocks, and shop transactions.
- `Network`: host/client session, replicated state, validation, and reconnect handling.
- `UI`: menus, touch HUD, settings, match HUD, shop, and results.

The exact node/class APIs for these systems will be settled when their first playable implementations are built, not prematurely frozen in Phase 1.

## 5. Local multiplayer model

The intended first version is a host-authoritative local session for 2–4 devices:

- One device creates a room and acts as the host.
- Other devices join over the same Wi-Fi or phone hotspot.
- Match state is validated by the host and replicated to clients.
- A local match must continue to work with mobile data and internet access disabled, provided the hotspot/Wi-Fi network itself is active.
- Connection loss, host departure, reconnection, and invalid room data require explicit handling.

Discovery and Android network permissions will be investigated during the networking phase. Do not assume that a hotspot connection automatically guarantees peer discovery on every Android version/device.

## 6. Zombie mode boundary

Zombie Mode will have its own scene/module and mode-specific enemy, progression, and round logic. Shared systems (player, inventory, score persistence, networking, audio, UI primitives) may be reused through documented interfaces. The story, zombie types, map details, equipment list, and unique mechanics are deliberately not specified in this scaffold.

## 7. Graphics profiles

The initial profile definitions live in `scripts/autoload/settings_manager.gd`:

- **Low:** lowest render scale/effect density and reduced shadow tier.
- **Medium:** balanced defaults for typical phones.
- **High:** full internal render scale and richer effects.
- **Ultra:** highest supported settings, subject to device capability and thermal limits.

These are configuration targets only. In the graphics implementation phase, each property must map to a real Godot renderer setting or a game-level quality switch. Profile selection must never imply that unsupported GPU features are available. Use LOD, visibility ranges, instancing, occlusion/visibility strategies, texture compression, and measured scene budgets. Dynamic quality adjustment must be introduced only after stable frame-time measurement exists.

The project selects the Mobile renderer initially. Test it on target Android hardware. If compatibility testing reveals devices that cannot run it, evaluate a separate Compatibility-renderer build; do not silently promise support without device tests.

## 8. Asset and scene rules

- Keep source assets in `assets/`; avoid embedding large binary assets in scripts.
- Prefer reusable scenes for props and gameplay objects.
- Use descriptive, stable resource names and avoid spaces in file paths.
- Separate source art from generated/imported Godot cache (`.godot/` is ignored by Git).
- Large maps should be designed for region-based visibility and loading before their content grows.
- Keep game rules out of map-specific prop scripts wherever possible.

## 9. Save-data rules

Save files are versioned. Any future schema change must increment `SAVE_VERSION` and add an explicit migration path before old user saves are changed. Never store credentials, signing keys, or other secrets in game saves or the repository.
