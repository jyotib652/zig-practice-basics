//! Blocks

const print = @import("std").debug.print;
const pi: f16 = 3.14;

pub fn main() void {
    // A block is denoted by curly braces `{}` and can contain multiple statements.
    // blocks can be named and assigned to a variable. Naming a block is meaningless
    // if you don't assign the block to a variable. Because then you will be able to use the result from the block.
    // Once the block uses an expression and it's value is stored, you need to close that block with a ';'
    const block_output = outer_block: {
        // this is a block
        var x: u8 = 5;
        x += 1;

        // Not allowed: variable pi shadows an outer scope variable pi
        // If you want to use the variable then rename it.
        // const pi = 3.14; // shadowing the outer pi variable

        // blocks can be nested
        x = inner_block: {
            // we can also break the outer block from the inner block
            if (x == 6) {
                break :outer_block 0;
            }
            print("Value of x inside block: {}\n", .{x});
            break :inner_block 9;
        };

        // returning a value from the block. Syntax -> break :block_name the_value_you_want_to_return_from_the_block;
        break :outer_block x;
    };

    print("output of outer_block: {}\n", .{block_output});

    // Not Allowed: trying to referene x from outside the block
    // print("Value of x outside block: {}\n", .{x});

    // blocks can be empty
    const empty_block = {}; // Any block that doesn't return value is of type void
    print("type of empty_block: {} \n", .{@TypeOf(empty_block)});
}
