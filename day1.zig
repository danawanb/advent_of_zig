const std = @import("std");
const fs = std.fs;
const maxInt = std.math.maxInt;

pub fn parseU64(buf: []const u8, radix: u8) !u64 {
    var x: u64 = 0;
    for (buf) |c| {
        const digit = charToDigit(c);
        if (digit >= radix) {
            //std.debug.print("digit {d} || \n", .{digit});
            break;
        }

        var ov = @mulWithOverflow(x, radix);
        if (ov[1] != 0) return error.OverFlow;

        ov = @addWithOverflow(ov[0], digit);
        if (ov[1] != 0) return error.OverFlow;

        x = ov[0];
    }

    return x;
}

fn charToDigit(c: u8) u8 {
    return switch (c) {
        '0'...'9' => c - '0',
        'A'...'Z' => c - 'A' + 10,
        'a'...'z' => c - 'a' + 10,
        else => maxInt(u8),
    };
}
test "day 1" {
    const alloc = std.heap.page_allocator;
    const content = try std.fs.cwd().readFileAlloc(alloc, "day1.txt", 1024 * 1024);
    defer alloc.free(content);

    var tokenizer = std.mem.tokenizeAny(u8, content, "\n");

    var lines = std.ArrayList([]const u8).init(alloc);
    defer lines.deinit();

    while (tokenizer.next()) |line| {
        try lines.append(line);
    }

    var i: usize = 0;

    var finalVal: usize = 0;
    while (i < lines.items.len) : (i += 1) {
        const text = lines.items[i];
        const val = try parseU64(text, 10);

        finalVal += dayOne(val);
    }

    std.debug.print("day1 part 1 -> {d} \n", .{finalVal});
}

test "day 1 part 2" {
    const alloc = std.heap.page_allocator;
    const content = try std.fs.cwd().readFileAlloc(alloc, "day1.txt", 1024 * 1024);
    defer alloc.free(content);

    var tokenizer = std.mem.tokenizeAny(u8, content, "\n");

    var lines = std.ArrayList([]const u8).init(alloc);
    defer lines.deinit();

    while (tokenizer.next()) |line| {
        try lines.append(line);
    }

    var i: usize = 0;

    var finalVal: usize = 0;
    while (i < lines.items.len) : (i += 1) {
        const text = lines.items[i];
        const val = try parseU64(text, 10);
        var sum: u64 = 0;
        dayOneRec(val, &sum);
        finalVal += sum;
    }

    std.debug.print("day1 part 2 -> {d} \n", .{finalVal});
}

fn dayOne(val: u64) u64 {
    const div3 = @divFloor(val, 3);
    return div3 - 2;
}

fn dayOneRec(val: u64, sum: *u64) void {
    if (val <= 2) {
        return;
    }
    const div3 = @divFloor(val, 3);

    const res = @subWithOverflow(div3, 2);
    if (res[1] == 1) return;

    sum.* = sum.* + res[0];

    return dayOneRec(res[0], sum);
}
