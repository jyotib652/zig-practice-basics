//! Enums

const print = @import("std").debug.print;

const Direction = enum { up, down, left, right };
// const OrderStatus = enum { new, confirmed, rejected, cancelled, picked_up, delivered };

// tagged enum for providing custom values to the property of enum
const Direction2 = enum(u2) { up, down, left = 2, right };
// Another thing, u2 has 4 values so Direction2 can have at most 4 properties. And their values would be
// 0 to 3. Like up is 0, down is 1, left is 2 and right is 3.
const OrderStatus2 = enum(u3) { new = 1, confirmed, rejected, cancelled, picked_up, delivered }; // So now new = 1,
// confirmed = 2, rejected = 3, cancelled = 4, picked_up = 5 & delivered = 6.
// Another thing, u3 has 8 values so Orderstatus2 can have at most 8 properties.
// And the value of any property must not exceed 8.
const OrderStatus3 = enum(u3) { new, confirmed, rejected = 4, cancelled, picked_up, delivered }; // So now new = 0,
// confirmed = 1, rejected = 4, cancelled = 5, picked_up = 6 & delivered = 7
// Another thing, u3 has 8 values so Orderstatus3 can have at most 8 properties.
// And the value of any property must not exceed 8 otherwise it would be a compile error.

const OrderStatus = enum {
    new,
    confirmed,
    rejected,
    cancelled,
    picked_up,
    delivered,

    fn confirmOrder(this: *OrderStatus) void {
        this.* = .confirmed;
        print("Order confirmed \n", .{});
    }
};

pub fn main() void {
    movePlayerOld(2);
    movePlayer(Direction.down);
    changeOrderStatus(OrderStatus.new);
    changeOrderStatus(.new); // enums can be inferred with a dot
    changeOrderStatus(.delivered); // enums can be inferred with a dot

    // Behind the scene each enum property is assigned a numeric value.
    // Like first property is assigned 0, second 1, third 2 and so on.
    // const Direction = enum { up, down, left, right }; Here, up is 0,
    // down is 1, left is 2 and right is 3.
    print("value of direction up: {} \n", .{@intFromEnum(Direction.up)});

    // We can also assign custom values to enum properties but then we have to
    // provide the underlying type of the enum. E.g.
    // const CustomDirection = enum(u8) { up = 10, down = 20, left = 30, right = 40 }; -- It is called tagged enum.
    print("value of direction up: {} \n", .{@intFromEnum(Direction2.up)});
    print("value of OrderStatus2 new: {} \n", .{@intFromEnum(OrderStatus2.new)});
    print("value of OrderStatus3 new: {} \n", .{@intFromEnum(OrderStatus3.new)});
    print("value of OrderStatus3 rejected: {} \n", .{@intFromEnum(OrderStatus3.rejected)});
    print("value of OrderStatus2 cancelled: {} \n", .{@intFromEnum(OrderStatus3.cancelled)});
    print("value of OrderStatus2 delivered: {} \n", .{@intFromEnum(OrderStatus3.delivered)});

    // If for some reason we need to provide numeric value to the function instead of
    // enum we can do that by using built-in method @enumFromInt
    print("\n", .{});
    movePlayer(@enumFromInt(0)); // which is up

    // enums also can have functions and variables and the same rule for functions in struct
    // applies here for functions in enum.
    var order_status: OrderStatus = .new;
    order_status.confirmOrder();
}

fn movePlayerOld(directions: u2) void { // There are 4 possible directions and u2 has 4 values
    if (directions == 0) {
        print("move up \n", .{});
    } else if (directions == 1) {
        print("move left \n", .{});
    } else if (directions == 2) {
        print("move down \n", .{});
    } else if (directions == 3) {
        print("move right \n", .{});
    }
}

fn movePlayer(directions: Direction) void { // using enum instead of hardcoded values
    if (directions == Direction.up) {
        print("move up \n", .{});
    } else if (directions == Direction.left) {
        print("move left \n", .{});
    } else if (directions == Direction.down) {
        print("move down \n", .{});
    } else if (directions == Direction.right) {
        print("move right \n", .{});
    }
}

fn changeOrderStatusOld(status: u3) void { // u3 has 8 values
    if (status == 0) {
        print("Order status: New \n", .{});
    } else if (status == 1) {
        print("Order status: Confirmed \n", .{});
    } else if (status == 2) {
        print("Order status: Rejected \n", .{});
    } else if (status == 3) {
        print("Order status: Cancelled \n", .{});
    } else if (status == 4) {
        print("Order status: Picked up \n", .{});
    } else if (status == 5) {
        print("Order status: Delivered \n", .{});
    } else {
        print("Invalid value provided \n");
    }
}

fn changeOrderStatus(status: OrderStatus) void { // u3 has 8 values and again using enum instead of hardcoded values
    if (status == OrderStatus.new) {
        print("Order status: New \n", .{});
    } else if (status == OrderStatus.confirmed) {
        print("Order status: Confirmed \n", .{});
    } else if (status == OrderStatus.rejected) {
        print("Order status: Rejected \n", .{});
    } else if (status == OrderStatus.cancelled) {
        print("Order status: Cancelled \n", .{});
    } else if (status == .picked_up) { // Here, enum values are inferred with a dot
        print("Order status: Picked up \n", .{});
    } else if (status == .delivered) { // Here, enum values are inferred with a dot
        print("Order status: Delivered \n", .{});
    }
}

// Enum literal is specified by a dot, followed by an enum's value. E.g.
// instead of "status == OrderStatus.new", we can use "status == .new"
// and it would compile without any issue.

// Tip:
//     - Use @intFromEnum to get the numeric value of an enum value
//     - Use @enumFromInt to convert a numeric value to an enum
