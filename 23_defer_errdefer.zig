//! defer and errdefer

const print = @import("std").debug.print;

pub fn main() !void { // using !void due to the requirement for the line "try err_union"
    // defer is used to execute expressions at scope exit
    // print("Goodbye \n", .{}); // Explanation: check line no. 26

    // For multiple defer statements, they're executed in reverse order
    print("\n", .{});
    defer print("Goodbye \n", .{});
    errdefer print("Program crashed \n", .{});
    defer print("Preparing to shut down ...\n", .{});
    print("Start \n", .{});

    print("Main function body1 \n", .{});

    errdefer print("Program crashed \n", .{}); // Explanation: check line no. 68
    // let's move this up with other defer statements

    // Let's enforce an error in the middle of the function(main())
    const err_union: anyerror!u8 = error.SomeError;
    // try is used for error union type only
    try err_union; // this line will terminate the function with an error

    // Goodbye message will not be printed if we don't use defer.
    // This is the significance of defer, even if the function
    // or program terminates due to an error defer would allow
    // you to print.
    // Note: if you don't use defer none of the print statements
    // that comes before the 'try err-union' line will not be printed
    // because of sudden termination of the program for the error.
    // but when you'll attach defer keyword with any of the print
    // statement(that comes before 'try err_union' line)
    // then all the print statements before the 'try err_union' will
    // get printed.
    // What happens if you attach defer keyword to a print statement that comes
    // after the line `try err_union`. In that scenario the program would
    // terminate (because of the 'try err_union' line)
    // before it gets a chance to reach that defer keyword.

    // More practical and common usecase for defer is to free up resources
    // before the program terminates or to close some open connections.
    // another limitation of defer is: you can not return anything from defer.
    // Using defer inside a block
    print("\n", .{});
    {
        defer print("deferred expression inside of block \n", .{});
        print("block body 1 \n", .{});
        print("block body 2 \n", .{});
    }
    print("\n", .{});

    // another example of scope is within loop's body: another
    // example of defer inside a block
    var counter: u8 = 0;
    while (counter < 3) : (counter += 1) {
        defer print("while loop iteration completed \n", .{});
        print("while loop iteration: {} \n", .{counter});
    }

    print("\n", .{});

    // Beside defer we have error defer. Error defer is like defer
    // but it is executed only when the current scope exits with an error
    print("\n", .{});

    // errdefer print("Program crashed \n", .{}); // It didn't print because current scope didn't exit with an error
    // // Now if we move this line up, above where we're throwing an error, it will print.
    // // like, if we move it up, above the lines:
    // // const err_union: anyerror!u8 = error.SomeError;
    // // try err_union;
    // // it will work

    // defer print("Goodbye \n", .{});
    print("Main function body2  \n", .{});
}
