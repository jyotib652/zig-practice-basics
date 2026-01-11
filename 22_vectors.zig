//! Vectors

const print = @import("std").debug.print;

pub fn main() void {
    // Vector is a group of numeric, boolean & pointer values.
    // Vector can't mix types, values must be of same types.
    // The main difference between an array and vector is:
    // Array is meant to hold a collection of values whereas
    // Vector is meant to perform operation on those elements/values.
    // Vector supports the operation as their underlying types
    const vector1: @Vector(3, u8) = @Vector(3, u8){ 1, 5, 7 };
    const vector2 = @Vector(3, u8){ 0, 2, 1 };
    print("vector1: {} \n", .{vector1});
    print("vector2: {} \n", .{vector2});

    // Given that vector1 & vector2 must have the same length
    const vector3 = vector1 + vector2;
    print("vector3: {} \n", .{vector3});

    // Operation between a vector and scaler not permitted
    // const vector4 = vector3 + 2; // it will cause a copiler error
    // print("vector4: {} \n", .{vector4});

    // Converting a scaler to a vector. Suppose you want
    // to increase the value of elements of vector3 by 2.
    // Like const vector4 = vector3 + 2; Here you have to
    // convert the scaler 2 to a vector with 3 elements
    // and the value of each element needs to be 2. Why
    // a vector with 3 elements? Because vector3 has also
    // 3 elements. We can convert a scaler to a vector
    // by using built-in "@splat" function
    const scaler_2_vector: @Vector(3, u8) = @splat(2);
    const vector4 = vector3 + scaler_2_vector;
    print("vector4: {} \n", .{vector4});

    // Converting a vector to a scaler using the built-in
    // function "@reduce". @reudce takes 2 arguments, first
    // one is the operation to be performed between the elements
    // of the vector and the second argument is the vector itself.
    // The first argument is a built-in enum of type "ReduceOp"
    // which exists inside standard libray and can be imported.
    // ReduceOp has several operations for us:
    // Or, And, Xor, Min, Max, Add & Mul(multiplication).
    // Add, Mul, Min & Max can be applied to numeric vectors.
    // Or, And & Xor can be applied to boolean vectors.
    const ReduceOp = @import("std").builtin.ReduceOp;
    const reduce_result = @reduce(ReduceOp.Add, vector4);
    print("reduce_result: {} \n", .{reduce_result});

    // Just like arrays, vectors can also be indexed
    print("\n", .{});
    print("vector4 element at index 0 is: {} \n", .{vector4[0]});

    // Arrays with fixed length can be converted into a vector and vice versa
    // by using type inference as long as length and type matches
    const array1: [3]u8 = vector4; // converting the vector into an array by type inferrence
    print("array1: {any} \n", .{array1});
    const vector5: @Vector(3, u8) = array1; // both the length and type matches: length 3 and type u8
    print("vector5: {} \n", .{vector5});

    // Vectors do not have a length field. If we need to know the length of a
    // vector we have to use built-in @typeInfo function
    print("\n", .{});
    const vector5Type = @TypeOf(vector5);
    const vector5TypeInfo = @typeInfo(vector5Type);
    print("type info of vector5: {} \n", .{vector5TypeInfo});
    print("length of vector5: {} \n", .{vector5TypeInfo.vector.len});
    print("type of elements of vector5(child): {} \n", .{vector5TypeInfo.vector.child});
}
