const std = @import("std");

test "day 2 part 1" {
    //var arrx = [_]i64{ 1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50 };
    var arrx = [_]i64{ 1, 12, 2, 3, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 6, 1, 19, 1, 5, 19, 23, 2, 9, 23, 27, 1, 6, 27, 31, 1, 31, 9, 35, 2, 35, 10, 39, 1, 5, 39, 43, 2, 43, 9, 47, 1, 5, 47, 51, 1, 51, 5, 55, 1, 55, 9, 59, 2, 59, 13, 63, 1, 63, 9, 67, 1, 9, 67, 71, 2, 71, 10, 75, 1, 75, 6, 79, 2, 10, 79, 83, 1, 5, 83, 87, 2, 87, 10, 91, 1, 91, 5, 95, 1, 6, 95, 99, 2, 99, 13, 103, 1, 103, 6, 107, 1, 107, 5, 111, 2, 6, 111, 115, 1, 115, 13, 119, 1, 119, 2, 123, 1, 5, 123, 0, 99, 2, 0, 14, 0 };

    var i: usize = 0;
    var step: usize = 1;
    const lenx: usize = arrx.len;

    while (i < lenx) : (i += step) {
        if (arrx[i] == 1) {
            const idx1: usize = @intCast(arrx[@intCast(i + 1)]);
            const idx2: usize = @intCast(arrx[@intCast(i + 2)]);
            const valMul = arrx[idx1] + arrx[idx2];
            const idxChange: usize = @intCast(arrx[i + 3]);

            arrx[idxChange] = valMul;
            step = 4;
        } else if (arrx[i] == 2) {
            const idx1: usize = @intCast(arrx[@intCast(i + 1)]);
            const idx2: usize = @intCast(arrx[@intCast(i + 2)]);
            const valMul = arrx[idx1] * arrx[idx2];
            const idxChange: usize = @intCast(arrx[i + 3]);

            arrx[idxChange] = valMul;
            step = 4;
        } else if (arrx[i] == 9) {
            break;
        }
    }
    std.debug.print("day 2 part 1 -> {} \n", .{arrx[0]});
}

test "day 2 part 2" {
    var i: i64 = 1;
    while (i <= 99) : (i += 1) {
        var ii: i64 = 0;
        while (ii <= 99) : (ii += 1) {
            const res = getValue(i, ii);
            if (res == 19690720) {
                std.debug.print("day 2 part 2-> {} \n", .{100 * i + ii});
            }
        }
    }
}

fn getValue(val1: i64, val2: i64) i64 {
    var arrx = [_]i64{ 1, val1, val2, 3, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 6, 1, 19, 1, 5, 19, 23, 2, 9, 23, 27, 1, 6, 27, 31, 1, 31, 9, 35, 2, 35, 10, 39, 1, 5, 39, 43, 2, 43, 9, 47, 1, 5, 47, 51, 1, 51, 5, 55, 1, 55, 9, 59, 2, 59, 13, 63, 1, 63, 9, 67, 1, 9, 67, 71, 2, 71, 10, 75, 1, 75, 6, 79, 2, 10, 79, 83, 1, 5, 83, 87, 2, 87, 10, 91, 1, 91, 5, 95, 1, 6, 95, 99, 2, 99, 13, 103, 1, 103, 6, 107, 1, 107, 5, 111, 2, 6, 111, 115, 1, 115, 13, 119, 1, 119, 2, 123, 1, 5, 123, 0, 99, 2, 0, 14, 0 };

    var i: usize = 0;
    var step: usize = 1;
    const lenx: usize = arrx.len;

    while (i < lenx) : (i += step) {
        if (arrx[i] == 1) {
            const idx1: usize = @intCast(arrx[@intCast(i + 1)]);
            const idx2: usize = @intCast(arrx[@intCast(i + 2)]);
            const valMul = arrx[idx1] + arrx[idx2];
            const idxChange: usize = @intCast(arrx[i + 3]);

            arrx[idxChange] = valMul;
            step = 4;
        } else if (arrx[i] == 2) {
            const idx1: usize = @intCast(arrx[@intCast(i + 1)]);
            const idx2: usize = @intCast(arrx[@intCast(i + 2)]);
            const valMul = arrx[idx1] * arrx[idx2];
            const idxChange: usize = @intCast(arrx[i + 3]);

            arrx[idxChange] = valMul;
            step = 4;
        } else if (arrx[i] == 9) {
            break;
        }
    }
    return arrx[0];
}
