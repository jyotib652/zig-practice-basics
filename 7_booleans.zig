//! Booleans
const print = @import("std").debug.print;

pub fn main() void {
    const bool_val1 = true;
    const bool_val2 = false;
    _ = bool_val1;
    _ = bool_val2;

    const num1: u8 = 3;
    const num2: i16 = -10;
    const float1: f16 = 3.14;
    const float2: f32 = 3;

    print("num1 equals num2: {}\n", .{num1 == num2});
    print("num1 is not equal to float1: {}\n", .{num1 != float1});
    print("float2 equals num1: {}\n", .{float2 == num1});

    // for comparison types need to match
    // const char_a = 'a';
    // const string_a = "a";
    // print("char_a equals string_a: {}\n", .{char_a == string_a});

    // comparison can only be done between numeric types.
    // like equality or inequality checks we can do any comaprison
    // between any numeric types regardless of their specific types
    // like integer, float, signed or unsigned or their bit width.
    print("num1 less than num2: {}\n", .{num1 < num2});
    print("float1 is greater than num1: {}\n", .{float1 > num1});
    print("num1 less than or equal to num2: {}\n", .{num1 <= num2});
    print("float1 is greater than or equal to num1: {}\n", .{float1 >= num1});

    // Boolean not operator; Negating a boolean value with a '!' operator
    const bool_val = true;
    const bool_false = !true;
    const bool_val_negative = !bool_val;
    print("\n", .{});
    print("bool_false: {}\n", .{bool_false});
    print("bool_val: {}\n", .{bool_val});
    print("bool_val negated: {}\n", .{bool_val_negative});

    // Logical operators: AND (&&) and OR (||)
    const bool_and = bool_val and bool_false; // true AND false -> false
    print("\n", .{});
    const bool_true = true;
    const and1 = bool_false and bool_true; // false AND true -> false
    const and2 = !bool_false and bool_true; // true AND true -> true
    print("and1 (false AND true): {}\n", .{and1});
    print("and2 (true AND true): {}\n", .{and2});
    print("bool_and (true AND false): {}\n", .{bool_and});

    print("\n", .{});
    const or1 = bool_false or bool_true; // false OR true -> true; if one of them is true, the result is true
    const or2 = bool_false or !bool_true; // false OR false -> false
    print("or1 (false OR true): {}\n", .{or1});
    print("or2 (false OR false): {}\n", .{or2});

    // Combining logical operators
    print("\n", .{});
    // AND has higher precedence than OR
    const combined_bool_logic = bool_true or bool_false and !bool_false; // true OR false AND true -> true (AND has higher precedence than OR)
    const combined1 = (bool_true and !bool_false) or bool_false; // (true AND true) OR false -> true
    const combined2 = bool_false and (bool_true or bool_false); // false AND (true OR false) -> false
    print("combined1    : {}\n", .{combined1});
    print("combined2    : {}\n", .{combined2});
    print("combined_bool_logic: {}\n", .{combined_bool_logic});
}
