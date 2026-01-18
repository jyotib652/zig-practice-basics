//! Pointers

const print = @import("std").debug.print;

pub fn main() void {
    var number1: u8 = 153;
    const number1_ptr: *u8 = &number1; // pointer to number1 -
    // this holds a numeric address to the location in memory where number1 value is stored
    const number1_ptr_address: usize = @intFromPtr(number1_ptr);

    print("number1: {} \n", .{number1});
    print("number1_ptr unwrapped: {} \n", .{number1_ptr.*}); // extracting the value of a pointer or unwrapping a pointer
    print("address of number1 pointer: {} \n", .{number1_ptr_address});

    // Why use pointers?
    // 1. passing pointers is more memory efficient than passing copies of data, especially
    // if data is large like: a complex struct
    // 2. you may have a case where a reference to the same variable is held in
    // multiple places and changes made to the variable in one place should be
    // reflected in other places
    // 3. and finally, if you want to have a function that modifies its arguments
    // you can accomplish this only by passing pointers, as in zig function
    // arguments are not mutable

    print("\n", .{});
    incrementNumber(number1_ptr); // or "&number1"
    print("number1: {} \n", .{number1});

    const number2: u8 = 100;
    const number2_ptr = &number2;
    // incrementNumber(number2_ptr);
    print("Type of number1_ptr: {} \n", .{@TypeOf(number1_ptr)}); // it's a pointer to u8 : *u8
    print("Type of number2_ptr: {} \n", .{@TypeOf(number2_ptr)}); // it's a pointer to constant: *const u8
    // so 2 types pointers: constant pointers and mutable pointers

    // A pointer to a mutable variable can be coerced to a pointer to a constant variable but not vice versa
    printPtrAddress(number1_ptr); // although this function expects a constant pointer but it can coerce a variable pointer to a constant pointer
    printPtrAddress(number2_ptr);

    // Until now we have discussed about single item pointer. It points to a single value.
    // A pointer to an array is still a single item pointer.
    // Whenever a single item pointer points to a struct or an array,
    // we do not need to unwrap the pointer to access the struct's fields
    // or array's elements. We can but we don't have to

    print("\n", .{});
    const origin: Point = Point{ .x = 0, .y = 0 };
    const origin_ptr = &origin;
    // we can use "origin_ptr.*.x" to first extract the value of the pointer and then access the field
    // or we can directly access the fields without extracting the pointer's value this way: "origin_ptr.y"
    // but remember to use "origin_ptr.y", origin_ptr has to be a pointer
    print("origin: ({}, {}) \n", .{ origin_ptr.*.x, origin_ptr.y });

    print("\n", .{});
    var arr1 = [6]u8{ 3, 1, 4, 1, 5, 9 };
    const arr2 = [_]u8{ 1, 2, 3 };
    // Syntax of Single item pointers: *[type] and *const[type]
    const many_item_ptr: [*]u8 = &arr1; // many item pointer
    const many_item_ptr2: [*]const u8 = &arr2; // many item pointer
    print("first element of many_item_ptr: {} \n", .{many_item_ptr[0]});
    print("first element of many_item_ptr2: {} \n", .{many_item_ptr2[0]});

    // We can coerce a "single item pointer to an array" to a many item pointer
    // "&arr1" creates a single item pointer to an array but we can coerce it to
    // many item pointer by infering types like u8 in "[*]u8". So u8 in line
    // "const many_item_ptr: [*]u8 = &arr1;" coerced &array1 to a many item pointer.
    // many item pointers can be indexed and sliced and they also support pointer
    // arithmatic. many item pointer has an unknown length so to get an element from
    // a many item array use index notation just like an array: many_item_ptr[0], many_item_ptr2[0]
    // Since the length of a "many item array" is not known we can easily get an element which
    // is outside the bounds of the array but doing so will produce nonsense data that is not useful
    print("tenth element of many_item_ptr: {} \n", .{many_item_ptr[10]}); // this produces junk value and compiler doesn't complain so be careful of this situation

    // Just like with single item pointers if many item pointers points to a mutable variable
    // then we can change the underlying value by using index notation
    many_item_ptr[0] = 10;
    // changing an element outside the bounds of many item pointer
    many_item_ptr[10] = 2;
    print("\n", .{});
    print("first element of many_item_pointer: {} \n", .{many_item_ptr[0]});
    print("tenth element of many_item_pointer: {} \n", .{many_item_ptr[10]}); // this is dangerous behaviour

    // V.V.I: Once a function returns variables declared inside the function gets discarded
    // and any pointers to those variables in the function become invalid references. It is
    // invalid to return a pointer by a function or use a pointer created inside a function
    // to modify some value outside of the function
    var head_node = LinkedListNode{ .value = 0 };
    head_node.push(5);
    print("value of head node: {} \n", .{head_node.value});
    print("value of next node: {} \n", .{head_node.next.?.value}); // it produces junk value because
    // we are setting the value of a variable(var next_node) using a pointer(&next_node) inside a function(push())
    // both the variable and pointer are inside a function. When the function goes out of scope or exits
    // the variable is discarded and the pointer to this variable becomes invalid.
    // Here, we're modifying the value of head_node which is outside of this function that's
    // why the above line produces garbage value.
    // When you need to use a pointer inside a function or return a pointer from a function,
    // we use "allocators"
}

// fn incrementNumber(input: u8) void { // it would crash because we're passing input as value and values passed to function are constants.
//     // in order to fix this, we need to turn the input as pointer
//     input += 1;
// }

fn incrementNumber(input: *u8) void {
    // before incrementing the pointer, we need to unwrap it first
    input.* += 1; // we can modify the pointer this way only when it's a mutable variable, in this case it's a var so it works
}

fn printPtrAddress(ptr: *const u8) void { // Here, it doesn't matter if it's a constant pointer or variable(mutable) pointer
    // as we aren't modifying/mutating the value of pointer.
    print("The memory address is: {} \n", .{@intFromPtr(ptr)});
}

const Point = struct { x: u8, y: u8 };

// The proper push function would iterate over the Linked List
// to find the last node, before inserting a new node. This is
// a simplified version for the sake of an example
const LinkedListNode = struct {
    value: u8,
    next: ?*LinkedListNode = null,

    fn push(this: *LinkedListNode, new_val: u8) void {
        var next_node = LinkedListNode{ .value = new_val };
        this.next = &next_node;
    }
};
