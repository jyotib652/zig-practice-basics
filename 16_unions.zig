//! Unions

const print = @import("std").debug.print;

// A union can have one active value at a time.
// Here, SimpleUnion has two fields but one of them can be active at a time.
// In other word, only one of the field can have value at a time. If you want to
// change the active field, you need to reassign the union as long as the union
// is mutable
const SimpleUnion = union { integer: u8, boolean: bool };

// A tagged union has an underlying enum which is used to define what
// fields the union can have. And a tag to denote which field is active
// So A tagged union has two things: an enum and a tag.
const DataTypes = enum { integer, float, boolean };
// const TaggedUnion = union(DataTypes) { integer: u8, float: f16, boolean: bool }; // A tagged union
// can have only those data type which are defined by it's underlying enum
// and only that many fileds no more no less. The enum has three fields so
// the tagged union also has those 3 fields. But the types of data is up to
// us to determine, for integer fields we can choose any of the valid integer
// types like: u2, u4, u8, i8, i16 and so on...

const TaggedUnion = union(DataTypes) {
    integer: u8,
    float: f16,
    boolean: bool,

    const num_of_fields: u8 = 3;
    fn display(this: TaggedUnion) void {
        print("{} \n", .{this});
    }
};

// We don't need to use already existing enums for tagged union,
// we can infer the enum
const InferredTaggedUnion = union(enum) { field1: u8, field2: f16 }; // Here we're not using any existing enum. The enum is inferred

// A union and a tagged union can have functions and variables just like a enum & struct. The same rules apply

pub fn main() void {
    var simple_union: SimpleUnion = SimpleUnion{ .integer = 5 }; // you can define only one field at a time, not more.
    // // A union can have only one field assigned
    // _ = &simple_union;
    // print("simple_union: {}\n", .{simple_union});
    // print("simple_union: {}\n", .{simple_union.integer}); // You have to call the active field of the union
    // // Calling the inactive field of union will result in error
    // // There is no way to determine the active field programmatically

    // Now changing the active field of the union
    simple_union = SimpleUnion{ .boolean = false };
    print("simple_union: {}\n", .{simple_union.boolean});

    // Tagged union. Even if we assign values for the all the fields for
    // a tagged union during printing the tagged union only shows the active value by default
    var tagged_union: TaggedUnion = TaggedUnion{ .float = 3.14 };
    tagged_union = TaggedUnion{ .integer = 0 };
    print("tagged_union: {} \n", .{tagged_union}); // So the active field is integer for now
    print("simple_union: {}\n", .{simple_union}); // but simple union does not show any value

    print("typeInfo of u8: {} \n", .{@typeInfo(u8)}); // return of @typeInfo is actually a tagged union

    print("number of fields in TaggedUnion: {} \n", .{TaggedUnion.num_of_fields});
    tagged_union.display(); // Showing the active field for this tagged union
}
