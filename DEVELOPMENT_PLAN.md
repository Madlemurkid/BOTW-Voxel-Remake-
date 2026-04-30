# Voxel Open-World Action Adventure Plan (BOTW-Style Mechanics, Original IP)

## Goal
Build an original voxel open-world action-adventure with systemic gameplay and exploration mechanics inspired by modern physics-driven action RPG design, while using fully original story, characters, world layout, dialogue, art, audio, UI, and naming.

## Guardrails (Non-Negotiable)
- Do not copy any proprietary map layouts, quests, item names, UI assets, music, sound effects, dialogue, character likenesses, or lore.
- Recreate categories of mechanics (climbing, stamina, weather interactions, emergent physics) with original tuning and implementation details.
- Maintain a design log documenting how each feature is transformed into original content.

## Product Pillars
1. **Systemic world simulation**: Fire, electricity, temperature, wetness, wind, mass/impulse interactions.
2. **Traversal freedom**: Climb almost any surface, glide, swim, mount-based travel.
3. **Emergent combat**: Physics + elemental interactions + resource constraints.
4. **Discovery loop**: Landmarks, puzzles, micro-dungeons, roaming events.
5. **Living world**: NPC schedules, factions, shops, crafting/cooking, weather-aware behaviors.

## Original Setting and Narrative Framework
- **Setting**: Shattered archipelago continent where floating landmasses drift above a storm sea.
- **Player role**: A "Wayfinder" restoring ancient relay beacons to reconnect regions.
- **Story structure**:
  - Act I: Reconnect 3 starter regions and learn core tools.
  - Act II: Resolve faction conflicts and unlock high-risk sky/depth zones.
  - Act III: Activate final beacon network and confront a world-scale storm entity.
- **Narrative delivery**: Environmental storytelling + voiced key scenes + optional lore archives.

## Core Mechanics (Target-Equivalent Scope, Original Implementation)

### 1) Movement & Traversal
- Third-person movement with sprint, jump, ledge catch.
- Stamina-gated climbing with surface classes (rough, smooth, wet, unstable).
- Glide system with stamina drain and wind uplift exploitation.
- Swimming/diving with current forces and temperature penalties.

### 2) Combat
- Melee weapon families: light, heavy, pole, two-handed improvised.
- Ranged options: bows/slings/throwables with draw-time variance.
- Lock-on + soft-target assist + directional dodge/parry windows.
- Enemy armor states, stagger thresholds, weak-point reactions.

### 3) Physics + Element Systems
- State tags per entity: `wet`, `frozen`, `burning`, `conductive`, `charged`, `oiled`.
- Fire propagation by material flammability + wind direction.
- Electrical chaining through conductive actors and water surfaces.
- Time-limited stasis/impulse storage mechanic (original naming/FX).

### 4) Tool/Ability Kit (Original)
- **Grav Latch** (magnet-like): manipulate tagged metallic objects.
- **Pulse Bind** (stasis-like): freeze target and accumulate force.
- **Cryo Weave**: create temporary ice structures on water.
- **Torrent Bomb** variants: elemental remote detonations.
- Unlock upgrades through challenge sanctums.

### 5) Survival/Economy Systems
- Weapon durability and repair economy (not disposable-only).
- Cooking with ingredient traits: heat, chill, vigor, stealth, shock resist.
- Vendor schedules and dynamic stock by region progression.
- Crafting tiers tied to biome resources and faction reputation.

### 6) World Progression
- Beacon towers reveal map sectors and enable fast travel nodes.
- Sanctums (puzzle/combat/traversal trials) grant upgrade currency.
- Regional dungeon equivalents unlock faction tech and story beats.

## World Content Plan
- 8 major regions, each with:
  - 1 hub settlement
  - 4–6 minor outposts
  - 10–15 points of interest
  - 12–20 sanctum-style challenges
- Dynamic encounter director for roads, storms, and faction skirmishes.
- Wildlife ecology loop (predator/prey/resource migration).

## NPC/Quest Architecture
- Daily schedule graph: home/work/travel/shelter/sleep states.
- Dialogue conditions: time, weather, prior quest states, faction rank.
- Quest types: navigation, puzzle chain, rescue, hunt, escort, investigation.
- Main quest gated by beacon milestones; side quests deepen region mechanics.

## Technical Architecture
- **Engine**: Unity/Unreal/Godot (select based on team skill and tooling).
- **Voxel world**:
  - Chunk streaming, async generation/loading.
  - Mesh LOD and impostor strategy for long-range views.
  - Selective destructibility rules for performance and save-size control.
- **Data-driven design**:
  - Gameplay tags and tuning tables.
  - Scriptable quest/event graph.
  - Save-game diff system for persistent world state.

## Production Roadmap (for the assistant execution strategy)

### Phase 0 (Weeks 1–4): Preproduction
- Finalize game pillars, legal guardrails, and GDD skeleton.
- Choose engine and establish repository structure.
- Build graybox test arena for movement/combat/physics.

### Phase 1 (Weeks 5–12): Vertical Slice
- Implement movement, climbing, gliding, stamina.
- Implement one enemy family, one settlement prototype, one sanctum.
- Prototype ability trio (Grav Latch, Pulse Bind, Cryo Weave).
- Add minimal UI/HUD and inventory.

### Phase 2 (Months 4–8): Core Systems Alpha
- Expand combat families and elemental interactions.
- Implement quest framework, NPC schedules, shops, cooking.
- Build 2 full regions with tower/beacon and map reveal.
- Performance baseline: stable frame targets on target platform.

### Phase 3 (Months 9–14): Content Pipeline Scale-Up
- Tooling for biome stamping, encounter authoring, sanctum templates.
- Produce remaining regions using repeatable pipeline.
- Add dungeons, bosses, faction questlines.

### Phase 4 (Months 15–20): Beta
- Full progression path playable end-to-end.
- Balance economy, difficulty, traversal stamina tuning.
- QA pass: quest blockers, physics exploits, save corruption tests.

### Phase 5 (Months 21–24): Polish/Launch Prep
- Animation polish, accessibility options, UX clarity.
- Audio pass, optimization, bug burn-down.
- Release candidate stabilization and patch plan.



## Visual Quality Plan (Real Textures + Material Pipeline)
- Target an art style that combines voxel geometry with high-quality PBR materials (albedo, normal, roughness, AO, optional height).
- Create a texture library per biome (grassland, volcanic, alpine, desert, ruins, interiors) with strict texel density targets.
- Use tri-planar or UV-aware material projection rules to avoid visible stretching on voxel surfaces.
- Add material blending masks (moss/dirt/wetness/snow) for believable environmental variation.
- Implement terrain decals for paths, mud, scorch marks, puddles, and camp wear patterns.
- Lighting pass requirements:
  - Time-of-day directional light + sky atmosphere
  - Cascaded shadows for near/mid/far
  - Reflection probes in settlements/dungeons
  - Color grading LUTs per biome and weather type
- Asset quality gates:
  - No placeholder checker textures in milestone demos
  - Material consistency review before each milestone exit
  - Texture memory budget per platform enforced in CI reports

## Full Working Minimap + World Map Implementation
- Minimap must ship as a fully functional feature (not cosmetic placeholder).
- Required capabilities:
  - Real-time player tracking and orientation indicator
  - Zoom levels (near/medium/far)
  - North lock and rotate-with-camera toggle
  - Terrain, roads, water, settlements, beacon towers, quest markers
  - Custom pins and filter toggles (quests, vendors, sanctums, stables)
  - Fog-of-war reveal tied to exploration and tower/beacon activations
  - Indoor/outdoor behavior rules (dungeon floor map when available)
- Data pipeline:
  - Generate minimap tiles from world chunks and biome/material metadata
  - Stream map tiles asynchronously with cache eviction to control memory
  - Persist exploration mask and placed markers in save data
- UX requirements:
  - One-input quick-open for expanded regional map
  - Clear legend and marker hierarchy for readability
  - Accessibility-safe color palette and icon contrast
- Validation tests:
  - Marker placement/removal persistence tests
  - Exploration reveal regression tests
  - Performance test in dense settlement and high-speed mount traversal

## Team & Resourcing (Indicative)
- 1 Creative Director / 1 Production Lead
- 4–8 Gameplay Engineers
- 2–4 Engine/Tools Engineers
- 6–12 Environment/Character Artists
- 3–6 Animators
- 2–4 Designers (systems/world/quest)
- 2 Narrative + 1 Audio + 4+ QA (scaled over time)

## Risks & Mitigations
1. **Scope explosion** → Strict feature gates and milestone exit criteria.
2. **Performance bottlenecks (voxel + simulation)** → Early profiling and hard budgets.
3. **Systemic bug complexity** → Automated gameplay tests for state interactions.
4. **Content throughput** → Modular templates + procedural assist tools.
5. **IP adjacency risk** → Red-team originality reviews every milestone.

## Definition of Done (Release)
- All main story acts playable with no blocker bugs.
- 95%+ quest completion success in QA regression set.
- Stable target framerate and memory budgets met.
- Accessibility baseline shipped (rebinding, subtitles, color presets, camera options).
- Original-IP compliance review passed.

## Immediate Next Actions
1. Lock engine choice and target platform.
2. Build the vertical-slice backlog with task-level estimates.
3. Implement traversal + stamina first, then one sanctum prototype.
4. Run weekly playtests and tuning review against pillar checklist.
