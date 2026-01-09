//! While Loop

const print = @import("std").debug.print;

const Errors = error{ Error1, Error2 };

pub fn main() void {
    var i: u8 = 0;
    // While Loop: Syntax 1
    // while (i < 10) { // This condition can be a boolean expression, an optional variable or an error union
    //     print("iteration number {} \n", .{i});
    //     i += 1;
    // }

    // While Loop: Syntax 2. Syntax 1 & 2 both are same and do the same thing.
    while (i < 10) : (i += 1) { // ":(i+=1)" is called continue expression, it executes after the body
        print("iteration number {} \n", .{i});
    }

    // Infinite Loop
    // while (true) {
    //     print("Infinite loop \n", .{});
    // }

    // Terminationg the infinite loop with break keyword
    var j: u8 = 0;
    while (true) {
        print("iteration number(j): {} \n", .{j});
        j += 1;
        if (j == 10) {
            break;
        }
    }

    print("\n", .{});
    // Nested Loops. This will not stop the outer loop
    var outer_counter: u8 = 0;
    while (outer_counter < 5) : (outer_counter += 1) {
        print("Nested loops, outer counter: {} \n", .{outer_counter});
        var inner_counter: u8 = 0;
        while (inner_counter < 3) : (inner_counter += 1) {
            print("Nested loops, inner counter: {} \n", .{inner_counter});
            if (outer_counter == 3 and inner_counter == 1) {
                break;
            }
        }
    }

    print("\n", .{});
    // But if you want to stop the outer loop as well along with the inner loop,
    // you have to put the label of outer loop after the break keyword like this:
    outer_counter = 0;
    outer: while (outer_counter < 5) : (outer_counter += 1) {
        print("Nested loops, outer counter: {} \n", .{outer_counter});
        var inner_counter: u8 = 0;
        while (inner_counter < 3) : (inner_counter += 1) {
            print("Nested loops, inner counter: {} \n", .{inner_counter});
            if (outer_counter == 3 and inner_counter == 1) {
                break :outer;
            }
        }
    }

    print("\n", .{});
    // Using continue keyword
    outer_counter = 0;
    outer: while (outer_counter < 5) : (outer_counter += 1) {
        if (outer_counter == 2) continue;
        // continue keyword can also be used with loop's label like this:
        // if (outer_counter == 2) continue :outer;

        print("Nested loops, outer counter: {} \n", .{outer_counter});
        var inner_counter: u8 = 0;
        while (inner_counter < 3) : (inner_counter += 1) {
            print("Nested loops, inner counter: {} \n", .{inner_counter});
            if (outer_counter == 3 and inner_counter == 1) {
                break :outer;
            }
        }
    }

    print("\n", .{});
    // While loop can also have a else block. Else block will be executed
    // when loop's condition is false. The following is a very simple example:
    var counter: u8 = 0;
    while (counter < 5) : (counter += 1) {
        print("Iteration number: {} \n", .{counter});
    } else {
        print("Done \n", .{});
    }

    print("\n", .{});
    // Break keyword will stop the loop, even the else portion
    counter = 0;
    while (counter < 5) : (counter += 1) {
        print("Iteration number: {} \n", .{counter});
        if (counter == 3) break;
    } else {
        print("Done \n", .{});
    }

    print("\n", .{});
    // We can return values from while and else block
    // But for returning we need to label the returning block like this:
    counter = 0;
    const while_val: u8 = while (counter < 5) : (counter += 1) {
        print("Iteration number: {} \n", .{counter});
        // if (counter == 3) break;
    } else else_block: {
        print("Done \n", .{});
        break :else_block 5;
    };
    print("value returned by a loop: {} \n", .{while_val});

    print("\n", .{});
    // While returning values from loop, you can't use
    // break keyword alone. You have to provide the label for
    // the loop after the break keyword and the returning value
    counter = 0;
    const while_val2: u8 = loop_label: while (counter < 5) : (counter += 1) {
        print("Iteration number: {} \n", .{counter});
        if (counter == 3) break :loop_label 10;
    } else else_block: {
        print("Done \n", .{});
        break :else_block 5;
    };
    print("value returned by a loop: {} \n", .{while_val2});

    // If else block does nothing other than returing a value. The syntax to do
    // this is simply: else returning_value. Like: else 5
    print("\n", .{});
    counter = 0;
    const while_val3: u8 = while (counter < 5) : (counter += 1) {
        print("Iteration number: {} \n", .{counter});
        // if (counter == 3) break;
    } else 5;
    print("value returned by a loop: {} \n", .{while_val3});

    // While loop with optional condition
    print("\n", .{});
    var optional: ?u8 = 0;
    while (optional) |*unwrapped_val| : (unwrapped_val.* += 1) { //Since we're modifying unwrapped_val that's why we have to use pointer
        print("unwrapped_val: {} \n", .{unwrapped_val.*});
        if (unwrapped_val.* == 3) {
            optional = null;
        }
    } else {
        print("Optional loop has terminated \n", .{});
    }

    // While loop with error union
    print("\n", .{});
    var err_union: anyerror!u8 = 0;
    while (err_union) |*unwrapped_val| : (unwrapped_val.* += 1) { // For error union, you must capture the value from error union in the while block
        print("unwrapped value: {} \n", .{unwrapped_val.*});
        if (unwrapped_val.* == 3) {
            err_union = error.SomeError;
        }
    } else |err_val| { // For error union, you must capture the error from the error union in else block
        print("This loop has reached an error: {} \n", .{err_val});
    }
}
