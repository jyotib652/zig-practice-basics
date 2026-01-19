//! Slices

const print = @import("std").debug.print;

pub fn main() void {
    // Slice is a "many item pointer" that has a length.
    // We get a slice by slicing an array.
    // In Zig, the difference between subarray and slice comes down to
    // whether the indices used for slicing are known at compile-time or runtime.
    var arr1 = [6]u8{ 3, 1, 4, 1, 5, 9 };
    const subarray = arr1[0..2];
    print("type of array1: {} \n", .{@TypeOf(arr1)});
    print("type of subarray: {} \n", .{@TypeOf(subarray)});
    // Because the indices (0..2) are known at compile-time, 'subarray' is a
    // "pointer to an array" (*[2]u8), not a slice. The length is part of the type.

    var runtime_zero: u8 = 0;
    _ = &runtime_zero;
    const slice = arr1[runtime_zero..2];
    // Because the indices involve a runtime variable, 'slice' becomes a true "slice" ([]u8).
    // It stores the pointer and the length at runtime.
    print("type of slice: {} \n", .{@TypeOf(slice)});
    print("slice: {any} \n", .{slice});

    // More Explanation: subarray
    // Indices: 0 and 2 are compile-time constants (comptime integers).
    // Result: Because the compiler knows the exact size of the resulting view at compile-time,
    // it generates a pointer to an array (*[2]u8).
    // Why: This is more efficient than a slice. The length (2) is encoded directly in the type itself,
    // so the program doesn't need to store the length in memory at runtime.
    // It is strictly a single pointer to the memory address of arr1[0].
    //
    // slice:
    // Indices: runtime_zero is a variable (runtime value).
    // Result: The compiler cannot determine the length or starting position strictly at compile-time. Therefore, it generates a slice ([]u8).
    // Why: A slice is a "fat pointer" or a struct containing two fields:
    // ptr: A pointer to the data ([*]u8).
    // len: The length of the slice (usize), stored at runtime.

    print("\n", .{});
    const slice2: []u8 = arr1[runtime_zero..2];
    print("type of slice: {} \n", .{@TypeOf(slice2)});
    print("slice2: {any} \n", .{slice2});
    print("length of slice2: {any} \n", .{slice2.len});
    // Slice has two properties len(length) and ptr(pointer).
    // Example: slice2.len & slice2.ptr

    print("\n", .{});
    print("first element of slice: {} \n", .{slice2[0]});
    // print("fifth element of slice: {} \n", .{slice2[5]}); // unlike many item pointers, the length of slice is known -
    // // although slice itself is a "many item pointer"

    slice2[0] = 10;
    // Wait, slice2 is a const, how can we modify it?
    // "const slice2" means the slice structure (ptr and len) is constant and cannot be reassigned.
    // However, the data it points to is "u8" (mutable), not "const u8".
    // To make the data immutable, the type would need to be "[]const u8".
    print("first element of slice: {} \n", .{slice2[0]});

    // Iterating over slice
    for (slice2) |slice_element| {
        print("sliece2 elements: {} \n", .{slice_element});
    }
}

// Explanation:
// In Zig, the const keyword on a slice variable applies to the slice structure itself (the pointer and the length), not the data it points to.
// Here is the breakdown:

// const slice2: You cannot reassign slice2 to point to a different array or change its length property. The "fat pointer" (address + length) is constant.
// []u8: The type of the slice indicates it points to mutable u8 data. Because the underlying type is u8 (and not const u8), you are allowed to modify the elements.
// If you wanted to prevent modification of the elements, the type would need to be []const u8.
