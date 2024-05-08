const std = @import("std");
pub fn main() !void {
    var input: [100]u8 = undefined;
    var valid = false;
    while (!valid) {
        std.debug.print("Enter number between 0 and 185: ", .{});
        const stdin = std.io.getStdIn().reader();
        const stdout = std.io.getStdOut().writer();
        const result = try stdin.readUntilDelimiter(&input, '\n');
        const trimmed = result[0..(result.len - 1)];
        var cond = true;
        if (trimmed.len > 0) {
            if (trimmed.len < 4) {
                for (trimmed) |int| {
                    const check = checkInt(int);
                    // std.debug.print("{}\n", .{check});
                    // std.debug.print("int: {d},trimmed: {d}\n", .{ int, trimmed });
                    if (!check) {
                        valid = false;
                        cond = false;
                    }
                }
                if (cond) {
                    // trimmed[0] > 47 && trimmed[0] < 58
                    // if (trimmed[0] >)
                    // std.debug.print("trimmed: {d}\n", .{trimmed});
                    const num = try std.fmt.parseInt(i32, trimmed, 10);
                    try stdout.print("The user entered: {d}\n", .{num});
                    if (num < 186) {
                        printFib(num);
                        valid = true;
                        break;
                    } else {
                        std.debug.print("Number too big. Enter number smaller than 186.\n", .{});
                        valid = false;
                    }
                } else if (!cond) {
                    std.debug.print("Invalid input. Enter 3 digits number.\n", .{});
                    valid = false;
                }
            } else {
                std.debug.print("Invalid input. Enter 3 digits number.\n", .{});
                valid = false;
            }
        } else {
            // std.debug.print("Enter number between 0 and 185: ", .{});
            valid = false;
        }
    }
}
// private function that checks the digits to be valid integers.
fn checkInt(i: u8) bool {
    if (i < 47) {
        return false;
    } else if (i > 57) {
        return false;
    } else return true;
}
// private function that prints fibonacci series of the given number
fn printFib(n: i128) void {
    if (n > 185) {
        std.debug.print("Number too big", .{});
    } else if (n == 0) {
        std.debug.print("Fibonacci of {d}: {d}", .{ n, 0 });
    } else if (n < 0) {
        std.debug.print("Number too small", .{});
    } else {
        var prev1: i128 = 1;
        var prev2: i128 = 0;
        var i: i128 = 0;
        // std.debug.print("{d}\n", .{0});
        var result: i128 = undefined;
        while (n > i) {
            i += 1;
            if (i == 1) {
                std.debug.print("{d}: {d},\n", .{ i, prev2 });
                result = i;
            }
            if (i == 2) {
                std.debug.print("{d}: {d}\n", .{ i, prev1 });
                result = i;
            }
            if (i > 2) {
                const num: i128 = prev1 + prev2;
                prev2 = prev1;
                prev1 = num;
                std.debug.print("{d}: {d},\n", .{ i, num });
                result = num;
            }
        }
        std.debug.print("Fibonacci of {d}: {d}", .{ n, result });
    }
}
