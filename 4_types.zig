//! Types and related functions in Zig programming language

const print = @import("std").debug.print;

pub fn main() void {
    const unsigned_int: u8 = 15;
    const signed_int: i8 = 9;
    _ = unsigned_int;
    _ = signed_int;

    // Most commonly used are 8, 16, 32, 64 bit integers.
    // But you can also create your own custom bit-length integers like 7, 9, 12 bit integers.
    const unsigned_int_7: u8 = 123;
    const signed_int_7: u8 = 125;
    _ = unsigned_int_7;
    _ = signed_int_7;

    // Unlike integers you can't define your own float types with custom bit-lengths.
    // There are 5 float types are available for you these are: f16, f32, f64, f80, f128.
    const float_16: f16 = 1.234567891011121314151617181920;
    const float_32: f32 = 1.234567891011121314151617181920;
    const float_64: f64 = 1.234567891011121314151617181920;
    const float_80: f80 = 1.234567891011121314151617181920;
    const float_128: f128 = 1.234567891011121314151617181920;
    // _ = float_16;
    // _ = float_32;
    // _ = float_64;
    // _ = float_80;
    // _ = float_128;

    print("float_16: {}, float_32: {}, float_64: {}, float_80: {}, float_128: {}\n", .{ float_16, float_32, float_64, float_80, float_128 });

    const a_bool: bool = true;
    // _ = a_bool;

    const a_void: void = void{};
    _ = a_void;

    // custom type; type of a specific type
    const unsigned_8_bit_integer: type = u8;
    _ = unsigned_8_bit_integer;

    const type_of_a_bool: type = @TypeOf(a_bool);
    print("type of a bool: {}\n", .{type_of_a_bool});

    print("typeOf u8: {}\n", .{@TypeOf(u8)});
    print("typeInfo u8: {}\n", .{@typeInfo(u8)});

    const memory_addr: usize = @intFromPtr(&a_bool);
    print("memory address of a_bool: {}\n", .{memory_addr});

    const const_int = 5;
    const const_float = 1.123;
    // print("const_int: {}, const_float: {}\n", .{const_int, const_float});
    print("type of const_int: {}\n", .{@TypeOf(const_int)});
    print("type of const_float: {}\n", .{@TypeOf(const_float)});

    // Since it's mutable, it's value is not known at compile time.Therefore, its type is a pointer to an integer.
    // And there is no guarantee that its value will remain the same during the compile time.
    // var mutable_int = 10;
    // _ = &mutable_int;
    // To make the value known at compile time, you can use comptime keyword.
    comptime var mutable_int = 10;
    _ = &mutable_int;
    print("type of mutable_int: {}\n", .{@TypeOf(mutable_int)});
    // we can also assign comptime_int as type tp mutable_int like this:
    // comptime var mutable_int: comptime_int = 10;
    // _ = &mutable_int;
}

/// The noreturn type is fundamentally different. It's a promise to the compiler that a function will never return control to its caller.
///
/// This can happen for a few reasons:
///
/// The function contains an infinite loop.
/// The function terminates the program or thread.
/// The function panics.
/// The compiler uses this information for control flow analysis. If you call a noreturn function, the compiler knows that any code immediately after that call is unreachable.
fn infiniteLoop() noreturn {
    while (true) {}
}

/// The void type in Zig is a zero-bit type, meaning it can hold no information. It has only one possible value: void{}.
/// When a function has a return type of void, it means the function will execute and return control to the caller, but it won't return any value.
fn logValue(value: anytype) void {
    _ = value;
}

fn logError(err: anyerror) void {
    _ = err;
}
