//! Comptime in Zig
const print = @import("std").debug.print;

pub fn main() void {
    const comptime_known_int = 10;
    const comptime_known_int2: u8 = 7;

    print("type of comptime_known_int: {}\n", .{@TypeOf(comptime_known_int)});
    print("type of comptime_known_int2: {}\n", .{@TypeOf(comptime_known_int2)});

    // @compileError built-in function can be used to trigger a compile-time error.
    if (comptime_known_int != 10) {
        @compileError("comptime_known_int doesn't equal 10");
    }

    if (comptime_known_int2 != 7) {
        @compileError("comptime_known_int2 doesn't equal 7");
    }
    // Since comptime_known_int and comptime_known_int2 values are known at compile-time, the above conditions will never be true,
    // and thus the @compileError calls will not be executed. In fact, the Zig compiler will optimize away these checks entirely during compilation.

    // An example of comptime unknown value would be a value read from user input or a file at runtime.
    // So it would be a runtime known value.
    // Another example of runtime known value would be a mutable variable.
    var runtime_known_int: u8 = 5;
    _ = &runtime_known_int;
    if (runtime_known_int != 5) {
        // @compileError("runtime_known_int doesn't equal 5"); // it will trigger compile error as runtime_known_int is mutable variable and its value is not known at compile-time.
    }

    // comptime keyword
    // comptime keyword can be used to force evaluation of an expression at compile-time.
    // comptime keyword can be used with variables, function parameters and expressions.
    comptime var comptime_mutable_var: u8 = 0;
    // when we mark a variable as comptime, we guarantee that this variable would be loaded and stored only at compile-time.
    // failure to do so would result in a compile-time error.
    comptime_mutable_var = comptime_known_int;
    // comptime_int and comptime_float are treated as if there is a comptime keyword before them. So they are treated as comptime variables.
    // mutable variable must be marked with comptime keyword to be used at compile-time.
    comptime var comptime_mutable_var2: u4 = 0;
    comptime_mutable_var2 = comptime_known_int; // It should generally fail as we are assigning u8 to u4, but since comptime_known_int is 10 which fits in u4, it works.
    // Similarly, we can assign comptime known value to a runtime known variable.
    runtime_known_int = comptime_known_int2; // works as comptime_known_int2 is 7 which fits in u8.
    // But assigning a runtime known u8 value to a comptime known u4 variable would fail as the value is not known at compile-time.
    // as the u8 value may not fit in u4. If the u8 value is greater than 15, it would cause overflow.

    doSomething(comptime_known_int, runtime_known_int);
    // doSomething(runtime_known_int, runtime_known_int); // this will cause compile-time error as the provided first parameter isn't a comptime known value.

    // Expressions can also be marked as comptime.
    // Functions are expressions too so they can also be marked as comptime.
    // comptime doSomething(comptime_known_int, runtime_known_int); // it would cause compile-time error as all the parameters are not comptime known values.
    comptime doSomething(comptime_known_int, comptime_known_int); // but this will work as all the parameters are comptime known values.
    // So comptime keyword can be used to force evaluation of an expression at compile-time.
    // And for that all the variables used in that expression must be comptime known values.

}

/// doSomething function that takes a comptime u8 as first parameter. The first parameter must be a comptime variable.
fn doSomething(comptime input: u8, input2: u8) void {
    // Function that takes a comptime u8 as input
    _ = input;
    _ = input2;
}
