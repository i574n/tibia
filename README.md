# tibia

[![깃허브 코드스페이스](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=1423729610)

A typed Tibia-rules simulator in Spiral, compiled to C, Rust and WGSL (GPU) from one source, used to train agents that
are measured against the best open-source Tibia bots on a public, reproducible benchmark: the **OT Agent Arena**.

## Status 2026-10-27

26 `.spi` modules in `src` (plus `src/standards.spi`, the package's standards checked by `kit standards`), and six apps:
`apps/arena` (24 files: 13 Lua programs for the live client and their shared modules), `apps/map` (the server-map tool
that generates terrain's walk, road, sight and protection-zone tables), `apps/predict` (C predictions over the
simulators), `apps/host` (the arena host: world port and executor), `apps/offscreen` and `apps/canary`.
- **Rules:** geometry, vitality, coins, rng, cooldowns, damage, combat, creatures, experience, skills, blessings, wire.
- **Typed domain:** quantity (phantom units), readiness (GADT witnesses), vocations (vocation-indexed
  spells), catalog (existential spawns), views (HKT `mapped` and `counted`), terrain (layouts, incl. the scanned arena spot).
- **Decisions:** policy, network (integer neural policy), search (evolution).
- **Simulators and entries:** hunt with its hunt_sim tests, hunting_pack (the multi-creature simulator) with its pack_sim
  and gpu_sim tests. Its GPU shader inlines to 252k lines (probe run 281 s); `knight_turn` is shared on C only.
- **Postable:** every top-level cell of every `.spi` fits one post (273 weighted characters): 65 files, 3,572 cells, 0
  over. The generated terrain tables are a fan-4 tree of small inline parts, checked equal to the old tables over every
  word, row and zone offset.
- **Lib:** every app references `lib/spiral` (`spiral-`); host macros are one-call primitives, and casts and parsing go
  through typed Spiral (lib `env`, `convert`, `csv`).

Tests name their targets with a reason: C as the oracle, WGSL for the GPU path, Lua for the live client, and Rust only
where a test needs the training host.

## Findings so far

Correction 2026-10-14: every live `spiral-*` run from 2026-10-13 11:48 until the fix ran with vBot's HealBot and TargetBot active alongside our policy (a bot setting the vBot probe left enabled; BENCHMARK.md, PR-1). The findings below come from the re-measurement on the fixed arena (PR-4, 30 runs per competitor, every run checked for foreign actions); the earlier live claims are withdrawn.

1. **The simulator predicts live clear times and, mostly, potion use.** Clear times matched in every live check.
   Potions took four corrections, each measured live or read from Canary's source: login protection keeps monsters off
   a fresh knight for 10 s; a simulator bug fielded three cyclops in small camps; monsters surround the knight instead
   of queueing (occupancy-aware routing, PR-7 holds out of sample); and monsters wander while the knight is protected,
   so every clear starts from a different geometry (before, every seed replayed one), with the cyclops swing pace
   measured at 2166 ms (`mirroring_the_live_arena`). Potions per unit of damage were always right; the misses were in
   hits taken. Against pooled live means the model now sits within the noise for rules and retreat at two and three
   cyclops (in-sample). Its out-of-sample check failed in one direction (PR-10): it predicted that preferring a monster
   already in reach costs 0.8 potions, and live it costs nothing (12.3 vs 12.5 for rules). Live, our policies drink
   alike. Since 2026-10-20 retreat steps cancel the pending swing as every walk does in Canary and the knight's think
   runs at the measured ~1083 ms (PC-6 confirmed both on fresh logs); with that the model gives ReachFirst 12.47 against
   rules 12.30, close to live, though that comparison is in-sample. Where nothing protects the fresh login (every
   arena since 2026-10-15), the model still predicts too many potions: rules 15.3 vs 14.4 (PR-11), retreat about 14.5 vs
   12.8 (PR-12), the hunting ground 15.5 vs 12.7 (PR-15, whose kill pace it predicts well: 12.4 vs 12.8 kills). The
   retreat gap traces to crowding: the model's knight is pinned in the spot's dead end with three cyclopes, the live one
   keeps stepping (4.0 vs 11.5 retreat steps per clear).
   Update 2026-10-21: the arena bundle `mirroring_the_current_arena` (Canary's knight step speed, dance step and step
   formula on the map's ground speed, with the knight acting on the client's last view) closes the cyclops gap out of sample. PR-17,
   40 fresh runs: rules 13.90 live against 14.55 predicted (t -0.87), retreat 13.25 against 12.81 (t 0.74); retreat
   steps 12.4 against 11.7 live. Since 2026-10-22 the bundle also carries two hunter-arena facts, each adopted by a rule written before measuring:
   three Canary timing facts (all3; PR-18 holds at 14 of 20 clears, where the bundle predicted 99 of 100), and arrows
   that stop only at projectile blockers, which lift predicted hunter hits from 14.9 to 21.0 per run (PR-19, 20 fresh
   runs: 20.45 live, t -0.40, and 15 of 20 clears; all3 alone rejects at t 3.86). The hunting ground's potion
   gap closed as noise on fresh hunts (PR-23, 2026-10-22: 14.8 live against 14.84 predicted at shield 11,
   t -0.05; PR-15's 12.7 was a low draw). Still open: the hunter clear time (55.9 s vs 60.5 s in PR-19), where
   live hunters walk faster at two to three tiles from the knight than the model's (about 1 tile per second against 0.44-0.66). A hunter run is decided
   by its first chase: live, the first target leads the knight 20 or more tiles away in about half the runs, and the
   run fails when the other hunters lose contact on such a chase; in the model such long chases are rarer (20%).
   Seven Canary movement facts were tested against this on 2026-10-21 and none passed in sample (TIBIA-FIDELITY). Since then, the model's long chases were traced to one path: once the knight lines up on a hunter's row, the hunter runs straight along it, the same way in every seed, while live hunters break off and still stay ahead (half of the live long chases end south, none of the model's do). Letting the model's hunters break off at random makes the knight catch every one, so the missing piece is what keeps a live hunter ahead after it turns. The likeliest answer is on the knight's side: when its target steps away from it, the live knight is still on its tile a second later in 98% of cases (the model's in 57-68%). Our competitor turns chase mode off while its target is adjacent, so Canary re-plans the knight's path only at the player's next one-second think and then waits a full step (TIBIA-FIDELITY note 85; a two-second follow timer, rule D30, was rejected). Modeled (rule D32), it reproduces the stalls (91% against 98% live) but the model knight then clears only 53 of 100 hunter runs against 72-95% live, so it stays off and the clear rate is the open question (notes 99-101). Retreat steps (15.1 vs 11.3 per clear)
   close when the knight's retreat steps follow the live competitor's own 650 ms pace: 11.7 predicted, 10.1 on 20 fresh
   runs (PR-20, t -0.54; potions 12.80 vs 13.32), adopted with the rest on 2026-10-22. The step count's spread is wide,
   so PR-20 could not reject the old 15.1 either, and its shape still differs: live runs are first pinned in the pocket
   at 1936,1349 after about 5 steps, the model's knight further north at 1937,1342 after about 8. The difference starts
   before any retreat: live, the cyclopses move off their summon tiles before the knight acts; the model starts them
   frozen there, so its opening is the same every clear.
2. **The policy designed in the simulator does not win live.** Stepping back when two cyclops reach the knight saved
   about 4 potions per clear in the first simulator; with monsters surrounding the knight as they do live, the saving
   shrinks to about 1 potion (5%), and live it uses 1.4 more than the plain rules (t 1.8, not significant).
   The earlier live win came from runs with vBot healing alongside.
3. **Our rules policy is level with vBot.** With enough runs (PR-9, 50 each, pre-registered) the
   Spiral rules policy drinks 12.5 potions per cyclops clear against vBot's 14.7 (difference -2.2, t -3.8), but the
   whole difference sits in the first 10 s: Canary ends a fresh login's protection when the player moves, turns, talks
   or uses an item, which vBot does and our probe does not, so vBot takes 9.1 hits in that window against our 1.6. After
   it the two take the same hits (60.1 vs 60.4). Re-tested with the protection ended for both (PR-11, 50 each): 14.4 vs
   14.8 potions, no difference shown (t -0.6), identical hits (69.1 vs 69.2). Our three policies drink alike live (rules
   12.5, ReachFirst 12.3, retreat 12.2). Against nExBot the retreat policy was narrowly better (12.2 vs 14.6 potions,
   PR-3a, t -2.14), but about half of that is the same login rule (nExBot talks right after login). The fair re-test
   (PR-12, 40 each, protection ended and both starting 2.5 s after login) shows no difference: 12.75 vs 13.93 potions,
   difference -1.18 (interval -2.42 .. 0.07, t -1.88). nExBot runs only with three arena shims (BENCHMARK.md PR-3a).
4. **Learning wins little at this level of detail.** In every scenario tried (open field, corridor, room,
   arena spot, mixed cyclops and trolls, potion budgets, respawning hunts) tuned threshold rules match or beat neural
   and scored learned policies. On a respawning hunting ground the rule that sweeps to the next spawn due beats every fixed
   route at a 60 s respawn, the evolved one included, but not at 30 s. With more
   monsters than the knight can fight at once, the tuned sweeping cavebot leads and the retreat rules trade experience
   for cost, and two knights coordinate best by simply following one shared rule together. The duo model behind
   that finding now matches live hunts: Canary's target order plus the ally's measured login delay predicted
   16.73 kills and 6.68 potions per hunt, and 9 live duo hunts gave 16.78 and 6.89 (PR-28, 2026-10-25). The rerun
   sweep on that model keeps the finding: rules evolved for the duo earned 63% less held-out profit than the
   validated shared cavebot (P12, 2026-10-27). The one open gap is the split of potions between the knights (the
   ally drinks 52% live against 27% predicted).

## Fidelity

Every mechanic comes from Canary's source or a live measurement, and the model is checked against both:

| Mechanic | Model | Live |
| --- | --- | --- |
| Knight's hits on trolls (kill hits capped at remaining health) | 9.37 per landed hit | 9.35 |
| Cyclops hits on the knight (truncated normal, then shield and armor blocks; one block charge per second, two at most) | 34.97 per landed hit, max 86 | 33.6, max 86 (forge off, full gear); 2026-10-20, 5204 landed hits from PR-12: the shape fits the model's charged-hit distribution (chi-square 17.1 on 17 df), with about 94.5% of landed hits meeting a block charge (interval 90.7-97.4%) against about 82% in the model's crowded fights |
| Hunter arrows on the knight (0-100, past the shield, armor blocks) | 40.57 per landed hit | 39.58, max 87 over 518 landed hits from the hunter runs; chi-square 4.9 on 10 df, every landed hunter hit an arrow; arrows meeting the shield would give 32.74 and are rejected (`hunter_fit.py`) |
| Knight's hits on trolls (level 30, hunting ground) | 24.89 per non-lethal landed hit (whole fights simulated, killing blows left out as live) | 24.02 over 107 such hits from PR-15; chi-square 11.4 on 7 df (`troll_censored_fit.py`) |
| Knight's hits on cyclops (balanced, level 30, axe 60) | 23.10 per landed hit, max 66 | 22.52, max 64 over 2427 landed hits (killing blows excluded); chi-square 13.1 on 15 df (`knight_fit.py`) |
| Knight step | 650 ms | client-issued retreat steps 700-725 ms on arena ground, bounded by policy decisions; PC-4 (2026-10-20): a level-30 knight stepping again as soon as it can takes 558 ms per straight step (client speed 139), Canary's formula 486 ms plus the client's poll and walk lag, so the server steps it at its level's speed and the model's 650 (702 on arena ground) is too slow for server-side follow; open, see TIBIA-COMBAT-FIDELITY |
| Cyclops straight step, chasing or not | base step | 701-715 ms |
| Diagonal step | 3x straight | 3.0x (2109 vs 710 ms) |
| Ground speed | per tile from the server map at the arena spot and on the hunting ground (arena ground 160, 8% slower than grass; road 100; a step costs the speed of the tile it starts from; the spot priced every tile as arena ground until 2026-10-20) | cyclops steps at the spot; PC-1: about 705 ms from arena ground and 455 ms from road (model 702 and 438); PC-2, pre-registered after the change: 452 ms per road step over 24 steps |
| Arena terrain | the server map (canary.otbm with appearances.dat), radius 45 around the spot (radius 30 until 2026-10-20, which walled off the eastward road that long hunter chases take) | agrees with the live client scan on 251 of 252 cells |
| Respawn | `respawning_like_canary`: a killed monster returns after its spawn's cleanup check (30 s), its spawntime and a 4.2 s teleport effect, 94.2 s for spawntime 60 (`canary_respawn_ms`); the hunting-ground studies below use a plain 60 s | Canary `SpawnMonster::checkSpawnMonster` and `scheduleSpawn`; cyclops and trolls are non-blockable, so a player in view does not hold a spawn back. PR-15 (2026-10-20, ten 300 s hunts on the hunting ground with these spawns): 12.80 kills per hunt live against 12.38 predicted (t 0.71), 4.70 cyclops against about 4.7; potions over-counted (14.95 against 12.70, t -4.35), as on every protection-free arena. PR-23 (2026-10-22, ten fresh hunts against the adopted bundle's 14.34 potions and 13.19 kills): 14.8 potions (t 0.62) and 14.2 kills (t 1.89), so PR-15's potion gap was sampling noise |
| Protection zones and teleports | tiles flagged protection zone in the map (two buildings east of the spot, 420 tiles within radius 45) block walking for every creature but not arrows; teleport tiles are walls like floor changes; the retreat policy never steps into a zone (since 2026-10-20) | Canary `Tile::queryAdd`: monsters may not enter a zone, a teleport or a floor change, and a player in a zone may not attack; live, 4 of 5 retreat clears that ended with no kill stood in the east zone with the cyclopes outside |
| Client actions | one per 250 ms (a typed readiness witness) | the same gate wraps every competitor |
| Turn order | death checked before the knight acts | a knight killed by a hit cannot drink in the same tick |
| Tile occupancy | no two creatures share a tile; steps go around taken tiles | as in Canary |
| Pathing | arena spot: occupancy-aware routing with Canary's step weights (straight 10, diagonal 25, other creatures as obstacles), so monsters detour around each other; hunting ground: shortest path with straight steps only | Canary's A* (diagonal 25 vs straight 10); checked live (PC-1): a cyclops behind a wall takes exactly the router's straight-step path in all 5 runs, after idling 10-12 s |
| Ranged follow pace | a ranged creature beyond its target distance steps only on its creature think (one step per second at most); within it, it keeps its distance at full pace | hunters 5-6 tiles from the knight: 0.83-0.93 tiles/s live, 0.91-1.00 in the model (1.15-1.19 before this rule); calibrated on the 2026-10-19 diagnostic block, server-side cause not yet traced |
| Hunter clear rate | 77 of 100 clears predicted with the bundle adopted on 2026-10-22 (all4 plus retreat pacing; 76 since F34, the Canary flee threshold, joined it the same day), which PR-18 (14 of 20) and PR-19 (15 of 20) hold; the overnight bundle before it predicted 99 of 100, above the band of 16 of 25. The knight acting on the last tick's view alone causes the jump (59 of 100 without it); in lab, any knight aim or action that runs before the hunters' move in the same tick pre-empts their flee step, so a whole-turn reorder cannot serve both the retreat race and the hunters; that needs sub-tick event order. Earlier steps: 45 of 100 before the knight stepped at Canary's speed, 30 with that speed, 51 with the dance step, 87 of 100 with the 10 s wake the earlier predictions wrongly kept | 16 of 25 live (PR-13, diagnostic block, PR-14). Uncleared runs: the knight chases a distance-keeping hunter east along the road at about 2 tiles/s, its companions fall out of view, and after the kill it stands with nothing in sight. The model's knight approaches at 1.2-1.3 tiles/s; making it faster makes it catch its target sooner instead (BENCHMARK, PR-14 post-hoc diagnosis). Protection zones are ruled out: with them the model still predicts 87 of 100 (PC-5). Correction 2026-10-20 night: those predictions froze the hunters for the 10 s login wake, which the parity layer had removed; scoped to the arena as it ran (`mirroring_the_current_arena`) the model predicted 45 of 100, inside the band of 16 of 25. With the knight at Canary's step speed (2026-10-21) it drops to 30 (not yet traced; a guess is that a faster knight chases one hunter further from the others), so that match was partly two errors cancelling. Canary's dance step, adopted the same night for the retreat gap, brings it to 51; the last-tick view adopted after it overshoots to 99, so the hunter gap is open again, from above. Out of sample (PR-18, 2026-10-21, 20 runs): 14 of 20 clear, so the bundle's 99 of 100 fails, while the candidate all3 (three Canary timing facts that are off by default: the probe's request lands at a random poll phase plus 8 ms, a monster's first chase path waits for its next think after it acquires the knight, and the knight's follow walk from a stop waits a full step) predicted 77 of 100 and holds. all3 also held PR-17's arms, and rule D17 adopts it into the bundle on 2026-10-22. PR-18's damage gap (4.75 potions per run against all3's 2.21) was the arrows' sight line, not the within-tick order (next row): PR-19 (20 fresh runs) gave 15 of 20 clears and 3.25 potions per run against all4's 77 of 100 and 3.79, and all4 replaces all3 on 2026-10-22 (rule D18). Still open: clear time, 60.5 s live (PR-19) against 55.9 |
| Monster wake | monsters neither move nor strike for the first 10 s of a live-mirroring scenario (`waking_at (live_wake_ms ())`); Canary's login protection (`isLoginProtected` blocks monster targeting) | the path check saw cyclops idle 10-12 s after the knight logs in; live, the standing knight takes 1.8 hits in its first 10 s against 7.9 simulated without the delay |
| Monster sight | a monster follows only a knight within 11 tiles on both axes on its floor; otherwise it idles | Canary's viewport (8 + 3, 6 + 5) |
| Arrow sight lines (in the bundle since 2026-10-22, `sighting_like_canary`) | a hunter's arrow needs a sight line that only projectile blockers stop (`terrain.sight_blocks`, from the generated `arena_sight_bits`); without the option, every unpassable tile stops it | Canary `Map::checkSightLine` stops only at `CONST_PROP_BLOCKPROJECTILE`, set by the appearance flag `unsight` or items.xml `blockProjectile`. PR-18 live: 0.25 hits per in-range hunter-second, the full datapack rate (an arrow every 2 s at 50%); the model's hunters were in range as often (1.66 vs 1.87 per second) but had a clear line for only 1.10. With the option, 21.03 hits per run against 23.85 live (without: 14.88), found on PR-18 data. Out of sample (PR-19, 2026-10-21, 20 runs): 20.45 hits per run, t -0.40, while all3 alone rejects (t 3.86); joins the bundle on 2026-10-22 (rule D18) |
| Retreat pacing (in the bundle since 2026-10-22, `pacing_retreats_like_the_live_probe`) | a retreat step waits the longer of Canary's step time and the competitor's own 650 ms (x3 diagonal), `retreat_step_ms_at` | The live competitor paces its own retreat steps (`apps/arena/competitor.spi`, `step_ms` 650), above Canary's 500 ms (arena ground) and 300 ms (road) for a level-30 knight. In sample: steps per clear 15.1 -> 11.7 (80 live logs 11.3), retreat potions 13.11 -> 13.32. Out of sample (PR-20, 20 runs): 10.1 steps (t -0.54), 12.80 potions (t -0.65); joins the bundle on 2026-10-22 (rule D19) |
| Chase pacing (off by default, `chasing_at_the_live_probe_pace`, 2026-10-22) | a knight chase step waits the longer of Canary's step time and 558 ms, the live probe's measured straight step (PC-4 median), `chase_step_ms_at` | Live, the knight chases through the client's attack-and-chase and moves slower than the formula. In sample (100 held-out runs, rule D29): the hunter score falls inside every band (in-reach 33.7%, 74 of 100 clears, 23.66 hits; cyclops arms and hunting-ground kills unchanged), where the bundle alone gives 77 and 21.03. Long first chases move from 20% to 31% (live 52%), all still east. Out of sample (PR-21, 2026-10-22, 20 runs): hits 23.8, t 0.09, but 19 of 20 clears, outside the 11..18 band, so it stays off (rule D29). PR-22 (2026-10-22, 20 fresh runs) cleared 14 of 20, so PR-21's clear rate was an outlier, and the hunter target stays PR-18/19's 0.725 |
| Monster idle walk | `wandering_while_idle`: until it targets the knight, a monster takes a random free cardinal step once 1000 ms have passed since its last move | Canary `Monster::doRandomStep`; PC-1 saw cyclops wander 0-7 steps during the 10 s login protection |
| Monster swing period | `meleeing_every (live_creature_strike_ms ())`: 2166 ms between swings of an adjacent cyclops | single-cyclops live runs: 28 of 30 gaps between landed hits are one swing, mean 2166 ms (Canary's 100 ms creature check runs a few ms late per cycle) |
| Knight swing after a step | `swinging_like_canary`: every knight step, retreats included (since 2026-10-20; before, only approach steps), cancels the pending swing; it resumes at the next think, about every 1083 ms like the creature checks (`live_think_period_ms`), or the next knight or target move once due | Canary `Player::onWalk`, `hasExtraSwing`; PC-3: 31 of 36 swing gaps spanning a step come late, mostly by 150-200 ms. PC-6, pre-registered on the 40 PR-12 retreat logs: 9 of 232 step-spanning gaps on the 2 s grid (model 2%, 70.5% before the fix), 935 of 940 without a step |
| Monster first swing | `meleeing_every_once_targeted`: a cyclops's first swing waits one swing period after it can target the knight | Canary: a monster's `attackTicks` starts at 0 when it acquires a target; live, the first hit lands about 3.4 s after login, simulated before at 0.2 s. Scored best against the six live potion means (sum of squared t 13.5 vs 16.7, none beyond 2) |

Live-mirroring model (2026-10-15, first swing folded in 2026-10-18): `mirroring_the_live_arena` turns on the five rules above that only matter live (wake,
idle walk, swing period, first swing after targeting, swing after a step), and `live_retreat_tactic` steps exactly like the live probe. Before it, every
seed replayed one geometry (fixed spawns, monsters frozen while the knight is protected), and the simulated knight escaped
along the corridor that the live knight rarely reaches; live, the retreating knight sits cornered in the dead-end pocket at
1936,1349 for 43% of the clear. Healing was never the gap: potions per 1000 hp of damage are about 5.8 live and simulated.
Against pooled live means (in-sample, these data shaped the rules): 3 cyclops rules 12.30 vs 12.22 potions, ReachFirst 12.47 vs 12.30, retreat 11.76 vs
12.62; 2 cyclops rules 4.72 vs 4.85, retreat 4.91 vs 5.45 (with the 2026-10-20 swing fixes; before them 12.51, 13.22, 11.46, 4.65 and 4.59). Scored against the six live means with their standard errors, the sum of squared t fell from 17.5 to 8.8 with the fixes, none beyond 2 (before: both retreat means). Folding in the first swing moved the simulated clear times by at most 0.6 s. The 3-cyclops ranking of retreat vs
rules is still off by about 0.9 potions (model: retreat 0.54 better; live: 0.40 worse), the crowding at the pocket (BENCHMARK, PR-12 post-hoc). Under this model a lower heal threshold or a better standing tile saves
at most 0.3 potions per clear, so no live-runnable change to the rules policy is predicted to show live.
The 10 s wake and the idle walk describe the arena before 2026-10-15 14:17, when our probe kept the login protection. Since then the parity layer ends the protection for every competitor at login, so the matching scenario is `mirroring_the_live_arena |> waking_at 0` (no wake, so no idle walk); its first prediction (rules 15.6 potions, 72 hits) ran about 5% high (PR-11: 14.4, 69). Since 2026-10-20 that scenario has its own bundle, `mirroring_the_current_arena`: on top of it, monsters re-path only on their think (Canary `Creature::onThink`, `following_on_think`) and swing only on their attack rounds, losing a round spent out of reach (`Monster::canUseSpell`, `meleeing_on_canary_rounds`). Chosen overnight by a rule written before measuring, it cut the misfit over PR-11, PR-12 and PR-15 from a sum of squared t of 36.9 to 12.6 (rules 14.63 vs 14.42 live). On 40 fresh runs (PR-16, 2026-10-21) it holds for the rules policy (14.35 live vs 14.63, t -0.43) but not for the retreat policy (12.45 live vs 13.74, t -2.39): the model's retreat steps more and strikes less than the live one (94.7 s vs 87.4 s per clear), the same bias it showed in sample. The cause was the knight's fixed 650 ms step; Canary steps a level-30 knight in 500 ms on arena ground, and the bundle now adds `paced_like_canary` (the knight steps by `creatures.player_step_ms`), which brings the retreat to 12.53 (in sample, rules unchanged) and hunting-ground kills to 12.73 per hunt (live 12.80). It also adds Canary's dance step (`dancing_like_canary`: an adjacent monster with no path step sidesteps 10% of its thinks, `staticAttackChance` 90), which moves retreat to 12.87 (the hunter clear rate went back inside its band at that step, before the last-tick view pushed it to 99 of 100). Two more server-and-client facts close the retreat step gap (20.6 steps per clear down to 12.4, live 11.7): monsters and the knight step by Canary's formula on the map's own ground speed (`stepping_by_canary_formula`; the scaled grass step had turned a cyclops's 700 ms into 800 on the 100 ms tick), and the knight acts on what the client saw a tick earlier (`seeing_a_tick_late`), so a cyclops can take the last free tile beside it first. All of this was fitted in sample overnight under rules written before each measurement (BENCHMARK, PR-16 rows), and it holds on fresh clears: PR-17 (2026-10-21, 40 runs) gave rules 13.90 against 14.55 (t -0.87) and retreat 13.25 against 12.81 (t 0.74).

The multi-creature simulator is bit-exact on WGSL too, checked since 2026-10-20 when Cells began honoring a WGSL test's status (before, every GPU test passed whatever it returned; all 28 GPU twins pass under the fix) (`gpu_sim.spi`: a full troll hunt, five arena-spot cyclops
clears, and a five-minute hunting-ground hunt with the shortest-path router and its scratch arrays). With parallel lanes (one seed per GPU thread, 2026-10-14) every lane matches C exactly; a launch costs about 4 s of fixed setup, then about 0.23 ms per arena clear against 1.6 ms on one C core, so the GPU pays off from about 4000 clears per launch. Large lane counts now run in chunks of 1024 (the 16384-lane hang, WGSL-LANES-LARGE-DISPATCH-HANG, is fixed in the pack-1e compiler).

## Simulator results

Protocol: everything is tuned on training seeds and judged on held-out seeds; the seed blocks are typed, so tuning on
held-out seeds does not compile. Claims are Pareto dominance on (kills, profit) or a cost within a stated time cap.
Profit books gold looted, 50 gp per potion and 14000 gp per death. The control is a random policy (each decision tick it drinks, engages, steps to a random tile or stands, with equal odds; once engaged the server keeps swinging, as live): on held-out seeds it earns 54310 experience on the hunting ground at -1.15 million gp, and clears the arena spot in 94 s with 72 potions per clear (one potion per second at most, as the server allows), far below every rule.

- **Targeting** (three-troll pack, 20 seeds): finishing the current target first gets 330 kills; fighting whatever is in
  reach gets 75 kills and 381 escapes. The live client switched to that order and killed all three trolls, where the old
  order killed one. A chasing policy gets 356 kills against 34 for a standing one (`hunt_sim.spi`).
- **Cyclops pack, open field** (100 training and 100 held-out seeds): healing below 130 dies; 170 and above tie at 950
  kills. Only the network warm-started from the cavebot tuned to heal below 160 dominates it, by 1550 gp at the same 955
  kills. Kiting now walks the knight out of the cyclops' sight (monsters see 11 tiles), so they stop following and it
  kills only 300.
- **Terrain is the lever.** In a one-tile corridor the same cavebot clears three cyclops with 6.5 potions and no
  deaths, against 15.3 potions and 3 deaths in 20 clears in the open field. In a room with a corridor, rules evolved
  on 100 training seeds (ReachFirst, heal below 223 + 3 per attacker, step back at three attackers) dominate the fully
  tuned cavebot on 100 held-out seeds: 946 kills and -288217 gp against 942 and -477181.
- **Arena spot** (the server map, radius 45, monsters routing around each other): rules evolved for the cheapest clear
  within the tuned cavebot's time +15% choose ReachFirst targeting, heal below 88 + 26 per attacker and stepping back as
  soon as one monster reaches the knight. On 100 held-out clears they use 1070 potions against the tuned cavebot's 1702
  (heal below 90), with one death against none, at 95.6 against 90.1 s per clear: cheaper, slower, not dominant.
  Before road speed applied at the spot (radius 30) the same search chose 96 + 8 per attacker for 1069 potions, no deaths, at 90.9 s.
- **Mixed camp** (one cyclops, two trolls, arena spot): the cavebot tuned on this camp (heal below 80) uses 85 potions
  in 100 held-out clears at 37.7 s. Rules evolved on this camp without knowing kinds use 74 potions at 37.6 s with no
  deaths, dominating it; kind-aware rules use 68 but die once. Rules evolved for three cyclops use 190 potions; counting
  only attackers that stand and fight (`policy.temperate`: trolls flee, cyclops do not) cuts them to 135.
- **Hunting ground** (two cyclops and four trolls respawning every 60 s, the server map around the arena, five-minute
  hunts, 100 held-out seeds): greedy one-tile steps stick behind walls there, so knight and monsters route with a
  shortest-path search (straight steps only: a diagonal costs three straight ones, and Canary's A* agrees), and every
  step costs what the server's ground under it says (roads, speed 100, are 1.6 times faster than the arena ground,
  speed 160; measured live in PC-1, confirmed by the pre-registered PC-2). With the cavebot's heal tuned on training seeds (120), standing at the start earns
  104920 experience; a hand-drawn route 108270, a loop by the spawns 114470, a route evolved on training seeds with roads
  (a two-point shuttle between 121,86 and 117,102) 119280, and sweeping to the nearest live or next-due spawn 119950
  (with the protection zones of the east buildings walled off since 2026-10-20). The rule that reads respawn
  timers leads at this 60 s respawn and ties at 120 s, but at 30 s the fixed routes beat it (hand route 133170, shuttle
  133200, sweeper 126980): which walker is best depends on the respawn time.
- **Six cyclops on the hunting ground** (more than the knight can fight at once; 100 held-out hunts, each cavebot's heal
  tuned on training seeds): standing (heal below 100) earns 112700 with 2 deaths at -211081 gp; sweeping the spawns (heal below 130) earns the most,
  126900, with 3 deaths at -296687 gp. Stepping back at two attackers while sweeping (the live retreat rules) earns 121050 at -166786 with
  no deaths: about 5% less experience for 44% lower cost, a choice of objective rather than a better policy.
- **Two knights on the six-cyclops ground** (100 held-out hunts, party experience): the second knight acts through the
  same code (the simulator swaps which knight is acting), and monsters chase and strike the nearer one. Both knights
  sweeping together earn 259350 at -180187 gp; splitting the ground into two territories earns less (248550) at 30%
  more cost (-233638), because each knight then faces the cyclops alone. Rules evolved for the duo (heal below 117 + 6
  per attacker, never retreat) reach 261750 at -180890: within 1%, so one shared rule already captures the
  coordination.
- **Learned policies:** a 12-gene scored policy (heal, retreat, targeting weights, step weights) whose start genome
  reproduces the evolved rules found nothing better in 640 evaluations. With a 6-potion budget it clears 5.6% faster at
  the same deaths and potions, below the 5% cost bar. A respawning hunt with a potion budget does not separate policies
  either: above about 40 potions the budget never binds; below it the only decision that matters is when to leave,
  which a one-number rule captures.

## Live arena

PR-4 (2026-10-14, fixed arena): cyclops clear, BENCHMARK pack v1, full gear restored before every run, the same 250 ms
action gate and 100 ms decision tick for every competitor, heal below 160, 30 runs each, alternating, every run cleared,
no deaths, no arena failures. These runs predate the login-protection fix: vBot ended its protection at login and our probes did not, so the vBot row carries about 7 extra hits per clear (BENCHMARK.md PR-9 addendum; level on the fixed arena, PR-11).

| Competitor | Potions | Clear time | Damage taken |
| --- | --- | --- | --- |
| Spiral rules | 11.5 (sd 2.5) | 87.6 s | 2029 |
| Spiral retreat (designed in the simulator) | 12.9 (sd 3.2) | 91.3 s | 2217 |
| vBot 4.8 | 14.0 (sd 2.6) | 92.7 s | 2397 |

Pre-registered tests: retreat vs vBot, no difference shown (t -1.45); retreat vs rules, no difference shown (t 1.82).
Rules vs vBot, pre-registered as a fresh replication (PR-8, 30 runs each): 12.9 vs 14.2 potions, no difference shown (t -1.47); PR-4's 11.5 for the rules did not replicate. Rules vs vBot with 50 runs each (PR-9, 2026-10-15): 12.5 vs 14.7 potions, significant (t -3.80), clear time 88.7 vs 87.9 s, damage taken 2145 vs 2479; the whole difference comes from vBot ending its login protection in the first 10 s (BENCHMARK.md PR-9 addendum). With the protection ended for both (PR-11, 50 runs each): 14.4 vs 14.8 potions, no difference shown (t -0.58). Retreat vs nExBot 4.0.4 (PR-3a, 20 runs each, 2026-10-15): 12.2 vs 14.6 potions, significant (t -2.14), clear time 90.9 vs 88.4 s, damage taken 2030 vs 2421 (16 and 18 of 20 logs matched), no deaths. With the protection ended for both and synchronized starts (PR-12, 40 runs each, 2026-10-18 and 2026-10-20): 12.75 vs 13.93 potions, no difference shown (t -1.88), clear time 90.3 vs 89.2 s, damage taken 2230 vs 2369, no deaths; one retreat run ended without a clear, standing in the protection zone east of the spot (the retreat now skips zone tiles). The random control (PR-5, 10 runs: drink, engage, random step or stand with equal odds) clears in 102.7 s with 94.1 potions, far below every competitor.

The earlier table, kept as a record of the faulty arena:
Measured with vBot's HealBot and TargetBot running alongside every `spiral-*` competitor (see the correction above); kept as a record until PR-4 replaces it. Cyclops clear, BENCHMARK pack v1: full gear restored before every run, the same 250 ms action gate and 100 ms decision
tick for every competitor, heal below 160 unless stated, no deaths in any round below.

| Comparison | Runs | Potions | Result |
| --- | --- | --- | --- |
| Spiral rules vs vBot | 6 / 6 | 14.7 vs 14.8 | tie |
| Spiral rules vs vBot, heal below 120 | 10 / 10 | 12.8 vs 13.2 | tie (t below 1) |
| Retreat vs Spiral rules | 23-24 each | 12.6 vs 15.5 | **retreat wins**: t -3.89; damage 2125 vs 2639, t -4.20; same clear time |
| Retreat with ReachFirst vs CurrentFirst targeting | 18 / 18 | 12.7 vs 13.4 | no difference (every t below 0.8) |
| Retreat vs vBot, pooled over three rounds | 47 / 42 | 12.6 vs 13.7 | level or slightly better: t -1.89; same clear time (90.7 vs 92.0 s) |

The first retreat-vs-vBot round alone looked significant (t -2.14); later rounds regressed toward a tie, which is why
comparisons are now pre-registered with a fixed run count.

Rounds before these measured arena faults rather than policies (and these rounds themselves carry the last one found, vBot left enabled during our runs): the forge inflating every monster, gear dropped on
deaths and never restored, vBot's HealBot ignoring a closed backpack, our probe deciding every 250 ms, the probe
leaving chase mode on during retreats, and the vBot probe sampling only every 10 s, which rounded vBot's clear times up
by about 5 s.

The probes are in `apps/arena/` and the arena scripts in `live/`; the live world they drive (Canary 3.6.1, OTClient Redemption 4.1, run
off-screen and muted) stays in a local folder outside the repo (see Running).

## Repository

| Path | Contents |
| --- | --- |
| `src/` | The Spiral package (`package.spiproj` and its modules): rules, typed domain, simulators and their test blocks |
| `docs/` | The plan, the benchmark with every pre-registration and its result (the one record of each experiment), the modeling notes and prior art |
| `apps/arena/` | Every OTClient probe, written in Spiral and compiled with the Lua backend. Layers: generic Lua-side state (`lua.spi`), typed client bindings (`client.spi`), the shared probe lifecycle (`probe.spi`), shared run modules (`scoreboard`, `observer`, `adjacency`), and one entry per probe: competitor, random, vbot, nexbot, summon, scan, path, measure, steps. `build.ps1` writes `target/arena/<probe>.lua`; `-ProbeBody <probe>` picks one and rebuilds stale outputs |
| `apps/map/` | The server-map tool (Rust backend): reads Canary's map, writes the generated terrain definitions and the region dump in `results/` |
| `apps/predict/` | One C entry that prints the model's prediction tables for the current bundle (cyclops clears per policy, hunter clears, hunting-ground hunts) |
| `live/` | The live arena harness: the parity layer, bot shims and configs, the run and check scripts, scenario assets, and the block runner |
| `analysis/` | Log analyses of concluded pre-registrations that eoie can't express yet; each is deleted when its eoie verb installs. A new pre-registration's method is the eoie command in its BENCHMARK test row, never a new script |
| `results/` | Live run tables that BENCHMARK.md cites, the live map scan and the map tool's region dump |
| `scripts/` | `init.ps1`, `build.ps1`, `publish.ps1`, `workflow.ps1` as in the sibling repos, plus `predict.ps1` (builds and runs `apps/predict` with optional candidate builders) and `score.ps1` (scores candidates under rule D16) |
| `.github/workflows/gh-pages.yml` | CI on Ubuntu and Windows: every test file through Spiral's cells runner, then the published tree |

## Running

- Set up: `pwsh scripts/init.ps1` clones polyglot (which brings spiral) next to this repo, links both under `deps/`,
  installs Mesa's software Vulkan on Ubuntu, and builds the WGSL runner into `target/`. `-fast 1` only links and
  builds what is missing.
- Test: `pwsh scripts/build.ps1` runs every `src/*.spi` file with tests through `deps/spiral/apps/cells/spi/run_notebook.ps1`
  and fails unless every test executed and passed (no failed, unsupported, skipped or missing rows); `-Files geometry,views`
  runs a subset. Notebook outputs go to `notebooks/` (ignored by git, published by `scripts/publish.ps1`).
- Standards: `scripts/build.ps1` first runs `SpiralCompiler format src apps/arena apps/map --check` and stops on any layout
  change; locally, `eoie standards src apps/arena apps/map` also checks the rules `src/standards.spi` declares (no
  comment lines, LF only, a target above every test, 120 columns, no floating point in 26 integer-only modules).
- Live arena: the arena needs a local world outside the repo: Canary, MariaDB, OTClient, logs (default
  `~/tibia-local`, or `TIBIA_WORLD`; MariaDB binaries from `TIBIA_MARIADB_BIN`, default scoop's). For example
  `pwsh live/run-arena.ps1 -Runs 1 -Monster cyclops -MonsterCount 3 -Level 30 -AxeSkill 60 -HealBelow 160
  -StrikeAbove 0 -FullExperience 675 -Competitors spiral-policy,vbot -Out results/arena-results-try.tsv`. The hunting
  ground swaps in its own spawns and runs for a fixed time: `-Scenario hunting-ground -SpawnFile
  live/hunting-ground-spawns.xml -KnightAt 1936,1336 -RunMs 300000 -MonsterCount 0 -FullExperience 1000000`. nExBot is not
  part of the repo (no license); `-Competitors nexbot` expects it under the world's `bots/`.
- Pre-registered blocks: `pwsh live/block.ps1 -Ledger <ids>` runs the block, then computes each test with
  `eoie experiment analyze` against `target/ledger`, eoie's working copy (git-ignored). The record is the BENCHMARK
  section: register its test there with `eoie experiment register target/ledger ...` right after writing it.

## Documents

- [BENCHMARK.md](docs/BENCHMARK.md): the OT Agent Arena (fidelity, baselines, scenarios, metrics, pre-registrations, publication).

## Ground rules

- One novelty at a time, each with its own benchmark: fidelity before training, training before scale.
- CPU and GPU runs of the same seed must agree bit for bit (integer simulation, counter-based RNG).
- Every claim names its baseline, its control (random policy) and its budget; nothing is promoted on rhetoric.
- CipSoft-derived data (map, sprites, items) stays local; the arena publishes code, scenario specs and seeds.
- Each test target has a reason: `///> c` is the semantic oracle on every rules test, `///> wgsl` the GPU simulator,
  `///> lua` the live client, and `///> rust` only the simulators' golden seeds, because a Rust compile costs about 10 s
  per test (662 s of a 1,164 s suite, 2026-10-13). A module's `static` test only type-checks.
- Tibia dogfoods the tooling: a missing workflow feature goes into Cells, the compiler or eoie as a backlog item before
  anything works around it, never imitated in Tibia code.
- Every backlog item names the claim or milestone it serves; one that serves none is dropped, not done.
