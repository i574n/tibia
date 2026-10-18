import itertools
import math
import random
import statistics
import sys

MELEE_MAX = int(sys.argv[1]) if len(sys.argv) > 1 else 105
ARMOR = 3 + 8 + 5 + 1
SAMPLES = 400_000


def shielded_defense(skill, shield_defense=26):
    return (skill * 25 + 223) * shield_defense * 75 * 160 // 10_000_000


def truncated_normal_unit(rng):
    for attempt in range(8):
        total = sum(rng.randrange(4096) for _ in range(12))
        v = 2048 + int((total - 24576) / 4)
        if 0 <= v <= 4096:
            return v
        if attempt == 7:
            return 0 if v < 0 else 4096


def armor_block(rng, armor):
    if armor > 3:
        return rng.randint(armor // 2, armor - (armor % 2 + 1))
    return 1 if armor > 0 else 0


def blocked(rng, raw, defense, charged):
    after_defense = raw - rng.randint(defense // 2, defense) if charged else raw
    if after_defense <= 0:
        return 0
    after_armor = after_defense - armor_block(rng, ARMOR)
    return max(after_armor, 0)


def stats(skill, charged, seed=7):
    rng = random.Random(seed)
    defense = shielded_defense(skill)
    hits = []
    for _ in range(SAMPLES):
        raw = (truncated_normal_unit(rng) * MELEE_MAX + 2048) // 4096
        hits.append(blocked(rng, raw, defense, charged))
    landed = [h for h in hits if h > 0]
    return defense, len(landed) / len(hits), statistics.fmean(landed)


for skill, charged in itertools.product((11, 12), (True, False)):
    defense, landed_share, mean_landed = stats(skill, charged)
    print(f"shield {skill} defense {defense} charge {charged}: landed share {landed_share:.3f} mean per landed hit {mean_landed:.2f}")
