//! Struct

const print = @import("std").debug.print;

// A struct for a 3d point.
// A struct is a collectionof fields. Technically, a signed integer or a
// float type would work better for a 3d point but we're using an unsigned
// integer to keep it simple.
// const Point = struct { x: u8, y: u8, z: u8 };
// const Point = struct { x: u8, y: u8, z: u8 = 0 };
// const Point = struct {
//     x: u8,
//     y: u8,
//     z: u8 = 0,
//     const no_of_dimensions = 3; // Declaring a variable within the struct
// };

// const Point = struct {
//     x: u8,
//     y: u8,
//     z: u8 = 0,
//     const no_of_dimensions = 3; // Declaring a variable within the struct

//     fn init(x: u8, y: u8, z: u8) Point { // A function as a member of the struct
//         return Point{ .x = x, .y = y, .z = z };
//     }
// };

// const Point = struct {
//     x: u8,
//     y: u8,
//     z: u8 = 0,
//     const no_of_dimensions = 3; // Declaring a const variable(not mutable) within the struct
//     var num_of_points_created: u8 = 0; // Declaring a mutable variable.

//     fn init(x: u8, y: u8, z: u8) Point { // A function as a member of the struct
//         num_of_points_created += 1;
//         return Point{ .x = x, .y = y, .z = z };
//     }
// };

// const Point = struct {
//     x: u8,
//     y: u8,
//     z: u8 = 0,
//     const no_of_dimensions = 3; // Declaring a const variable(not mutable) within the struct
//     var num_of_points_created: u8 = 0; // Declaring a mutable variable.

//     fn init(x: u8, y: u8, z: u8) Point { // A function as a member of the struct
//         num_of_points_created += 1;
//         return Point{ .x = x, .y = y, .z = z };
//     }

//     fn printPoint(this: Point) void {
//         print("Point: {} \n", .{this});
//     }
// };

const Point = struct {
    x: u8,
    y: u8,
    z: u8 = 0,
    const no_of_dimensions = 3; // Declaring a const variable(not mutable) within the struct
    var num_of_points_created: u8 = 0; // Declaring a mutable variable.

    fn init(x: u8, y: u8, z: u8) Point { // A function as a member of the struct
        num_of_points_created += 1;
        return Point{ .x = x, .y = y, .z = z };
    }

    fn printPoint(this: Point) void {
        print("Point: ({}, {}, {}) \n", .{ this.x, this.y, this.z });
    }

    fn increment(this: *Point) void { // remember, function parameters are immutable. If you need to modify this parameter then make it a pointer
        this.x += 1;
        this.y += 1;
        this.z += 1;
    }
};

pub fn main() void {
    print("type of Point: {} \n", .{@TypeOf(Point)});
    const origin: Point = Point{ .x = 0, .y = 0, .z = 0 }; // while assigning values each field starts with a '.'
    // print("origin: {} \n", .{origin});
    origin.printPoint();
    // We can mutate these fields like the following as long as the struct is mutable.
    // origin.x = 10;
    // origin.y = 15;
    // origin.z = 20;
    // While instantiating a struct we must provide value to the every field
    // otherwise it would cause an error. We can avoid this by providing a defualt
    // value to a field/fields. E.g. const Point = struct { x: u8, y: u8, z: u8 = 0 };
    // Here the default value for the field z is 0 so while instantiating this Point struct
    // we don't need to provide value for z field like: const origin: Point = Point{ .x = 0, .y = 0};
    const point1: Point = Point{ .x = 3, .y = 2, .z = 7 }; // Here, we're overriding the default value of z
    // print("point1: {} \n", .{point1});
    // point1.printPoint();
    Point.printPoint(point1);
    // A struct literal can be declared using .{.field1= a, .field2= b} format as long as the field name and struct type match.
    const point2: Point = .{ .x = 2, .y = 2, .z = 2 };
    // print("point2: {} \n", .{point2});
    // point2.printPoint();
    Point.printPoint(point2);

    print("num_of_dimensions of Point: {} \n", .{Point.no_of_dimensions});
    // const point3: Point = Point.init(3, 3, 3);
    var point3: Point = Point.init(3, 3, 3);
    // print("point3: {} \n", .{point3});
    // point3.printPoint();
    Point.printPoint(point3); // point3.printPoint(); and Point.printPoint(point3); both are same

    print("\n", .{});
    print("num of points created so far: {} \n", .{Point.num_of_points_created});

    // Now calling this increment function
    point3.increment(); // This will error out as we're passing Point instance as a pointer parameter to the increment function
    // but when we created the instance we made it a constant, so we need to make it a var.
    // we need to change, const point3: Point = Point.init(3, 3, 3); to var point3: Point = Point.init(3, 3, 3);

    print("Point3: \n", .{});
    point3.printPoint();
    point3.increment();
    point3.printPoint();

    print("\n", .{});
    const tuple1 = .{ 2, 5, true, "ABC" }; // This is a tuple. Tuples are 0 indexed like arrays
    print("tuple1: {} \n", .{tuple1});
    print("value at index 0: {} \n", .{tuple1[0]});
    print("value at index 0: {} \n", .{tuple1.@"0"}); // using '.' notation to access tuple values. Here, "0" is the index number
    // One caveat here. While using '.' notation the index value needs to be compile time known.

    print("number of elements in tuple1: {} \n", .{tuple1.len});
    print("type of tuple1: {} \n", .{@TypeOf(tuple1)});
    // If we need to modify the values of tuple then we have to instantiate the tuple as
    // variable not const in other word the tuple itself has to be mutable. Apart
    // from that member of the tuple has also to be mutable otherwise we can't
    // change the values of these members of the tuple. If it's comptime known value
    // (like comptime comptime_int, comptime bool, comptime *const []u8 etc.) for a member
    // then we can't modify/reassign this value of the member because it's const and we have make it var.
    // So the tuple itself has to be mutable and it's element needs to be mutable to modify the
    // value of an element
    var num5: u8 = 5;
    _ = &num5;
    var tuple2 = .{ 2, num5, true, "ABC" };
    tuple2[1] = 10;
    print("\n", .{});
    print("type of tuple2: {} \n", .{@TypeOf(tuple2)});
    print("after reassignment tuple2: {} \n", .{tuple2});

    const tuple3 = .{ 1, false };
    const tuple4 = tuple1 ++ tuple3; // concatenating two tuples
    print("tuple4: {} with length: {} \n", .{ tuple4, tuple4.len });

    const tuple5 = tuple3 ** 3; // multiplying a tuple. It just repeats the elements
    print("tuple5: {} with length: {} \n", .{ tuple5, tuple5.len });
}

// // Note:
// Fields:
//     - Belongs to a instance of a struct
//     - Mutable if the struct instance is mutable
// Variables:
//     - Belong to the struct(type)
//     - Shared between struct instances (static)
//     - Mutable if the variable itself mutable
