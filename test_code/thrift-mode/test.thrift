namespace go thrift_test
namespace java thrift.test

include "sub/included2.thrift"

struct Fruit {
    1: optional i64 a
    2: i64 b
    3: i32 c
    4: string d
    5: included2.Object o
}

enum MyEnum1 {
  ME1_0 = 0
  ME1_1 = 1
  ME1_2
  ME1_3
  ME1_5 = 5
  ME1_6
}

struct OneOfEachZZ {
    1: bool im_true
    2: bool im_false
    3: byte a_bite
    4: i16 integer16
    5: i32 integer32
    6: i64 integer64
    7: double double_precision
    8: string some_characters
    9: string zomg_unicode
    10: bool what_who
    11: Fruit fruit2
    12: included2.Numberz o
}

const i32 hex_const = 0x0001F
const i32 negative_hex_constant = -0x0001F

const i32 GEN_ME = -3523553
const double GEn_DUB = 325.532
const double GEn_DU = 085.2355
const string GEN_STRING = "asldkjasfd"
service UnderscoreSrv {
    i64 some_rpc_call(1: string message)
}
