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

    // Different function return types. print & dummyFunction
    // switch (thirteen) {
    //     0 => print("value is 0 \n", .{}),
    //     1 => dummyFunction(), // the error says retun types do not match. print returns void but dummyFunction returns bool
    //     2 => print("value is 2 \n", .{}),
    //     3, 4 => print("value is either 3 or 4 \n", .{}),
    //     5...10 => print("value is between 5 and 10 (inclusive) \n", .{}),
    //     10 + 1 => print("value is 11 \n", .{}), // For this operation, values should comptime known
    //     twelve => print("value is 12 \n", .{}),
    //     // thirteen => print("value is 13 \n", .{}),
    //     else => print("value is something else \n", .{}),
    // }

    // Solution to different function return types within switch statement
    switch (thirteen) {
        0 => print("value is 0 \n", .{}),
        1 => {
            _ = dummyFunction(); // wrap dummyFunction in a block and since here we don't need the value discard it.
        },
        2 => print("value is 2 \n", .{}),
        3, 4 => print("value is either 3 or 4 \n", .{}),
        5...10 => print("value is between 5 and 10 (inclusive) \n", .{}),
        10 + 1 => print("value is 11 \n", .{}), // For this operation, values should comptime known
        twelve => print("value is 12 \n", .{}),
        // thirteen => print("value is 13 \n", .{}),
        else => print("value is something else \n", .{}),
    }

    // Besides primitive types like numbers & booleans, switch can be done on enums & tagged unions
    const data_type_enum: DataTypes = DataTypes.integer;

    switch (data_type_enum) {
        DataTypes.integer => print("enum is an integer \n", .{}),
        DataTypes.float => print("enum is float \n", .{}),
        else => print("enum is something else"),
    }

    // We can determine the active field of the tagged union and run some logic based on that with switch
    const tagged_union: TaggedUnion = TaggedUnion{ .float = 3.14 };
    switch (tagged_union) {
        TaggedUnion.integer => print("Integer field is active \n", .{}),
        TaggedUnion.float => |val| print("Float field is active: {} \n", .{val}),
        TaggedUnion.boolean => print("Boolean field is active \n", .{}),
    }

    // If we make the tagged_union a variable then we can modify the value within switch statement using a pointer
    var another_tagged_union: TaggedUnion = TaggedUnion{ .float = 3.14 };
    switch (another_tagged_union) {
        TaggedUnion.integer => print("Integer field is active \n", .{}),
        TaggedUnion.float => |*val| {
            val.* = 3.141;
            print("Float field is active: {} \n", .{val.*});
        },
        TaggedUnion.boolean => print("Boolean field is active \n", .{}),
    }

    print("another_tagged_union after the switch: {} \n", .{another_tagged_union});
}

const DataTypes = enum { integer, float, boolean };
const TaggedUnion = union(DataTypes) { integer: u8, float: f32, boolean: bool };

fn dummyFunction() bool {
    return true;
}
