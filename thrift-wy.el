;;; thrift-wy.el --- Generated parser support file

;; Copyright (C) 2023 bytedance

;; Author: bytedance <bytedance@C02FT0L6MD6V>
;; Created: 2023-01-29 20:07:12+0800
;; Keywords: syntax
;; X-RCS: $Id$

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; PLEASE DO NOT MANUALLY EDIT THIS FILE!  It is automatically
;; generated from the grammar file thrift.wy.

;;; Code:

(require 'semantic/lex)
(require 'semantic/wisent)

;;; Prologue
;;
(declare-function semantic-parse-region "semantic"
                  (start end &optional nonterminal depth returnonerror))

;;; Declarations
;;
(eval-and-compile (defconst wisent-thrift-wy--expected-conflicts
		    nil
		    "The number of expected shift/reduce conflicts in this grammar."))

(defconst wisent-thrift-wy--keyword-table
  (semantic-lex-make-keyword-table
   '(("include" . tok_include)
     ("namespace" . tok_namespace)
     ("cpp_include" . tok_cpp_include)
     ("cpp_type" . tok_cpp_type)
     ("xsd_all" . tok_xsd_all)
     ("xsd_optional" . tok_xsd_optional)
     ("xsd_nillable" . tok_xsd_nillable)
     ("xsd_attrs" . tok_xsd_attrs)
     ("void" . tok_void)
     ("bool" . tok_bool)
     ("string" . tok_string)
     ("binary" . tok_binary)
     ("uuid" . tok_uuid)
     ("byte" . tok_byte)
     ("i8" . tok_i8)
     ("i16" . tok_i16)
     ("i32" . tok_i32)
     ("i64" . tok_i64)
     ("double" . tok_double)
     ("map" . tok_map)
     ("list" . tok_list)
     ("set" . tok_set)
     ("oneway" . tok_oneway)
     ("async" . tok_async)
     ("typedef" . tok_typedef)
     ("struct" . tok_struct)
     ("exception" . tok_exception)
     ("throws" . tok_throws)
     ("extends" . tok_extends)
     ("service" . tok_service)
     ("enum" . tok_enum)
     ("const" . tok_const)
     ("required" . tok_required)
     ("optional" . tok_optional)
     ("union" . tok_union)
     ("reference" . tok_reference))
   '(("reference" summary "Reference")
     ("union" summary "Union")
     ("optional" summary "Optional")
     ("required" summary "Required")
     ("const" summary "Const")
     ("enum" summary "Enum")
     ("service" summary "Service")
     ("extends" summary "Extends")
     ("throws" summary "Throws")
     ("exception" summary "Exception")
     ("struct" summary "Define struct: struct <name> {}")
     ("typedef" summary "Define type")
     ("async" summary "Async")
     ("oneway" summary "Oneway")
     ("set" summary "Set type")
     ("map" summary "List type")
     ("map" summary "Key value map type")
     ("double" summary "Primitive floating-point type (double-precision 64-bit IEEE 754)")
     ("i64" summary "I64 type")
     ("i32" summary "I32 type")
     ("i16" summary "I16 type")
     ("i8" summary "I8 type")
     ("byte" summary "Byte type")
     ("uuid" summary "Uuid type")
     ("binary" summary "Binary type")
     ("string" summary "String type")
     ("bool" summary "Primitive logical quantity type (true or false)")
     ("void" summary "Method return type: void <name> ...")
     ("xsd_attrs" summary "Xsd attrs")
     ("xsd_nillable" summary "Xsd nillable")
     ("xsd_optional" summary "Xsd optional")
     ("xsd_all" summary "Xsd all")
     ("cpp_type" summary "Cpp type")
     ("cpp_include" summary "Include cpp file: cpp_include \"name\"")
     ("namespace" summary "Namespace of current file")
     ("include" summary "Include other thrift file: include \"name\"")))
  "Table of language keywords.")

(defconst wisent-thrift-wy--token-table
  (semantic-lex-make-type-table
   '(("string"
      (tok_literal))
     ("symbol"
      (tok_identifier)
      (tok_boolean_literal . "\\`true\\'")
      (tok_boolean_literal . "\\`false\\'"))
     ("dub_constant"
      (tok_dub_constant))
     ("int_constant"
      (tok_int_constant))
     ("punctuation"
      (tok_at . "@")
      (tok_ellipsis . "...")
      (tok_comp . "~")
      (tok_oror . "||")
      (tok_oreq . "|=")
      (tok_or . "|")
      (tok_xoreq . "^=")
      (tok_xor . "^")
      (tok_question . "?")
      (tok_urshifteq . ">>>=")
      (tok_urshift . ">>>")
      (tok_rshifteq . ">>=")
      (tok_rshift . ">>")
      (tok_gteq . ">=")
      (tok_gt . ">")
      (tok_eqeq . "==")
      (tok_eq . "=")
      (tok_lteq . "<=")
      (tok_lshifteq . "<<=")
      (tok_lshift . "<<")
      (tok_lt . "<")
      (tok_semicolon . ";")
      (tok_colon . ":")
      (tok_diveq . "/=")
      (tok_div . "/")
      (tok_dot . ".")
      (tok_minuseq . "-=")
      (tok_minusminus . "--")
      (tok_minus . "-")
      (tok_comma . ",")
      (tok_pluseq . "+=")
      (tok_plusplus . "++")
      (tok_plus . "+")
      (tok_multeq . "*=")
      (tok_mult . "*")
      (tok_andeq . "&=")
      (tok_andand . "&&")
      (tok_and . "&")
      (tok_modeq . "%=")
      (tok_mod . "%")
      (tok_noteq . "!=")
      (tok_not . "!"))
     ("close-paren"
      (tok_rbrack . "]")
      (tok_rbrace . "}")
      (tok_rparen . ")"))
     ("open-paren"
      (tok_lbrack . "[")
      (tok_lbrace . "{")
      (tok_lparen . "("))
     ("block"
      (BrackBlock . "(tok_lbrack tok_rbrack)")
      (BraceBlock . "(tok_lbrace tok_rbrace)")
      (ParenBlock . "(tok_lparen tok_rparen)")))
   '(("keyword" :declared t)
     ("string" :declared t)
     ("symbol" :declared t)
     ("dub_constant" syntax "\\([+-]?[0-9]+\\(.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?\\)")
     ("dub_constant" matchdatatype regexp)
     ("dub_constant" :declared t)
     ("int_constant" syntax "\\([+-]?[0-9]+\\)")
     ("int_constant" matchdatatype regexp)
     ("int_constant" :declared t)
     ("punctuation" :declared t)
     ("block" :declared t)))
  "Table of lexical tokens.")

(defconst wisent-thrift-wy--parse-table
  (wisent-compiled-grammar
   ((ParenBlock BraceBlock BrackBlock tok_lparen tok_rparen tok_lbrace tok_rbrace tok_lbrack tok_rbrack tok_not tok_noteq tok_mod tok_modeq tok_and tok_andand tok_andeq tok_mult tok_multeq tok_plus tok_plusplus tok_pluseq tok_comma tok_minus tok_minusminus tok_minuseq tok_dot tok_div tok_diveq tok_colon tok_semicolon tok_lt tok_lshift tok_lshifteq tok_lteq tok_eq tok_eqeq tok_gt tok_gteq tok_rshift tok_rshifteq tok_urshift tok_urshifteq tok_question tok_xor tok_xoreq tok_or tok_oreq tok_oror tok_comp tok_ellipsis tok_at tok_int_constant tok_dub_constant tok_boolean_literal tok_identifier tok_literal tok_include tok_namespace tok_cpp_include tok_cpp_type tok_xsd_all tok_xsd_optional tok_xsd_nillable tok_xsd_attrs tok_void tok_bool tok_string tok_binary tok_uuid tok_byte tok_i8 tok_i16 tok_i32 tok_i64 tok_double tok_map tok_list tok_set tok_oneway tok_async tok_typedef tok_struct tok_exception tok_throws tok_extends tok_service tok_enum tok_const tok_required tok_optional tok_union tok_reference)
    nil
    (Program
     ((Header))
     ((Definition)))
    (Header
     ((Include))
     ((tok_namespace tok_identifier TokWithDot TypeAnnotations)
      (wisent-raw-tag
       (semantic-tag-new-package $3 $2)))
     ((tok_namespace tok_mult TokWithDot)
      (wisent-raw-tag
       (semantic-tag-new-package $3 $2)))
     ((tok_cpp_include tok_literal)
      (wisent-raw-tag
       (semantic-tag-new-include $2 nil))))
    (TokWithDot
     ((TokWithDot tok_dot tok_identifier)
      (concat $1 $2 $3))
     ((tok_identifier)))
    (Include
     ((tok_include tok_literal)
      (wisent-raw-tag
       (semantic-tag-new-include $2 nil))))
    (Definition
      ((Const))
      ((TypeDefinition))
      ((Service)))
    (TypeDefinition
     ((Typedef))
     ((Enum))
     ((Struct))
     ((Xception)))
    (CommaOrSemicolonOptional
     ((tok_comma)
      nil)
     ((tok_semicolon)
      nil)
     (nil))
    (Typedef
     ((tok_typedef FieldType TokWithDot TypeAnnotations CommaOrSemicolonOptional)
      (wisent-raw-tag
       (semantic-tag-new-type $3 $2 nil nil))))
    (Enum
     ((tok_enum TokWithDot EnumBody TypeAnnotations)
      (wisent-raw-tag
       (semantic-tag-new-type $2 $1 $3 nil))))
    (EnumBody
     ((BraceBlock)
      (semantic-parse-region
       (car $region1)
       (cdr $region1)
       'EnumMemberDeclaration 1)))
    (EnumMemberDeclaration
     ((tok_lbrace)
      nil)
     ((tok_rbrace)
      nil)
     ((EnumDef))
     ((EnumDef tok_rbrace)))
    (EnumDef
     ((EnumValue TypeAnnotations CommaOrSemicolonOptional)))
    (EnumValue
     ((tok_identifier tok_eq tok_int_constant)
      (wisent-raw-tag
       (semantic-tag-new-variable $1 nil $3)))
     ((tok_identifier)
      (wisent-raw-tag
       (semantic-tag-new-variable $1 nil nil))))
    (Const
     ((tok_const FieldType tok_identifier tok_eq ConstValue CommaOrSemicolonOptional)
      (wisent-raw-tag
       (semantic-tag-new-variable $3 $2 $5))))
    (ConstValue
     ((tok_int_constant))
     ((tok_boolean_literal))
     ((tok_dub_constant))
     ((tok_literal))
     ((tok_identifier)
      (wisent-raw-tag
       (semantic-tag-new-variable $1 nil nil)))
     ((ConstList))
     ((ConstMap)))
    (ConstList
     ((BrackBlock)
      (semantic-parse-region
       (car $region1)
       (cdr $region1)
       'ConstListMemberDeclaration 1)))
    (ConstListMemberDeclaration
     ((tok_lbrack)
      nil)
     ((tok_rbrack)
      nil)
     ((ConstValue CommaOrSemicolonOptional))
     ((ConstValue tok_rbrack)))
    (ConstMap
     ((BraceBlock)
      (semantic-parse-region
       (car $region1)
       (cdr $region1)
       'ConstMapMemberDeclaration 1)))
    (ConstMapMemberDeclaration
     ((tok_lbrace)
      nil)
     ((tok_rbrace)
      nil)
     ((ConstValue tok_colon ConstValue CommaOrSemicolonOptional))
     ((ConstValue tok_colon ConstValue tok_rbrace)))
    (StructHead
     ((tok_struct))
     ((tok_union)))
    (Struct
     ((StructHead tok_identifier XsdAll StructBody TypeAnnotations)
      (wisent-raw-tag
       (semantic-tag-new-type $2 $1 $4 nil))))
    (StructBody
     ((BraceBlock)
      (semantic-parse-region
       (car $region1)
       (cdr $region1)
       'StructBodyMemberDeclaration 1)))
    (StructBodyMemberDeclaration
     ((tok_lbrace)
      nil)
     ((tok_rbrace)
      nil)
     ((FieldIdentifier FieldRequiredness FieldType FieldReference tok_identifier FieldValue XsdOptional XsdNillable XsdAttributes TypeAnnotations CommaOrSemicolonOptional)
      (wisent-raw-tag
       (semantic-tag-new-variable $5 $3 nil :typemodifiers $2)))
     ((FieldIdentifier FieldRequiredness FieldType FieldReference tok_identifier FieldValue XsdOptional XsdNillable XsdAttributes TypeAnnotations tok_rbrace)
      (wisent-raw-tag
       (semantic-tag-new-variable $5 $3 nil :typemodifiers $2))))
    (XsdAll
     ((tok_xsd_all))
     (nil))
    (XsdOptional
     ((tok_xsd_optional)
      (list $1))
     (nil))
    (XsdNillable
     ((tok_xsd_nillable)
      (list $1))
     (nil))
    (XsdAttributes
     ((tok_xsd_attrs tok_lbrace FieldList tok_rbrace))
     (nil))
    (Xception
     ((tok_exception tok_identifier tok_lbrace FieldList tok_rbrace TypeAnnotations)))
    (Service
     ((tok_service tok_identifier Extends tok_lbrace FlagArgs FunctionList UnflagArgs tok_rbrace TypeAnnotations)))
    (FlagArgs
     (nil))
    (UnflagArgs
     (nil))
    (Extends
     ((tok_extends tok_identifier))
     (nil))
    (FunctionList
     ((FunctionList Function))
     (nil))
    (Function
     ((Oneway FunctionType tok_identifier tok_lparen FieldList tok_rparen Throws TypeAnnotations CommaOrSemicolonOptional)))
    (Oneway
     ((tok_oneway))
     ((tok_async))
     (nil))
    (Throws
     ((tok_throws tok_lparen FieldList tok_rparen))
     (nil))
    (FieldList
     ((FieldList Field))
     (nil))
    (Field
     ((FieldIdentifier FieldRequiredness FieldType FieldReference FieldName FieldValue XsdOptional XsdNillable XsdAttributes TypeAnnotations CommaOrSemicolonOptional)))
    (FieldName
     ((tok_identifier)
      (wisent-raw-tag
       (semantic-tag-new-variable $1 nil nil)))
     ((tok_namespace))
     ((tok_cpp_include))
     ((tok_cpp_type))
     ((tok_include))
     ((tok_void))
     ((tok_bool))
     ((tok_byte))
     ((tok_i8))
     ((tok_i16))
     ((tok_i32))
     ((tok_i64))
     ((tok_double))
     ((tok_string))
     ((tok_binary))
     ((tok_uuid))
     ((tok_map))
     ((tok_list))
     ((tok_set))
     ((tok_oneway))
     ((tok_async))
     ((tok_typedef))
     ((tok_struct))
     ((tok_union))
     ((tok_exception))
     ((tok_extends))
     ((tok_throws))
     ((tok_service))
     ((tok_enum))
     ((tok_const))
     ((tok_required))
     ((tok_optional)))
    (FieldIdentifier
     ((tok_int_constant tok_colon))
     (nil))
    (FieldReference
     ((tok_reference))
     (nil))
    (FieldRequiredness
     ((tok_required))
     ((tok_optional))
     (nil))
    (FieldValue
     ((tok_eq ConstValue))
     (nil))
    (FunctionType
     ((FieldType))
     ((tok_void)))
    (FieldType
     ((tok_identifier)
      (identity $1))
     ((tok_identifier tok_dot tok_identifier)
      (identity $3))
     ((BaseType))
     ((ContainerType)))
    (BaseType
     ((SimpleBaseType TypeAnnotations)
      (concat $1 $2)))
    (SimpleBaseType
     ((tok_string))
     ((tok_binary))
     ((tok_uuid))
     ((tok_bool))
     ((tok_byte))
     ((tok_i8))
     ((tok_i16))
     ((tok_i32))
     ((tok_i64))
     ((tok_double)))
    (ContainerType
     ((SimpleContainerType TypeAnnotations)
      (concat $1 $2)))
    (SimpleContainerType
     ((MapType))
     ((SetType))
     ((ListType)))
    (MapType
     ((tok_map CppType tok_lt FieldType tok_comma FieldType tok_gt)))
    (SetType
     ((tok_set CppType tok_lt FieldType tok_gt)))
    (ListType
     ((tok_list CppType tok_lt FieldType tok_gt)))
    (CppType
     ((tok_cpp_type tok_literal)
      (concat $1 $2))
     (nil))
    (TypeAnnotations
     ((tok_lparen TypeAnnotationList tok_rparen))
     (nil))
    (TypeAnnotationList
     ((TypeAnnotationList TypeAnnotation)
      (cons $2 $1))
     (nil))
    (TypeAnnotation
     ((tok_identifier TypeAnnotationValue CommaOrSemicolonOptional)
      (concat $1 $2)))
    (TypeAnnotationValue
     ((tok_eq tok_literal)
      (list $2))
     (nil)))
   (Program Header Definition EnumMemberDeclaration ConstListMemberDeclaration StructBodyMemberDeclaration ConstMapMemberDeclaration))
  "Parser table.")

(defun wisent-thrift-wy--install-parser ()
  "Setup the Semantic Parser."
  (semantic-install-function-overrides
   '((semantic-parse-stream . wisent-parse-stream)))
  (setq semantic-parser-name "LALR"
        semantic--parse-table wisent-thrift-wy--parse-table
        semantic-debug-parser-source "thrift.wy"
        semantic-flex-keywords-obarray wisent-thrift-wy--keyword-table
        semantic-lex-types-obarray wisent-thrift-wy--token-table)
  ;; Collect unmatched syntax lexical tokens
  (add-hook 'wisent-discarding-token-functions
            #'wisent-collect-unmatched-syntax nil t))


;;; Analyzers
;;
(define-lex-regex-type-analyzer wisent-thrift-wy--<int_constant>-regexp-analyzer
  "regexp analyzer for <int_constant> tokens."
  "\\([+-]?[0-9]+\\)"
  nil
  'tok_int_constant)

(define-lex-keyword-type-analyzer wisent-thrift-wy--<keyword>-keyword-analyzer
  "keyword analyzer for <keyword> tokens."
  "\\(\\sw\\|\\s_\\)+")

(define-lex-sexp-type-analyzer wisent-thrift-wy--<string>-sexp-analyzer
  "sexp analyzer for <string> tokens."
  "\\s\""
  'tok_literal)

(define-lex-block-type-analyzer wisent-thrift-wy--<block>-block-analyzer
  "block analyzer for <block> tokens."
  "\\s(\\|\\s)"
  '((("(" tok_lparen ParenBlock)
     ("{" tok_lbrace BraceBlock)
     ("[" tok_lbrack BrackBlock))
    (")" tok_rparen)
    ("}" tok_rbrace)
    ("]" tok_rbrack))
  )

(define-lex-string-type-analyzer wisent-thrift-wy--<punctuation>-string-analyzer
  "string analyzer for <punctuation> tokens."
  "\\(\\s.\\|\\s$\\|\\s'\\)+"
  '((tok_at . "@")
    (tok_ellipsis . "...")
    (tok_comp . "~")
    (tok_oror . "||")
    (tok_oreq . "|=")
    (tok_or . "|")
    (tok_xoreq . "^=")
    (tok_xor . "^")
    (tok_question . "?")
    (tok_urshifteq . ">>>=")
    (tok_urshift . ">>>")
    (tok_rshifteq . ">>=")
    (tok_rshift . ">>")
    (tok_gteq . ">=")
    (tok_gt . ">")
    (tok_eqeq . "==")
    (tok_eq . "=")
    (tok_lteq . "<=")
    (tok_lshifteq . "<<=")
    (tok_lshift . "<<")
    (tok_lt . "<")
    (tok_semicolon . ";")
    (tok_colon . ":")
    (tok_diveq . "/=")
    (tok_div . "/")
    (tok_dot . ".")
    (tok_minuseq . "-=")
    (tok_minusminus . "--")
    (tok_minus . "-")
    (tok_comma . ",")
    (tok_pluseq . "+=")
    (tok_plusplus . "++")
    (tok_plus . "+")
    (tok_multeq . "*=")
    (tok_mult . "*")
    (tok_andeq . "&=")
    (tok_andand . "&&")
    (tok_and . "&")
    (tok_modeq . "%=")
    (tok_mod . "%")
    (tok_noteq . "!=")
    (tok_not . "!"))
  'punctuation)

(define-lex-regex-type-analyzer wisent-thrift-wy--<symbol>-regexp-analyzer
  "regexp analyzer for <symbol> tokens."
  "\\(\\sw\\|\\s_\\)+"
  '((tok_boolean_literal . "\\`true\\'")
    (tok_boolean_literal . "\\`false\\'"))
  'tok_identifier)

(define-lex-regex-type-analyzer wisent-thrift-wy--<dub_constant>-regexp-analyzer
  "regexp analyzer for <dub_constant> tokens."
  "\\([+-]?[0-9]+\\(.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?\\)"
  nil
  'tok_dub_constant)


;;; Epilogue
;;
;; Define the lexer for this grammar
(define-lex wisent-thrift-lexer
  "Lexical analyzer that handles Thrift buffers.
It ignores whitespaces, newlines and comments."
  semantic-lex-ignore-whitespace
  semantic-lex-ignore-newline
  semantic-lex-ignore-comments
  ;;;; Auto-generated analyzers.
  wisent-thrift-wy--<int_constant>-regexp-analyzer
  wisent-thrift-wy--<dub_constant>-regexp-analyzer
  wisent-thrift-wy--<string>-sexp-analyzer
  ;; Must detect keywords before other symbols
  wisent-thrift-wy--<keyword>-keyword-analyzer
  wisent-thrift-wy--<symbol>-regexp-analyzer
  wisent-thrift-wy--<punctuation>-string-analyzer
  wisent-thrift-wy--<block>-block-analyzer
  ;;;;
  semantic-lex-default-action)

(provide 'thrift-wy)

;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; End:

;;; thrift-wy.el ends here
