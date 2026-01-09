//! For Loop

const print = @import("std").debug.print;

pub fn main() void {
    const array1: [5]u8 = [_]u8{ 1, 2, 3, 4, 5 };
    for (array1) |array1_item| { // For iteration over arrays for loop is preferred
        print("element of array1: {} \n", .{array1_item});
    }

    // Iterating over a range of consecutive integers. Range is denoted by two dots like: ".."
    // 0..5 => the range is 0 to 5 but the lower bound 0 is inclusive but
    // the upper bound 5 is not
    print("\n", .{});
    for (0..5) |i| {
        print("element of the range: {} \n", .{i});
    }

    // We can iterate over more than one array at the same time
    print("\n", .{});
    const array2: [5]u8 = [_]u8{ 10, 9, 8, 6, 7 };
    for (array1, array2) |array1_item, array2_item| {
        print("array1_item: {}, array2_item: {} \n", .{ array1_item, array2_item });
    }

    // We can also include an range and an array while iterating but
    // remember the range must be the same length as the array
    print("\n", .{});
    for (array2, 0..5) |array1_item, range_item| {
        print("array1_item: {}, range_item: {} \n", .{ array1_item, range_item });
    }

    // In case of range like "0..5" while combining with an array
    // we can omit the upper bound of the range and this will implicitly
    // have the upper bound as the length of the array. E.g. "0.."
    print("\n", .{});
    for (array2, 0..) |array, idx| { // This arrangement is useful when you also want to keep track of the index
        print("element at index {}: {} \n", .{ idx, array });
    }

    // Modifying an array. To modify an array, you have to
    // iterate over a pointer of an array. The pointer to array3
    // would be &array3
    // Then you have to capture the pointer to the elements: *array_item
    // and lastly extract the value of pointers by unwrapping the pointers: array_item.*
    // then modify these values and the array3 itself would be modified
    print("\n", .{});
    var array3: [3]u8 = [_]u8{ 2, 3, 4 };
    _ = &array3;
    for (&array3) |*array_item| {
        array_item.* *= 2;
        print("array_item: {} \n", .{array_item.*});
    }
    print("arra3 after for loop: {any} \n", .{array3});

    // Like while loop, for loop also can be labelled and can have a else branch
    // else branch will execute when we'll reach end of the array
    print("\n", .{});
    for (array1) |array_item| {
        // if (array_item == 4) break; // break would terminate the else block also
        // if (array_item == 3) continue;
        print("array1_item: {} \n", .{array_item});
    } else {
        print("Done iterating over array1 \n", .{});
    }

    print("\n", .{});
    for (array1) |array_item| {
        // if (array_item == 4) break; // break would terminate the else block also
        if (array_item == 5) continue;
        print("array1_item: {} \n", .{array_item});
    } else {
        print("Done iterating over array1 \n", .{});
    }

    // Returniing values from for loop. Also demonstrating use of continue
    print("\n", .{});
    const for_val: u8 = for (array1) |array_item| {
        // if (array_item == 4) break 12;
        if (array_item == 5) continue;
        print("array1_item: {} \n", .{array_item});
    } else else_blk: {
        print("Done iterating over array1 \n", .{});
        break :else_blk 20;
    };
    print("for_val: {} \n", .{for_val}); // 12 -> when iteration reaches end of array then else block executes
    // Although continue doesn't allow execution of else block but
    // at this point compiler/parser comes back to the begining of the logic
    // which is "for (array1) |array_item|" but at this moment compiler is
    // at the end of the array so else block gets executed automatically. As
    // the default behaviour in for loop is:
    // else branch will execute when we'll reach end of the array

    // Like while loop, for loop also can be labelled and it's useful
    // for nested loop scenarios
}
