namespace go thrift_test
namespace java thrift.test

struct Object {
    1: i64 id
    2: string name
}

struct Object3 {
    1: i64 id
    2: string name
}

/**
 * Docstring!
 */
enum Numberz
{
    ONE = 1,
    TWO,
    THREE,
    FIVE = 5,
    SIX,
    EIGHT = 8
}
