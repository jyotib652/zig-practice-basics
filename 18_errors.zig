//! Errors

const print = @import("std").debug.print;

// In Zig, instead of an error being thrown, it is returned or assigned to a variable as a value.
// And it's upto us to check if the variable or return value of a function holds an error.
// Error set is a type defined by us, they represents a collection of errors also defined
// by us. Error set is comparable to an enum. Each error will get a unique underlying
// integer value. The only difference between an enum and an error is the "error" keyword.

// All of these errors are made up values. They aren't system provided values at all.
const IOError = error{ FileNotFound, PermissionDenied, ValueIsNull };
const PrintError = error{ValueIsNull};

pub fn main() !void {
    // We need to change "main() void" to main() !void for the unwrapping of
    // the error union with try keyword for this line(line no. 81): "var unwrapped_val = try int_or_error;"

    print("IOError.FileNotFound: {} \n", .{IOError.FileNotFound});
    // Just like an enum, each property of an error is assigned a numeric value.
    // And we can get this value by using built-in function @intFromError
    print("int of IOError.FileNotFound: {} \n", .{@intFromError(IOError.FileNotFound)}); // 27

    // If the error value of two different errors is same then they will get
    // identical(same) integer value
    print("int of IOError.ValueIsNull: {} \n", .{@intFromError(IOError.ValueIsNull)}); // 150
    print("int of PrintError.ValueIsNull: {} \n", .{@intFromError(PrintError.ValueIsNull)}); // 150

    // Therefore these two errors are equivalent. So errors with same name are identical even if they belong
    // to different error sets.
    print("IOError.ValueIsNull == PrintError.ValueIsNull: {} \n", .{IOError.ValueIsNull == PrintError.ValueIsNull});

    // If an error set holds a single value then it can be defined as:
    const custom_error = error.ValueIsNull; // This is a short cut for defining an error set with a single value
    // _ = custom_error;
    // The following line will cause a compile error: `error: unhandled error`
    // In Zig, errors are values that must be handled and cannot be discarded with `_`.
    // const custom_error = error.ValueIsNull; This is equivalent to creating an error set with a single value and getting that value from the error set
    print("custom_error: {}\n", .{custom_error});

    // Error union type is similar to optional type. Optional type can have a value or null similarly,
    // Error union type can hold a value or an error.
    // Error union type can be defined as "error_type!underlying_value_type"
    print("\n", .{});
    var int_or_error: IOError!u8 = writeToFile();

    // So, int_or_error holds either an u8 value or an error. But the writeToFile returns 5
    // so it's holding integer value for now. But we can reassign the value of "int_or_error"
    // like the following:
    int_or_error = IOError.FileNotFound;
    int_or_error = PrintError.ValueIsNull;
    int_or_error = error.FileNotFound;
    // int_or_error = error.AnotherError; // Compile Error: 'AnotherError' is not a member of 'IOError'
    print("int_or_error: {!}\n", .{int_or_error}); // "{!}" is needed while printing error unions
    int_or_error = 10;
    print("int_or_error: {!} \n", .{int_or_error}); // "{!}" is needed

    // But one very important note, the values of error union can't be discarded
    // like other variables using '_' in other word error union's value can't be discarded at all.

    // How should we check if an error union holds an error or a value
    // One Way to check this:
    if (int_or_error) |val| {
        // 'if' portion will execute if variable does not hold an error
        _ = val;
    } else |err_val| {
        // 'else' portion will execute if variable holds an error
        print("int_or_error contains error: {} \n", .{err_val});
    }

    // If we're interested in non error value of an error union,
    // There are 2 ways to extract that value
    // 1 way: Default error unwrap. Syntax: variable_name catch default_value.
    // E.g. "int_or_error catch 10"
    int_or_error = IOError.FileNotFound;
    print("int_or_error default unwrap value: {} \n", .{int_or_error catch 5}); // Since we're not printing an error union "{!}" not needed
    // we're printing value of the error union or the default value

    // 2 way: Error unwrap with 'try' keyword
    int_or_error = 0;
    var unwrapped_val = try int_or_error;
    _ = &unwrapped_val;
    // print("unwrapped_val error union value: {} \n", .{unwrapped_val});
    // for "try int_or_error" If the error union doesn't hold an error then the value would be returned -
    // but if the error union holds an error then the function would be terminated and the error would be returned.
    // In other word, 'try' key word method is equivalent to the following if/else:
    // unwrapped_val = if (int_or_error) |val| {
    //     // 'if' portion will execute if variable does not hold an error
    //     _ = val;
    // } else |err_val| {
    //     // 'else' portion will execute if variable holds an error
    //     print("int_or_error contains error: {} \n", .{err_val});
    // };

    // In zig, we have a type that's a superset of all error sets.
    // All error sets can be coerced to it, that type is called: anyerror
    print("\n", .{});
    logError(IOError.FileNotFound);
    logError(PrintError.ValueIsNull);
    logError(error.SomeError);
    // logError(int_or_error); // anyerror and error union are not same. This line will cause error. "anyerror" is applied to error types only not error union.
}

fn writeToFile() IOError!u8 { // IOError!u8 can be inferred like !u8
    // while returning an error union from an function, we can mention
    // the error union like '!underlying_value_type' instead of "error_type!underlying_value_type",
    // Example: !u8 instead of IOError!u8 and this is valid for only function return type.
    // So, "fn writeToFile() !u8 {}" is also valid.
    return 5;
}

fn logError(err: anyerror) void {
    print("Error: {} \n", .{err});
}

// Note:
//     - Now Zig does not allow any discarding of error values. They must be addressed.
//     - The "main()" can have one of the following return types:
//     - void, !void, u8, !u8
