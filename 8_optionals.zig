//! Optionals type in Zig
const print = @import("std").debug.print;

pub fn main() void {
    // An optional type can either hold a value of a specified type or null value.
    // The syntax for defining an optional type is to prefix the type with a '?' character.
    // An optional value can have a value that is either a null or a as defined by underlying type.
    var optional_int: ?u8 = null;
    print("optional_int initial value: {?}\n", .{optional_int}); // while printing optional type, use {?} specifier
    optional_int = 10;
    print("optional_int: {?}\n", .{optional_int});

    // Unwrapping Optionals
    // To access the value inside an optional type, you need to unwrap it.
    // You can use the 'orelse' keyword to provide a default value in case the optional is null.
    var optional_bool: ?bool = null;
    _ = &optional_bool;

    // The type of unwrapped_int can be u8 but u16 is used to avoid potential overflow.
    // And u16 will work too, as u8 can fit in u16.
    const unwrapped_int: u16 = optional_int orelse 0; // if optional_int is null, use 0 as default value
    const unwrapped_bool = optional_bool orelse false; // if optional_bool is null, use false as default value
    print("\n", .{});
    print("unwrapped_int: {}\n", .{unwrapped_int});
    print("unwrapped_bool: {}\n", .{unwrapped_bool});

    // Optional unwrap without default value
    // You can also unwrap an optional type without providing a default value using the '.?' operator.
    // However, if the optional is null, this will cause a runtime error, crashing the program.
    const unwrapped_int2 = optional_int.?; // unwraps the value, will crash if optional_int is null
    // const unwrapped_bool2 = optional_bool.?; // unwraps the value, will crash if optional_bool is null
    print("\n", .{});
    print("unwrapped_int2: {}\n", .{unwrapped_int2});
    // print("unwrapped_bool2: {}\n", .{unwrapped_bool2});
    print("type of unwrapped_int2: {}\n", .{@TypeOf(unwrapped_int2)});
    doSomething(optional_int);
    doSomething(unwrapped_int2);
    // doSomethingElse(optional_int); // This will crash because optional_int is not u8 although
    // it holds a u8 value, function doesn't know what to do with a potential null value as optional_int is of type ?u8(optional u8)
}

fn doSomething(input: ?u8) void {
    // // Function that takes an optional u8 as input
    // if (input) |value| {
    //     // If input is not null, use the value
    //     _ = value;
    // } else {
    //     // Handle the case where input is null
    // }
    _ = input;
}

fn doSomethingElse(input: u8) void {
    // Function that takes a u8 as input
    _ = input;
}
