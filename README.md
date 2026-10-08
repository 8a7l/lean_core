# Lean Core

A minimal server base for Luanti (formerly Minetest), optimized
for running with a large number of players.

## What is it

Lean Core is a "bare skeleton" game that you can extend with mods
as needed. Only three mods are included:

- `default` — blocks, tools, crafting, world generation;
- `player_api` — player model and animations;
- `spawn` — spawn point.

Everything else (flowers, doors, furniture, TNT, stairs, wool, etc.)
has been deliberately removed to make the server start faster and
consume fewer resources.

## Why

The goal is minimal server load while keeping basic gameplay.
This is not a "simplified version of Minetest Game" but a
**clean foundation for your own project**.

## Changes compared to Minetest Game

### World generation
- Removed biomes: `icesheet`, `tundra`, `cold_desert` (and their subtypes).
- Removed decorations: `marram_grass`, `tundra moss`, `tundra patchy snow`.
- Fixed references to removed mods `stairs`, `walls` in biomes.
- Kept corals and papyrus — for mods that use them.

### Constant load (ABM)
- All 6 ABMs slowed down by 4x (intervals 6→24, 8→32, 16→64, etc.).
- Result: ~4x less CPU work per second.

### Items on the ground
- Removed item burning check (`item_entity.lua`).
- Items simply disappear over time (`item_entity_ttl` in `minetest.conf`).

### Furnaces
- Active furnace sound: every 5 sec → 15 sec.
- Cooling sound is quieter and plays less often.

### Chests
- Localized `minetest.*` calls in hot paths.
- Action logging preserved.

### Player animations
- `globalstep` runs every 0.3 sec instead of every tick.
- Animations remain smooth, load reduced by ~2x.

### Cleanup
- Removed 18 unnecessary settings from `settingtypes.txt`.
- Removed game description translations (`.de.tr`, `.fr.tr`) — the
  description now comes from `game.conf`.
- Added `stubs.lua` — stub nodes for removed mods
  (`flowers:mushroom_*`), so the log stays clean.

## Installation

1. Download the archive from the **Releases** section.
2. Unpack the `lean_core` folder into the `games` directory of your Luanti.
   Typical paths:
   - **Windows:** `%APPDATA%\Luanti\games\` or next to `bin\`
   - **Linux:** `~/.minetest/games/` or `~/.luanti/games/`
3. Launch Luanti → the game should appear in the list as **Lean Core**.

## Recommended settings

In `minetest.conf` for minimal load:

```ini
# Time-to-live for items on the ground (seconds)
item_entity_ttl = 60

# Active block range around each player (smaller = lighter)
active_block_range = 2

# Block generation distance
max_block_generate_distance = 6

# Map save interval (seconds)
server_map_save_interval = 15
```

## Origin

Lean Core is a fork of [Minetest Game](https://github.com/luanti-org/minetest_game),
created with the goal of minimizing server load.

The original code is distributed under LGPL-2.1+
(Copyright © 2011-2018 celeron55, Perttu Ahola and other contributors).
Lean Core inherits this license.

Significant changes made in Lean Core are listed above in the
"Changes compared to Minetest Game" section.

## License

The engine code of Lean Core is based on **Minetest Game**, which
is distributed under **LGPL-2.1+**. This project therefore inherits
the same license. See `LICENSE.txt` for details.

Textures, sounds and models have their own licenses (mostly
CC BY-SA 3.0). Full list in `mods/default/license.txt`,
`mods/player_api/license.txt`, `mods/spawn/license.txt`.

## Author

8a7l

## Credits

- The Luanti / Minetest team for the engine and base game.
- Everyone who made Minetest Game open and free.
