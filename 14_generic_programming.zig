//! Generic Programming

const print = @import("std").debug.print;

// const Point = struct { x: u8, y: u8, z: u8 };

// type of struct is "type". Whenever we need to provide a type(struct) parameter
// to a function, it must be comptime otherwise the program would not compile.
// And whenever you need to return a struct from a function, you have to return
// "type" as type of struct is "type".

fn Point(comptime T: type) type {
    return struct { x: T, y: T, z: T };
}

// A more common usecase for generic programming is linked list
// Let's implement a simple linked list for the sake of demonstaration
fn LinkedList(comptime T: type) type {
    return struct { data: T, next: ?*@This() = null }; // instead of @This, we can use LinkedList(T) both are same
}

pub fn main() void {
    const U8Point = Point(u8);
    const origin: U8Point = U8Point{ .x = 0, .y = 0, .z = 0 };
    print("origin point: {} \n", .{origin});

    const U8LinkedList = LinkedList(u8);
    var head_node: U8LinkedList = U8LinkedList{ .data = 10 };
    var next_node: U8LinkedList = U8LinkedList{ .data = 15 };
    head_node.next = &next_node;
    print("\n", .{});
    print("head_node: {} \n", .{head_node});
}
