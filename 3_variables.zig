//! Variables in Zig

const top_level_number: u8 = 42; // top-level constant variable
const Unsigned8BitInteger: type = u8; // type alias for u8 or creating a custom type
const another_top_level_number: Unsigned8BitInteger = 100; // using the type alias

// top level variables are order independent but inside functions they are order dependent.
const top_level_number2: Unsigned8BitInteger2 = 42;
const Unsigned8BitInteger2: type = u8;

const print = @import("std").debug.print; // it's const print = @import("std").debug.print; but type is inferred by the compiler

pub fn main() void {
    var mutable_num: u8 = 13;
    const const_num: u8 = 5;

    // for variable values need to be mutated or used. And for constant values need to be used.
    // mutable_num = 0;
    // const_num = 0; // This line will cause a compile-time error because const_num is immutable
    _ = const_num; // Using _ to avoid unused variable warning
    _ = &mutable_num; // Using _ to avoid unused variable warning but for mutable variable we have to use memory address to avoid compilation failing. This is used only for debugging purposes.

    // Inferred type. In this case compiler guesses the type based on the assigned value.
    var mutable_num2: u8 = 15;
    const const_num2 = 10; // here we're not specifying the type explicitly, so compiler infers it as u8
    // _ = const_num2; // Using _ to avoid unused variable warning

    // But mutable variables needs proper type because a number can be of different types like u8, u16, u32, u64, i8, i16, i32, i64, etc.
    // Only exception is for boolean values.
    _ = &mutable_num2; // Using _ to avoid unused variable warning but for mutable
    var mutable_bool = true; // inferred type as bool, here we're not specifying the type explicitly
    mutable_bool = true;

    // valid or invalid variable names(identifiers)
    var _valid_name1: u8 = 1; // valid
    _ = &_valid_name1;
    // const some_n$mb@r: u8 = 2; // invalid
    // But you can turn an invalid identifier into a valid one by using escape character @"" (if it's needed)
    const @"some_n$mb@r": u8 = 2; // valid
    _ = @"some_n$mb@r";

    print("Const Number 2: {}\n", .{const_num2});

    // Shadowing variables. variable names cannot shadow identifiers from outer scopes. like top-level variables.
    // const top_level_number = 0; // this shadows the top-level variable with the same name and it's not allowed.

    // variables can hold primitive values
    // primitive values are: numbers, null, undefined, true & false.

    const a_boolean: bool = true;
    const optional: ?u8 = null; // optional type can hold a value or null
    _ = a_boolean;
    _ = optional;
    // undefined can be used with any type. At least when the variable is uninitialized.
    var numeric_var: u8 = undefined;
    var another_bool: bool = undefined;
    _ = &numeric_var;
    _ = &another_bool;
    // And we can't check undefined value directly. like this:
    // if (numeric_var == undefined) { // invalid
    //     // do something
    // }
    print("Numeric Var is undefined: {}\n", .{numeric_var == undefined});
    print("another_bool is undefined: {}\n", .{another_bool == undefined});
    // Instead we can use @typeInfo to check if a variable is undefined. but this is rarely used in practice.
    const type_info = @typeInfo(@TypeOf(numeric_var));
    _ = type_info;

    // use undefined only when you're sure that the value will be overwritten before it's used.
    // undefined in zig is in no way related to undefined in javascript.

}
