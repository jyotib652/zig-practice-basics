//! Functions

const print = @import("std").debug.print;

pub fn doSomething(input: u8) void {
    print("function's input: {} \n", .{input});
}

pub fn addNumbers(num1: u8, num2: u8) u8 {
    // function parameters are not mutable so
    // we need to copy the values to other variables
    // if we need to mutate(change) those values
    const output: u8 = num1 +| num2;
    return output;
    // Here, we're modifying the parameters values which is not allowed
    // Because all the parameters/arguments passed to the function
    // are treated as constant irrespective of the actual type of
    // parameters/arguments.
    // num1 = num1 + num2;
    // return num1;
}

pub fn incrementNumeric(input: anytype) @TypeOf(input) {
    // Ensure "input" is numeric
    // Since we want to increment all type of numeric type
    // That's why we are using anytype as parameter type but
    // anytype satisfy any type of variables including null, float,
    // chars, strings, booleans, errors, function references & types.
    // To check the actual numeric type(parameters) we can use
    // @typeInfo built-in function with a switch statement/expression
    return input + 1;
}

/// modifyU8 recieves another function as it's paramater
pub fn modifyU8(input: u8, modifier: fn (u8) u8) u8 {
    return modifier(input);
}

pub fn incrementU8(input: u8) u8 {
    return input +| 1; // to avoid the panic in case of 255 + 1 due to the overflow, using saturating addition.
}
// Tip: it's advised to use saturating addition for numeric values such as u8
