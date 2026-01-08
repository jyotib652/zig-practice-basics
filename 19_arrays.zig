//! Arrays

const print = @import("std").debug.print;

pub fn main() void {
    // Declaring array
    const array1: [3]u8 = [3]u8{ 90, 73, 71 }; // [3] -> length of the array
    const array2 = [_]f16{ 3.14, 1.618 }; // [_] -> no need to specify the length

    // Another way of declaring an array
    var array3: [3]bool = undefined;
    _ = &array3;
    array3 = [_]bool{ true, true, false };

    print("array1 (any): {any} \n", .{array1}); // to print array "{any}" specifier is a must
    print("array1 (s): {s} \n", .{array1}); // {s} specifier also works for arrays with u8 type. In this case it would print as string. As it would covert u8 values to corresponding ascii characters.
    print("array2 (any): {any} \n", .{array2});
    print("array3 (any): {any} \n", .{array3});

    print("\n", .{});
    print("the length of the array, array1: {} \n", .{array1.len});
    print("first element of array2: {} \n", .{array2[0]});
    // We can change the value of arrays if it's a variable. We can't reassignmodify/change values of a constant array
    array3[2] = true;
    print("array3: {any} \n", .{array3});
    // We can reassign the whole array if it's a variable array
    array3 = [3]bool{ false, false, false };
    print("array3: {any} \n", .{array3});

    // Concatenating arrays of same type using "++". If the elements of 2 arrays aren't same type, cancatenating can't be done
    const merged_array = array1 ++ [_]u8{ 100, 95 };
    print("merged_array: {any} \n", .{merged_array});

    // Repeat an array using "**" operator
    const repeated_array = array1 ** 3;
    print("repeated_array: {any} \n", .{repeated_array});

    // Instantiating an array with a default value
    const new_default_array = [_]bool{false} ** 10; // Here we're instantiating the array with 10 boolean values
    print("new_default_array: {any} \n", .{new_default_array});

    // We can create a multi-dimensional array by nesting another array within an array
    print("\n", .{});
    // 2x3 matrix => 2 rows, 3 columns
    // const matrix_2x3: [2][3]u8 => [2] means matrix_2x3 is an array and it has two elements.
    // now [2][3]u8 means => Each two elements has an u8 array and these u8 arrays contains 3 elements each.
    // So in total 2 u8 arrays containing 3 elements each.
    const matrix_2x3: [2][3]u8 = [_][3]u8{ // compiler can infer the size of the outer array but length of inner array must be specified compiler would not be able to infer that
        [_]u8{ 1, 2, 3 }, // when defining inner arrays we're free to define the size or let the compiler infer it. Here we didn't define the size of inner array
        [3]u8{ 4, 5, 6 }, // Here we defined the size of the inner array
    };
    print("matrix_2x3: {any} \n", .{matrix_2x3});
    print("matrix_2x3  row 0 cell 1 element: {} \n", .{matrix_2x3[0][1]});
    print("matrix_2x3  row 1 cell 2 element: {} \n", .{matrix_2x3[1][2]});

    // Subarray - By slicing an array
    const array4 = [_]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    const array5 = array4[2..7]; // Here, lower bound is index 2 and upper bound is index 7. Lower bound is inclusive but upper bound is not
    print("array5: {any} \n", .{array5});
}
