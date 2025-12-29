//! Chars and Strings

// const print = @import("std").debug.print;
const std = @import("std");
const print = std.debug.print;
pub fn main() void {
    // Zig uses u8 to represent characters
    const char_a: u8 = 'a'; // single character represented as a u8
    const char_b: u8 = 'b';
    const char_newline: u8 = '\n'; // newline character

    print("Character a: {}\n", .{char_a});
    print("Character b: {}\n", .{char_b});
    print("Newline character: {}\n", .{char_newline});

    // String literals are represented as arrays of u8
    // const hello: []const u8 = "Hello, Zig!";
    // print("String literal: {}\n", .{hello});

    // // Strings can also be defined as arrays with fixed length
    // const fixed_length_string: [6]u8 = "ZigLang"; // Note: This will cause a compile-time error because "ZigLang" has 7 characters including null terminator
    // // To fix the above line, we should define it with the correct length:
    // const correct_fixed_length_string: [7]u8 = "ZigLang"; // 7 to include null terminator
    // print("Fixed length string: {}\n", .{correct_fixed_length_string});

    // // You can also create strings dynamically using slices
    // var buffer: [20]u8 = undefined; // buffer to hold the string
    // const slice: []u8 = buffer[0..0]; // empty slice initially
    // const dynamic_string = "Dynamic String";
    // std.mem.copy(u8, buffer[0..dynamic_string.len], dynamic_string);
    // const dynamic_slice: []u8 = buffer[0..dynamic_string.len];
    // print("Dynamic string slice: {}\n", .{dynamic_slice});

    //
    const a_char: u8 = 'a'; // '' for chars & "" for strings
    print("a character ASCII value: {}\n", .{a_char}); // a_char: 97
    const b_char = 'b';
    print("type of b_char: {}\n", .{@TypeOf(b_char)});
    const a_string = "This is a string";
    // _ = a_string;
    const another_string = "Another string";
    // _ = another_string;
    const concat_string = a_string ++ " " ++ another_string;
    // s specifier is needed to print strings: {s}
    print("Concatenated string: {s}\n", .{concat_string}); // Don't forget to use {s} for strings to print strings.
    // String must be an array of unsigned 8-bit integers (u8). Each character in the string is represented by its ASCII value.
    // String are immutable by default.
    // Sting can be concatenated using the ++ operator.
    // String can be  repeated using the ** operator.

    // Multi line strings
    const multiple_strings =
        \\Multiline string
        \\Line 2
    ;
    print("Multiple line string: {s}\n", .{multiple_strings});
    print("type of a_string: {}\n", .{@TypeOf(a_string)});

    var b_string = "Table";
    // Although b_string is mutable, each element in the string is constant,
    // so you cannot change individual characters. Therefore, we cannot modify b_string directly.
    // b_string[2] = 'C'; // This will cause a compile-time error
    b_string = "tiger"; // But we can reassign the whole string of the same length.
    print("b_string: {s}\n", .{b_string});

    // The type of a string literal is a single item pointer to a constant null terminated byte array.
    // *const [14:0]u8   -> @TypeOf(String Literal)
    // *const -> (Single item) pointer to a constant
    // [14:0]u8          -> Array of 14 u8 elements + null terminator:
    //     u8               -> Each element is an unsigned 8-bit integer (byte)
    //     [14:0]           -> Array has 14 elements (0 to 13) + null terminator at index 14

}
