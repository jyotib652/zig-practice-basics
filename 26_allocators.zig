//! Allocators

const print = @import("std").debug.print;
// Allocator resides in standard library. Inside standard library there is "mem"
// namespace and allocator resides in this mem namespace
const Allocator = @import("std").mem.Allocator;
const GeneralPurposeAllocator = @import("std").heap.GeneralPurposeAllocator; // it's in 'heap' namespace

const LinkedListNode = struct {
    value: u8,
    next: ?*LinkedListNode = null,

    // fn push(this: *LinkedListNode, new_val: u8) void {
    //     var next_node = LinkedListNode{ .value = new_val };
    //     this.next = &next_node;
    // }

    // new push function with an allocator
    fn push(this: *LinkedListNode, new_val: u8, allocator: Allocator) !void {
        // allocate memory for LikedListNode
        const next_node: *LinkedListNode = try allocator.create(LinkedListNode); // ceate takes 'type' type as an argument and will return a single item pointer to
        // that type which is safe to use within the function and to return it from the function.
        // Return type from create is an error union, so we have to 'try' to catch it and return type
        // of push function also needs to change from "void" to error union type "!void".

        // now free up the allocated memory using destroy function. We should defer the destroy function.
        // if the destruction of memory returns an error we need to handle that case also and we can
        // do that by using errdefer. If we don't handle the err returned by the destroy function,
        // we would have a memory leak.
        errdefer allocator.destroy(next_node); // destroy function takes a pointer as argument

        // now that we have create a pointer, we need to populate it with a value
        next_node.* = LinkedListNode{ .value = new_val };
        // once it is done, we can simply assign this pointer to next property
        this.next = next_node;
    }
};

pub fn main() !void { // since push function return type is an error union now
    // // pub fn main() void {
    // // V.V.I: Once a function returns; variables declared inside the function get discarded
    // // and any pointers to those variables in the function become invalid references. It is
    // // invalid to return a pointer by a function or use a pointer created inside a function
    // // to modify some value outside of the function
    // var head_node = LinkedListNode{ .value = 10 };
    // head_node.push(13);
    // print("value of head node: {} \n", .{head_node.value});
    // print("value of next node: {} \n", .{head_node.next.?.value}); // it produces junk value because
    // // we are setting the value of a variable(var next_node) using a pointer(&next_node) inside a function(push())
    // // both the variable and pointer are inside a function. When the function goes out of scope or exits
    // // the variable is discarded and the pointer to this variable becomes invalid.
    // // Here, we're modifying the value of head_node which is outside of this function that's
    // // why the above line produces garbage value.
    // // When you need to use a pointer inside a function or return a pointer from a function,
    // // we should use "allocators"

    //
    //

    // creating a General purpose allocator instance. we can create it like a function.
    // it takes config struct as an argument but we can also leave it blank that will set it to default values.
    // Example: var gpa = GeneralPurposeAllocator(.{});
    // General purpose allocator returns a type(struct) and to create an instance of this struct,
    // simply use {} just like we would do with any other struct.
    // Example: var gpa = GeneralPurposeAllocator(.{}){};
    var gpa = GeneralPurposeAllocator(.{}){};

    // now that an allocator is created we have to defer it's destruction. we can do it by using deinit function
    // destroying the instance of allocator gpa by using "defer gpa.deinit();" . deinit returns an enum that tells us whether there is a memory leak or not.
    // but for this example we don't care what it returns so we can ignore it by assigning it to _
    defer _ = gpa.deinit();

    // now we have to create a generic allocator from General purpose allocator which is our push
    // function expects
    const allocator: Allocator = gpa.allocator();

    var head_node = LinkedListNode{ .value = 10 };
    try head_node.push(13, allocator); // since push function return type is an error union now
    // now we have to destroy the memory allocated to the node which is next node. Otherwise it would cause error(memory leak error).
    defer allocator.destroy(head_node.next.?); // unwrapping optional value of next
    print("value of head node: {} \n", .{head_node.value});
    print("value of next node: {} \n", .{head_node.next.?.value}); // unwrapping optional value of next

    // Besides create, Allocator has also alloc function. alloc would create a slice
    print("\n", .{});
    var slice1 = try createSlice(3, 1, 4, allocator);

    // For single item pointer's we use destroy function to free up the memory used by the allocator
    // But for slices we use free function
    defer allocator.free(slice1); // free takes anytype as argument
    print("slice1: {any} \n", .{slice1});
    slice1[0] = 10;
    print("slice1: {any} \n", .{slice1});
}

// createSlice takes 3 number and an allocator and returns an error union and it's underlying data is a slice
fn createSlice(num1: u8, num2: u8, num3: u8, allocator: Allocator) ![]u8 {
    // alloc takes 2 arguments; first one is our type of slice second one is length of our slice.
    // And returns an error union
    var output: []u8 = try allocator.alloc(u8, 3);
    output[0] = num1;
    output[1] = num2;
    output[2] = num3;

    return output;
}

// Allocators:
// allocators allocate memory address. This memory address can be used inside of a function
// and can be safely returned from it. When allocating memory such a way, it is our
// responsibiity to free up that memory before program terminates. In order to do this,
// the functions that allocate memory need to receive an allocator as an argument
