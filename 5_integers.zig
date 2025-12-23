//! Integers
const print = @import("std").debug.print;

pub fn main() void {
    const a: i32 = -42;
    const b: u32 = 42;
    const c: i64 = -1234567890123456789;
    const d: u64 = 12345678901234567890;
    const e: isize = -1000;

    print("Signed 32-bit integer a: {}\n", .{a});
    print("Unsigned 32-bit integer b: {}\n", .{b});
    print("Signed 64-bit integer c: {}\n", .{c});
    print("Unsigned 64-bit integer d: {}\n", .{d});
    print("Signed size integer e: {}\n", .{e});

    // 8 bit integer value: 2^8 = 256; 0 to 255 for u8 and -128 to 127 for i8
    // 16 bit integer value: 2^16 = 65536; 0 to 65535 for u16 and -32768 to 32767 for i16
    // 32 bit integer value: 2^32 = 4294967296; like so on...

    // const unsigned_8_bit_integer: u8 = 256;
    // _ = unsigned_8_bit_integer; // This will cause a compile-time error due to overflow

    // To check if the variable holds value larger than its type can accommodate during the compilation time.
    const some_variable = 256;
    const unsigned_8_bit_integer: u8 = undefined;
    if (some_variable <= 255 and some_variable >= 0) {
        unsigned_8_bit_integer = some_variable;
    } else {
        print("Value {} is too large for u8 type\n", .{some_variable});
    }

    // Wrapping and saturation. They're available for addition, subtraction, multiplication, and left/right shifts but
    // NOT for division.
    const num1: u8 = 255;
    const num2: u8 = 1;
    // const result: u8 = num1 + num2;
    const result_wrapping: u8 = num1 +% num2; // % after the operand sign; Wrapping operation.
    const result_saturation: u8 = num1 +| num2; // | after the operand sign; Saturating operation.
    // print("Result of addition: {}\n", .{result});
    print("result_wrapping: {}\n", .{result_wrapping});
    print("result_saturation: {}\n", .{result_saturation});
    // wrapping operation: when the result reaches the maximum value, it wraps around to
    // the minimum value of the type which is 0 and continues from there.
    // Example: 255 + 1 = 256 which is beyond the maximum value of u8 which is 255.
    // So it wraps around to the next value of 255 which is 0. So, 255 + 1 = 0.
    // Same way 255 + 2 = 257, so from 255 it goes to 0 and then from 0 to 1. So, 255 + 2 = 1.
    // Same way, 255 + 3 = 2 and so on.
    // For subtraction, it wraps around to the maximum value when it goes below 0.
    // saturating operation: when the result reaches the maximum value, it stays at the maximum value.
    // Example: 255 + 1 = 256 which is beyond the maximum value of u8 which is 255.
    // So it stays at 255. So, 255 + 1 = 255.
    // Same way, 255 + 2 = 255 and so on.
    // For subtraction, it stays at 0 when it goes below 0.

    // But can't we store the result in a larger type? Let's see an example:
    // const large_result: u16 = num1 + num2; // This works fine as u16 can accommodate the result
    // But the problem is addition of num1 and num2 is a u8 and it can't hold the value 256. So, it will still overflow before being assigned to large_result.
    // Solution: A hacky way is:
    // const hacky_zero: u16 = 0;
    // const result: u16 = hacky_zero + num1 + num2;
    // print("large_result: {}\n", .{large_result});
    // Solution: Type casting
    // const result: u16 = @as(u16, num1) + @as(u16, num2);
    const result: u16 = @as(u16, num1) + num2; // Only one operand needs to be casted to u16.
    // As zig works sequentially, so when the first operand is u16, it does the operation and then cast the result to u16.
    // Example: zero + num1 + num2; Here, zero is u16, so zero + num1 is calculated and then casted to u16.
    // Then, the result + num2 is calculated and casted to u16.
    // So, only the first operand needs to be casted to u16.
    print("result: {}\n", .{result});
}
