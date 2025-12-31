//! Functions

const print = @import("std").debug.print;
const doSomething = @import("12_external_functions.zig").doSomething;
const addNumbers = @import("12_external_functions.zig").addNumbers;
const modifyU8 = @import("12_external_functions.zig").modifyU8;
const incrementU8 = @import("12_external_functions.zig").incrementU8;

pub fn main() void {
    // the types of argument/parameters do not need to match,
    // as long as they can be implicitly coerced. E.g. u4 variable
    // can be provided for an argument/parameter of type u8
    // function names follow camelcase convention
    doSomething(8);
    const num1: u8 = 7;
    const num2: u8 = 10;
    const sum_of_nums: u8 = addNumbers(num1, num2);
    print("sum_of_nums: {}\n", .{sum_of_nums});

    print("type of addNumbers function: {} \n", .{@TypeOf(addNumbers)}); // Here we're not calling the function but
    // getting a reference to the function that's why we would not use @TypeOf(addNumbers(num1, num2))) but @TypeOf(addNumbers)).

    const output_modify_u8 = modifyU8(num2, incrementU8);
    print("output_modify_u8: {} \n", .{output_modify_u8});
}

// Public functions can be used by other zig files by using built-in @import function.
// And you can make a function public by adding 'pub' keyword before the function.
// Not only functions, variables and structs also can be marked as public by using 'pub'
// keyword and whatever is public can be used by other zig files by importing them.
// So all in all making them public makes them exportable.
