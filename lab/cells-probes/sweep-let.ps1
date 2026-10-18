param(
    [string[]] $Functions = @('advance', 'aimed_by', 'auto_attack', 'creature_hits_hunter', 'foe_acts', 'foe_turn', 'foes_act', 'hunter_steps', 'knight_turn', 'patrol_step', 'player_acts', 'player_approaches', 'player_heals', 'player_retreats', 'player_strikes', 'random_acts', 'random_pick', 'recharged', 'respawn_player', 'ruled_acts', 'sweep_step', 'territory_step', 'wanders', 'slot_of_nearest_attacker', 'next_waypoint', 'turned'),
    [string] $Module = 'hunting_pack',
    [string] $Test = 'gpu_sim/a_full_troll_hunt_and_five_cyclops_clears_on_gpu'
)
foreach ($name in $Functions) {
    try {
        & (Join-Path $PSScriptRoot 'measure.ps1') -Label "let-$name" -CompileOnly -Tests $Test -Rewrite "$Module|`ninl $name |`nlet $name " | Select-String '^\d{4}-' | ForEach-Object Line
    } catch {
        "let-$name failed: $_"
    }
}
