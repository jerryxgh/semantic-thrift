namespace go thrift_test
namespace java thrift.test

include "sub/included.thrift"

struct Fruit {
    1: required i64 a
    2: i64 b
    3: i32 c
    4: string d
    5: included.Object o
}

struct Fruit2 {
    1: required i64 a
    2: i64 b
    3: i32 c
    4: string d
    5: Fruit o
}
