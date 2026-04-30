# Voxel Wayfinder Prototype (PC-first)

## Fully implemented section (vertical slice): **Relay Alpha Story Section**
This section is now built end-to-end as a complete gameplay loop:
1. Reach Relay Alpha tower.
2. Hold **E** to activate the relay.
3. Activation unlocks map region state and advances story objective.
4. A Warden boss spawns.
5. Defeat the boss with melee attacks.
6. Story objective updates to section-complete.

## Implemented systems in this section
- Objective-driven story state machine (`story_manager.gd`).
- Tower interaction with hold-to-activate logic (`tower_unlock.gd`).
- Persistent map/tower unlock state (`game_state.gd` autoload).
- Boss activation + chase/combat health loop (`boss_controller.gd`).
- Player attack signal and stamina gameplay loop (`player_controller.gd`).
- Section coordinator wiring player attacks to boss damage and story completion (`section_one_coordinator.gd`).
- HUD for objective text, stamina bar, tower prompt, and boss health (`hud_controller.gd`).

## Controls
- Move: WASD
- Jump: Space
- Sprint: Shift
- Attack: Left Mouse
- Interact / Activate Tower: E (hold)
- Mouse look: move mouse
- Release mouse: Esc

## Run
1. Install Godot 4.x.
2. Open `game/project.godot`.
3. Press Play.
