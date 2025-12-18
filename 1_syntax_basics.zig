//! This module is a top level doc comment.And it's used to document modules. They can only appear at the top of the module.
//! This module is a quick intro to zig

const std = @import("std");

/// This is a doc/documentation comment and they are used to document functions.
/// Doc comments can't be placed anywhere, they must be placed before functions.
/// This function is the entry point for our program.
pub fn main() void {
    // each should end with a semicolon but
    // exceptions are comments, loops, if conditions & {}brackets of functions
    const number1: u8 = 5;
    var number2: u8 = 10;

    number2 = 10;

    // built-in functions are prefixed/start with @
    // standard library is not bundled automatically, you have to import it
    @import("std").debug.print("Number1: {}, Number2: {}\n", .{ number1, number2 });

    // Normal comments are like this

    // custom types
    // Function Names: camelCase -> addNumbers
    // Custom Type Names: PascalCase/TitleCase -> Unsigned16BitInteger
    // Everything else: snake_case -> sum_of_integers

    const Unsigned16BitInteger = u16;
    const sum_of_integers: Unsigned16BitInteger = addNumbers(number1, number2);
    // _ = sum_of_integers; // _ is used to ignore values
    std.debug.print("Sum: {}\n", .{sum_of_integers});
}

pub fn addNumbers(num1: u8, num2: u8) u8 {
    return num1 + num2;
}
