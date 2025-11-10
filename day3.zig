const std = @import("std");
const dayone = @import("day1.zig");

test "day 3 part 1" {
    const alloc = std.heap.page_allocator;
    const content = try std.fs.cwd().readFileAlloc(alloc, "day3.txt", 2024 * 2024);
    defer alloc.free(content);

    //var tokenizer = std.mem.tokenizeAny(u8, content, ",");
    var tokenizer = std.mem.tokenizeAny(u8, content, "\n");

    var lines1 = std.ArrayList([]const u8).init(alloc);
    defer lines1.deinit();

    var lines2 = std.ArrayList([]const u8).init(alloc);
    defer lines2.deinit();

    var idx: usize = 0;

    while (tokenizer.next()) |line| {
        idx += 1;
        //try lines.append(line);
        if (idx == 1) {
            var token1 = std.mem.tokenizeAny(u8, line, ",");
            while (token1.next()) |tok| {
                try lines1.append(tok);
            }
        } else if (idx == 2) {
            var token1 = std.mem.tokenizeAny(u8, line, ",");
            while (token1.next()) |tok| {
                try lines2.append(tok);
            }
        }
    }

    var i: usize = 0;
    var ii: usize = 0;

    var coordx1 = Coord{
        .x = 0,
        .y = 0,
    };

    var coordx2 = Coord{
        .x = 0,
        .y = 0,
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var arr1 = std.ArrayList(Coord).init(allocator);
    defer arr1.deinit();

    var arr2 = std.ArrayList(Coord).init(allocator);
    defer arr2.deinit();

    while (i < lines1.items.len) : (i += 1) {
        const res = try parseDirect(lines1.items[i]);
        try parseCoord(res, &coordx1, &arr1);
    }

    while (ii < lines2.items.len) : (ii += 1) {
        const res = try parseDirect(lines2.items[ii]);
        try parseCoord(res, &coordx2, &arr2);
    }

    var resVal = std.ArrayList(usize).init(allocator);
    defer resVal.deinit();

    //Manhattan distance=∣x1−x2∣ + ∣y1−y2∣
    for (arr1.items) |items1| {
        for (arr2.items) |items2| {
            if (items1.x == items2.x and items1.y == items2.y) {
                const manDist = @abs(items1.x) + @abs(items1.y);
                try resVal.append(manDist);

                //std.debug.print("arrx -> {} {} mandist -> {} \n", .{ items1.x, items1.y, manDist });
            }
        }
    }

    var cur = resVal.items[0];

    for (resVal.items) |val| {
        if (val < cur) {
            cur = val;
        }
    }

    std.debug.print("res -> {} \n", .{cur});
}

const Direction = struct {
    direct: u8, //char
    val: u64, //int
};

const Coord = struct {
    x: i64,
    y: i64,
};

fn parseDirect(val: []const u8) !Direction {
    const direct = val[0];
    const testalloc = std.heap.page_allocator;
    var list = std.ArrayList(u8).init(testalloc);
    defer list.deinit();

    var i: usize = 1;
    while (i < val.len) : (i += 1) {
        try list.append(val[i]);
    }

    const num = try dayone.parseU64(list.items, 10);

    return Direction{ .direct = direct, .val = num };
}

fn parseCoord(val: Direction, cur: *Coord, arr: *std.ArrayList(Coord)) !void {
    if (val.direct == 'R') {
        //cur.x += val.val;
        for (0..val.val) |_| {
            cur.x += 1;
            try arr.append(cur.*);
        }
    } else if (val.direct == 'L') {
        //cur.x -= val.val;
        for (0..val.val) |_| {
            cur.x -= 1;
            try arr.append(cur.*);
        }
    } else if (val.direct == 'U') {
        //cur.y += val.val;
        for (0..val.val) |_| {
            cur.y += 1;
            try arr.append(cur.*);
        }
    } else if (val.direct == 'D') {
        //cur.y -= val.val;
        for (0..val.val) |_| {
            cur.y -= 1;
            try arr.append(cur.*);
        }
    }
}
