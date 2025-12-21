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

// semantic-analyze-completion-at-point-function
// semantic-analyze-current-context-default
// semantic-analyze-find-tag-sequence
// (eglot-completion-at-point 4152 4163 #f(compiled-function (pattern pred action) #<bytecode -0xc4e94a4203d983b>) :annotation-function #<subr F616e6f6e796d6f75732d6c616d626461_anonymous_lambda_174> :company-kind #<subr F616e6f6e796d6f75732d6c616d626461_anonymous_lambda_175> :company-deprecated #<subr F616e6f6e796d6f75732d6c616d626461_anonymous_lambda_176> :company-docsig #f(compiled-function (proxy) #<bytecode 0x1a800eb6805319c3>) :company-doc-buffer #f(compiled-function (proxy) #<bytecode -0x125abfa4e01fde2b>) :company-require-match never :company-prefix-length t :exit-function #f(compiled-function (proxy status) #<bytecode 0x11312c61abc9863b>))
// Result: (semantic-analyze-completion-at-point-function 1353 1353 (("Object" type (:members (("id" variable (:typemodifiers (nil) :index "1" :type "i64") (reparse-symbol FieldsInBraceMemberDeclaration) [74 83]) ("name" variable (:typemodifiers (nil) :index "2" :type "string") (reparse-symbol FieldsInBraceMemberDeclaration) [88 102])) :type "struct") nil [54 104]) ("Object3" type (:members (("id" variable (:typemodifiers (nil) :index "1" :type "i64") (reparse-symbol FieldsInBraceMemberDeclaration) [127 136]) ("name" variable (:typemodifiers (nil) :index "2" :type "string") (reparse-symbol FieldsInBraceMemberDeclaration) [141 155])) :type "struct") nil [106 157]) ("Numberz" type (:members (("ONE" variable (:default-value "1") (reparse-symbol EnumMemberDeclaration) [200 207]) ("TWO" variable nil (reparse-symbol EnumMemberDeclaration) [213 216]) ("THREE" variable nil (reparse-symbol EnumMemberDeclaration) [222 227]) ("FIVE" variable (:default-value "5") (reparse-symbol EnumMemberDeclaration) [233 241]) ("SIX" variable nil (reparse-symbol EnumMemberDeclaration) [247 250]) ("EIGHT" variable (:default-value "8") (reparse-symbol EnumMemberDeclaration) [256 265])) :type "enum") nil [181 267])))
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
    12: included2.Numberz number
    13: included2.Object3 o3
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
