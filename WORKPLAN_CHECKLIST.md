# Workplan Checklist

This checklist guides recurring automation runs. Keep it practical: each checked item should be playable, documented, or validated in the Godot prototype.

## Current Vertical Slice
- [x] Godot 4.x project skeleton under `game/`.
- [x] Chunked terrain generation around the player.
- [x] Third-person movement, camera, jump, sprint, and stamina bar.
- [x] Relay Alpha tower interaction with hold-to-activate flow.
- [x] Persistent relay/map unlock state in `GameState`.
- [x] Story objective state machine for the Relay Alpha section.
- [x] Warden boss spawn, chase, health, and defeat objective.
- [x] Minimap viewport tracking the player.
- [x] Stamina-gated gliding while falling, bound to F.
- [ ] Godot playtest pass for the latest glide tuning.

## Phase 1: Traversal and Exploration
- [ ] Add stamina-gated climbing on tagged rough surfaces.
- [ ] Add wind/updraft volumes that extend glide routes without copying any named BOTW locations or items.
- [ ] Add ledge catch and mantle recovery.
- [ ] Add fall damage rules that account for gliding and water landing.
- [ ] Add a first curiosity POI chain near Relay Alpha: visible landmark, environmental clue, micro-puzzle, reward, and next hook.
- [ ] Add minimap relay/POI/boss markers and simple marker persistence.

## Phase 1: Combat and Abilities
- [ ] Add weapon selection from `weapons.json` instead of fixed melee damage.
- [ ] Add weapon durability and repair hooks.
- [ ] Prototype **Grav Latch** with original tagged-metal object manipulation.
- [ ] Prototype **Pulse Bind** with short freeze plus stored impulse.
- [ ] Prototype **Cryo Weave** with temporary ice platforms on water.
- [ ] Add at least one enemy weak-point/stagger behavior.

## Phase 1: Systemic World Simulation
- [ ] Add shared material-state component/data for `wet`, `burning`, `conductive`, and `frozen`.
- [ ] Add fire propagation between flammable props with wind direction as a tuning input.
- [ ] Add electricity chaining through conductive/wet actors.
- [ ] Add development HUD/debug overlay for active material states.
- [ ] Add small systemic puzzle that can be solved with at least two rule combinations.

## Phase 1: UI, Map, and Persistence
- [ ] Add expanded regional map quick-open.
- [ ] Add minimap zoom levels and north-lock/camera-rotate toggle.
- [ ] Save exploration mask, tower unlocks, placed pins, inventory, and story chapter.
- [ ] Add accessibility basics: remapping notes, subtitle-ready dialogue box, color-safe marker palette.

## Research-Backed Design Rules
- [ ] Build around consistent rules first, then content volume.
- [ ] Each region overlook should show 3-5 readable goals rather than a noisy field of icons.
- [ ] Use landmarks and partial information to create curiosity without forcing waypoints.
- [ ] Keep chest/reward exposure paced; avoid filler-only rewards.
- [ ] Introduce new activity types through the main path before scattering optional versions.
- [ ] Log originality decisions whenever a mechanic is inspired by a known open-world pattern.

## Research Sources To Revisit
- Nintendo UK, making-of videos for Breath of the Wild: https://www.nintendo.com/en-gb/News/2017/March/Go-behind-the-scenes-with-the-making-of-The-Legend-of-Zelda-Breath-of-the-Wild-1206592.html
- Nintendo of America / GDC 2017, "Breaking Conventions" session: https://www.youtube.com/watch?v=niIVdlavc7I
- GamesBeat summary of BOTW physics and chemistry discussion: https://gamesbeat.com/the-legend-of-zelda-breath-of-the-wild-makes-chemistry-just-as-important-as-physics
- Gomez-Maureira et al., curiosity-driven exploration patterns: https://research.tudelft.nl/en/publications/level-design-patterns-that-invoke-curiosity-driven-exploration-an/
- Tang and Kirman, treasure-chest curiosity and fatigue: https://www.sciencedirect.com/science/article/pii/S1071581925001326
- PC Gamer coverage of GDC open-world fatigue design problems: https://www.pcgamer.com/games/action/players-dont-explore-former-grand-theft-auto-6-and-red-dead-online-designer-lays-out-the-perils-of-open-world-fatigue/

## Next Automation Slice Candidates
1. Verify and tune gliding locally in Godot.
2. Add climbable-surface prototype and update stamina behavior.
3. Build the first curiosity POI chain near Relay Alpha.
4. Add minimap markers for relay, boss, and discovered POIs.
