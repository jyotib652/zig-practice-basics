//! Allocators

const print = @import("std").debug.print;

const LinkedListNode = struct {
    value: u8,
    next: ?*LinkedListNode = null,

    fn push(this: *LinkedListNode, new_val: u8) void {
        var next_node = LinkedListNode{ .value = new_val };
        this.next = &next_node;
    }
};

pub fn main() void {
    // V.V.I: Once a function returns; variables declared inside the function get discarded
    // and any pointers to those variables in the function become invalid references. It is
    // invalid to return a pointer by a function or use a pointer created inside a function
    // to modify some value outside of the function
    var head_node = LinkedListNode{ .value = 10 };
    head_node.push(13);
    print("value of head node: {} \n", .{head_node.value});
    print("value of next node: {} \n", .{head_node.next.?.value}); // it produces junk value because
    // we are setting the value of a variable(var next_node) using a pointer(&next_node) inside a function(push())
    // both the variable and pointer are inside a function. When the function goes out of scope or exits
    // the variable is discarded and the pointer to this variable becomes invalid.
    // Here, we're modifying the value of head_node which is outside of this function that's
    // why the above line produces garbage value.
    // When you need to use a pointer inside a function or return a pointer from a function,
    // we should use "allocators"
}
