//! Switch

const print = @import("std").debug.print;

pub fn main() void {
    const value = 10;

    // if (value == 0) {
    //     print("value is 0 \n", .{});
    // } else if (value == 1) {
    //     print("value is 1 \n", .{});
    // } else if (value == 2) {
    //     print("value is 2 \n", .{});
    // } else {
    //     print("value is something else \n", .{});
    // }

    // // Above if else statement and this switch statement are equivalent. Both of them do the same thing.
    // switch (value) {
    //     0 => print("value is 0 \n", .{}),
    //     1 => print("value is 1 \n", .{}),
    //     2 => print("value is 2 \n", .{}),
    //     else => print("value is something else \n", .{}),
    // }

    // Switch statement can also do a little more. The properties of switch statement
    const twelve = 12; // Since this variable is comptime known, we are able to use it as a switch case
    var thirteen: u8 = 13; // Since this variable is runtime known, we can't use it as a switch case
    _ = &thirteen;
    switch (value) {
        0 => print("value is 0 \n", .{}),
        1 => print("value is 1 \n", .{}),
        2 => print("value is 2 \n", .{}),
        3, 4 => print("value is either 3 or 4 \n", .{}),
        5...10 => print("value is between 5 and 10 (inclusive) \n", .{}),
        10 + 1 => print("value is 11 \n", .{}), // For this operation, values should comptime known
        twelve => print("value is 12 \n", .{}),
        // thirteen => print("value is 13 \n", .{}),
        else => print("value is something else \n", .{}),
    }

    // Switch can be used in various ways
    const output = switch (value) {
        0 => 123,
        1 => 25,
        2...10 => |val| val * 2,
        11 => |val| blk: { // using of block within switch case
            break :blk val + 25;
        },
        else => 100,
    };

    print("output from switch expression: {} \n", .{output});

    const a_boolean: bool = true;
    switch (a_boolean) {
        true => print("a_boolean is true \n", .{}),
        false => print("a_boolean is fale \n", .{}),
    }
}
