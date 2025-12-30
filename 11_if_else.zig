//! If/else

const print = @import("std").debug.print;

pub fn main() void {
    print("Condition: Boolean expression \n", .{});
    const num1 = 5;
    if (num1 == 5) {
        print("Variable num1 equals 5 \n", .{});
    } else if (num1 > 0) {
        print("num1 is positive \n", .{});
    } else {
        print("num1 is negative \n", .{});
    }

    print("\n", .{});
    print("Condition: optional variable \n", .{});
    var optional_var1: ?u8 = null;
    var optional_var2: ?u8 = 0;
    _ = &optional_var1;
    _ = &optional_var2;

    // Syntax of unwrapping values of optional variables: if (condition) |a_new_variable_to_catch_unwrapped_value| {}
    // a_new_variable_to_catch_unwrapped_value it should be a distinct name.
    // if you don't want to use the unwrapped value then the syntax is: if (condition) |_| {}
    // '_' to throw the unwrapped value.

    if (optional_var1) |unwrapped_val| { // unwrapped_val is constant(const)
        print("the value of optional_var1 is: {} \n", .{unwrapped_val});
    } else if (optional_var2) |*unwrapped_val| { // if you want to modify the unwrapped_val then use a pointer
        unwrapped_val.* += 1; // to unwrap the value of a pointer use '.*' operator
        print("the value of optional_var2 is: {} \n", .{unwrapped_val.*}); // to print the value of a pointer use '.*' operator
    } else {
        print("Both optional variables are null \n", .{});
    }

    // the use of _ while unwrapping conditional variables
    if (optional_var1) |_| { // throwing away the unwrapped value by using '_'
        print("the value of optional_var1 is not null \n", .{});
    }

    print("optional_var2 outside of if expression {?} \n", .{optional_var2});

    print("\n", .{});
    // Condition: Error union
    print("Condition: Error union variable \n", .{});
    // Error union is like conditional variable. Conditional variable holds a value of some type or a null value.
    // Same way, error union holds a value of some type or an error value.
    var error_union: anyerror!u8 = error.SomeError;
    _ = &error_union;
    // If error_union holds a value only then if condition executes.
    // If the value holded by the error_union is an error then else part gets executed.
    // For error union else part is mandatory(It's not optional like conditional variables).
    // In the else part we need to evaluate the error.
    if (error_union) |unwrapped_error| { // like condition variables, error unions must be unwrapped to get the value
        print("The value of error-union: {} \n", .{unwrapped_error});
    } else |error_val| {
        print("Error union holds an error: {} \n", .{error_val});
    }

    print("\n", .{});
    print("Condition: Mixed \n", .{});
    // For conditional varable and error union the value must be captured even if it gets ignored
    if (num1 == 3) {
        print("num1 equals 3 \n", .{});
    } else if (optional_var1) |_| { // the value must be captured even if it gets ignored
        print("optional_var1 is not null", .{});
    } else if (error_union) |_| { // the value must be captured even if it gets ignored
        print("error_union does not hold an error", .{});
    } else |_| { // else part is a must for error union
        print("error_union holds an error", .{});
    }

    print("\n", .{});
    print("If Expression \n", .{});
    // Syntax for naming the if else. Like blocks we can name them and return value from it
    // and also save "if/else" block to a variable. The syntax is same as blocks.
    // if (optional_var1) |_| if_branch: {
    //     break :if_branch 5;
    // } else 10;
    const if_value: u8 = if (optional_var1) |_| if_branch: {
        break :if_branch 5;
    } else 10; // Since optional_var1 is null if block will not execute, it will return the value from else block
    print("if_value: {} \n", .{if_value});

    const if_value2: u8 = if (optional_var1) |_| if_branch: {
        break :if_branch 5;
    } else if (optional_var2) |_| 7 else 10; // Here we're returning 7 from else if block.
    print("if_value2: {} \n", .{if_value2});
}
