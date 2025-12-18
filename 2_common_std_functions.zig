//! Common Standard Library Functions

pub fn main() void {
    // const std = @import("std");

    // // Print to the console
    // std.debug.print("Hello, Zig Standard Library!\n", .{});

    // // Working with arrays
    // var arr: [5]u8 = .{ 1, 2, 3, 4, 5 };
    // std.debug.print("Array contents: ");
    // for (arr) |item| {
    //     std.debug.print("{} ", .{item});
    // }
    // std.debug.print("\n", .{});

    // // Using a standard library function to sort an array
    // std.sort.u8(arr[0..], std.sort.Order.Ascending);
    // std.debug.print("Sorted array: ");
    // for (arr) |item| {
    //     std.debug.print("{} ", .{item});
    // }
    // std.debug.print("\n", .{});

    const number: u8 = 65;
    @import("std").debug.print("Number: {}\n", .{number}); // number in decimal format by default
    @import("std").debug.print("Number in decimal: {d}\n", .{number}); // number in decimal format. Specifying decimal format explicitly.
    @import("std").debug.print("Number in octal: {o}\n", .{number}); // number in octal format
    @import("std").debug.print("Number in hex: {x}\n", .{number}); // number in hexadecimal format
    @import("std").debug.print("Number in binary: {b}\n", .{number}); // number in binary format
    @import("std").debug.print("Number in char: {c}\n", .{number}); // number as a character. According to the ASCII table, 65 is 'A'
    // @import("std").debug.print("Number in string: {s}\n", .{number}); // in string format but number can't be directly converted to string, so it needs to be a string.
    @import("std").debug.print("String: {s}\n", .{"This is a string"});
    // Correction: as of Zig version 0.15.1, the following line will cause a compilation error
    // @import("std").debug.print("Number (?): {?}\n", .{number});
    // "?" specifier can no longer be used with non-optional variables
    // Optional types will be covered in a future lesson
    @import("std").debug.print("Number in default format: {any}\n", .{number}); // This will print the value in default format.
    // The difference between "any" and a blank specifier is that some types(e.g. arrays) require you to
    // explicitly specify how the output is to be displayed.
    // note: default format for u8(a number) is decimal.
    // @import("std").debug.print("String: {}\n", .{"This is a string"}); // for some type a specifier is a must. Like strings and arrays.
    @import("std").debug.print("String: {s}\n", .{"This is a string"});

    @import("std").log.debug("Debug message", .{});
    @import("std").log.warn("Warning message", .{});
    @import("std").log.info("Info message", .{});
    @import("std").log.err("Error message", .{});

    const arrays1: [3]u8 = [3]u8{ 2, 5, 7 };
    // const arrays1 : [3]u8 = .{2, 5, 7}; // alternative way to declare and initialize an array
    const arrays2: [3]u8 = [3]u8{ 2, 5, 7 };
    const are_arrays_equal: bool = @import("std").mem.eql(u8, &arrays1, &arrays2); // &arrays1 means memory address of arrays1
    // const are_arrays_equal: bool = @import("std").mem.eql(u8, arrays1[0..], arrays2[0..]); // alternative way to compare arrays
    @import("std").debug.print("Are arrays equal? {}\n", .{are_arrays_equal});
}
