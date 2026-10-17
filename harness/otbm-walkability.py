import argparse
import re
import struct

AREA, TILE, ITEM, HOUSE_TILE = 4, 5, 6, 14
ATTR_TILE_FLAGS, ATTR_ITEM = 3, 9
NODE_START, NODE_END, ESCAPE = 0xFE, 0xFF, 0xFD


def varint(buf, i):
    value, shift = 0, 0
    while True:
        byte = buf[i]
        i += 1
        value |= (byte & 0x7F) << shift
        shift += 7
        if byte < 0x80:
            return value, i


def fields(buf):
    i = 0
    while i < len(buf):
        key, i = varint(buf, i)
        number, wire = key >> 3, key & 7
        if wire == 0:
            value, i = varint(buf, i)
            yield number, value
        elif wire == 2:
            length, i = varint(buf, i)
            yield number, buf[i:i + length]
            i += length
        elif wire == 5:
            yield number, buf[i:i + 4]
            i += 4
        elif wire == 1:
            yield number, buf[i:i + 8]
            i += 8
        else:
            raise ValueError(f"wire type {wire}")


def item_kinds(appearances_path):
    blocking, ground, speeds = set(), set(), {}
    data = open(appearances_path, "rb").read()
    for number, appearance in fields(data):
        if number != 1:
            continue
        identity, flags = None, None
        for inner, value in fields(appearance):
            if inner == 1:
                identity = value
            elif inner == 3:
                flags = value
        if identity is None or flags is None:
            continue
        for flag, value in fields(flags):
            if flag == 13 and value:
                blocking.add(identity)
            elif flag == 1:
                ground.add(identity)
                for bank_field, bank_value in fields(value):
                    if bank_field == 1:
                        speeds[identity] = bank_value
    return blocking, ground, speeds


def items_with_height(appearances_path):
    tall = set()
    data = open(appearances_path, "rb").read()
    for number, appearance in fields(data):
        if number != 1:
            continue
        identity, flags = None, None
        for inner, value in fields(appearance):
            if inner == 1:
                identity = value
            elif inner == 3:
                flags = value
        if identity is None or flags is None:
            continue
        if any(flag == 27 for flag, _ in fields(flags)):
            tall.add(identity)
    return tall


def tiles(otbm_path, floor, x_range, y_range):
    data = open(otbm_path, "rb").read()
    found = {}
    stack = []
    i, size = 4, len(data)
    while i < size:
        byte = data[i]
        if byte == NODE_START:
            stack.append({"type": data[i + 1], "props": bytearray(), "items": []})
            i += 2
        elif byte == NODE_END:
            node = stack.pop()
            i += 1
            if node["type"] == ITEM and len(node["props"]) >= 2:
                identity = struct.unpack_from("<H", node["props"], 0)[0]
                for ancestor in reversed(stack):
                    if ancestor["type"] in (TILE, HOUSE_TILE):
                        ancestor["items"].append(identity)
                        break
            elif node["type"] in (TILE, HOUSE_TILE) and stack and stack[-1]["type"] == AREA:
                area = stack[-1]["props"]
                base_x, base_y, base_z = struct.unpack_from("<HHB", area, 0)
                props = node["props"]
                x, y = base_x + props[0], base_y + props[1]
                if base_z != floor or not (x_range[0] <= x <= x_range[1] and y_range[0] <= y <= y_range[1]):
                    continue
                offset = 2 + (4 if node["type"] == HOUSE_TILE else 0)
                items = list(node["items"])
                while offset < len(props):
                    attribute = props[offset]
                    if attribute == ATTR_TILE_FLAGS:
                        offset += 5
                    elif attribute == ATTR_ITEM:
                        items.insert(0, struct.unpack_from("<H", props, offset + 1)[0])
                        offset += 3
                    else:
                        break
                found[(x, y)] = items
        elif byte == ESCAPE:
            stack[-1]["props"].append(data[i + 1])
            i += 2
        else:
            if stack:
                stack[-1]["props"].append(byte)
            i += 1
    return found


def walkable(items, blocking, ground):
    return any(item in ground for item in items) and not any(item in blocking for item in items)


def scan_cells(scan_path, marker):
    lines = open(scan_path, encoding="utf-8").read().splitlines()
    start = next(index for index, line in enumerate(lines) if marker in line)
    center = re.search(r"scan around (\d+),(\d+),(\d+)", lines[start + 1])
    cx, cy = int(center.group(1)), int(center.group(2))
    cells = {}
    for line in lines[start + 2:start + 27]:
        match = re.match(r"\s*([+-]?\d+) (\S+)$", line)
        if not match:
            continue
        dy = int(match.group(1))
        for column, mark in enumerate(match.group(2)):
            if mark != "?":
                cells[(cx - 12 + column, cy + dy)] = mark != "#"
    return cells


def floor_change_ids(items_xml_path):
    import re
    text = open(items_xml_path, encoding="utf-8", errors="replace").read()
    ids = set()
    for block in re.finditer(r"<item\b([^>]*?)(?<!/)>(.*?)</item>", text, re.S):
        head, body = block.group(1), block.group(2)
        if 'key="floorchange"' not in body:
            continue
        single = re.search(r'\bid="(\d+)"', head)
        low = re.search(r'\bfromid="(\d+)"', head)
        high = re.search(r'\btoid="(\d+)"', head)
        if single:
            ids.add(int(single.group(1)))
        elif low and high:
            ids.update(range(int(low.group(1)), int(high.group(1)) + 1))
    return ids


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--otbm", required=True)
    parser.add_argument("--appearances", required=True)
    parser.add_argument("--x", type=int, default=1932)
    parser.add_argument("--y", type=int, default=1349)
    parser.add_argument("--z", type=int, default=7)
    parser.add_argument("--radius", type=int, default=30)
    parser.add_argument("--check", default="")
    parser.add_argument("--out", default="")
    parser.add_argument("--masks", default="")
    parser.add_argument("--speeds", default="")
    parser.add_argument("--items-xml", default="")
    parser.add_argument("--floor-changes", default="")
    options = parser.parse_args()
    blocking, ground, speeds = item_kinds(options.appearances)
    x_range = (options.x - options.radius, options.x + options.radius)
    y_range = (options.y - options.radius, options.y + options.radius)
    found = tiles(options.otbm, options.z, x_range, y_range)
    rows = []
    for y in range(y_range[0], y_range[1] + 1):
        row = "".join("." if walkable(found.get((x, y), []), blocking, ground) else "#" for x in range(x_range[0], x_range[1] + 1))
        rows.append(f"{y - options.y:+4d} {row}")
    print(f"blocking item kinds {len(blocking)}, ground kinds {len(ground)}, tiles in region {len(found)}")
    if options.check:
        cells = scan_cells(options.check, "client-loaded check")
        agree = sum(1 for (x, y), open_ in cells.items() if walkable(found.get((x, y), []), blocking, ground) == open_)
        print(f"live scan cells {len(cells)}, agree {agree}, disagree {len(cells) - agree}")
        for (x, y), open_ in sorted(cells.items()):
            mine = walkable(found.get((x, y), []), blocking, ground)
            if mine != open_:
                print(f"  disagree at {x},{y}: live {'walk' if open_ else 'blocked'}, map {'walk' if mine else 'blocked'}, items {found.get((x, y), [])}")
    text = f"walkability around {options.x},{options.y},{options.z} radius {options.radius} (# blocked, . walkable)\n" + "\n".join(rows) + "\n"
    if options.speeds:
        speed_rows = []
        for y in range(y_range[0], y_range[1] + 1):
            cells = []
            for x in range(x_range[0], x_range[1] + 1):
                items = found.get((x, y), [])
                cells.append(str(next((speeds[item] for item in items if item in speeds), 0)))
            speed_rows.append(f"{y} " + ",".join(cells))
        open(options.speeds, "w", encoding="utf-8").write(f"ground speed per tile, x from {x_range[0]} to {x_range[1]}, rows y\n" + "\n".join(speed_rows) + "\n")
    if options.masks:
        exits = floor_change_ids(options.items_xml) if options.items_xml else set()
        masks = []
        for y in range(y_range[0], y_range[1] + 1):
            mask = 0
            for bit, x in enumerate(range(x_range[0], x_range[1] + 1)):
                items = found.get((x, y), [])
                if not walkable(items, blocking, ground) or any(item in exits for item in items):
                    mask |= 1 << bit
            masks.append(mask)
        open(options.masks, "w", encoding="utf-8").write(",".join(str(mask) for mask in masks) + "\n")
    if options.items_xml and options.floor_changes:
        changing = floor_change_ids(options.items_xml)
        spots = sorted((x, y) for (x, y), items in found.items() if any(item in changing for item in items))
        header = f"floor-change tiles on floor {options.z} within radius {options.radius} of {options.x},{options.y} (from {len(changing)} floorchange item ids)\n"
        tall = items_with_height(options.appearances)
        climbs = sorted((x, y) for (x, y), items in found.items() if sum(1 for item in items if item in tall) >= 3)
        body = "\n".join(f"{x},{y} floorchange" for x, y in spots) + "\n" + "\n".join(f"{x},{y} height3" for x, y in climbs) + "\n"
        open(options.floor_changes, "w", encoding="utf-8").write(header + body)
        print(f"floor-change tiles {len(spots)}, tiles with three height items {len(climbs)}")
    if options.out:
        open(options.out, "w", encoding="utf-8").write(text)
    else:
        print(text)


main()
