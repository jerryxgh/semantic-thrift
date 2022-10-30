;;; thrift-wy.el --- Generated parser support file

;; Copyright (C) 2022 Guanghui Xu

;; Author: Guanghui Xu <gh_xu@qq.com>
;; Created: 2022-10-30 23:47:35+0800
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
;; Stack of enum names in scope.
  (defvar wisent-thrift-wy--enums nil)

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
     ("xception" . tok_xception)
     ("throws" . tok_throws)
     ("extends" . tok_extends)
     ("service" . tok_service)
     ("enum" . tok_enum)
     ("const" . tok_const)
     ("required" . tok_required)
     ("optional" . tok_optional)
     ("union" . tok_union)
     ("reference" . tok_reference))
   'nil)
  "Table of language keywords.")

(defconst wisent-thrift-wy--token-table
  (semantic-lex-make-type-table
   '(("number"
      (tok_dub_constant . "\\([+-]?[0-9]*\\(.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?\\)")
      (tok_int_constant . "\\([+-]?[0-9]+\\|[+-]?0x[0-9A-Fa-f]+\\)"))
     ("string"
      (tok_literal))
     ("symbol"
      (tok_identifier)))
   '(("keyword" :declared t)
     ("number" :declared t)
     ("string" :declared t)
     ("symbol" :declared t)))
  "Table of lexical tokens.")

(defconst wisent-thrift-wy--parse-table
  (wisent-compiled-grammar
   ((tok_identifier tok_literal tok_int_constant tok_dub_constant tok_include tok_namespace tok_cpp_include tok_cpp_type tok_xsd_all tok_xsd_optional tok_xsd_nillable tok_xsd_attrs tok_void tok_bool tok_string tok_binary tok_uuid tok_byte tok_i8 tok_i16 tok_i32 tok_i64 tok_double tok_map tok_list tok_set tok_oneway tok_async tok_typedef tok_struct tok_xception tok_throws tok_extends tok_service tok_enum tok_const tok_required tok_optional tok_union tok_reference)
    nil
    (Program
     ((HeaderList DefinitionList)))
    (CaptureDocText
     (nil))
    (DestroyDocText
     (nil))
    (HeaderList
     ((HeaderList DestroyDocText Header))
     (nil))
    (Header
     ((Include))
     ((tok_namespace tok_identifier tok_identifier TypeAnnotations))
     ((tok_namespace 42 tok_identifier))
     ((tok_cpp_include tok_literal)))
    (Include
     ((tok_include tok_literal)))
    (DefinitionList
      ((DefinitionList CaptureDocText Definition))
      (nil))
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
     ((44))
     ((59))
     (nil))
    (Typedef
     ((tok_typedef FieldType tok_identifier TypeAnnotations CommaOrSemicolonOptional)))
    (Enum
     ((tok_enum tok_identifier 123 EnumDefList 125 TypeAnnotations)))
    (EnumDefList
     ((EnumDefList EnumDef))
     (nil))
    (EnumDef
     ((CaptureDocText EnumValue TypeAnnotations CommaOrSemicolonOptional)))
    (EnumValue
     ((tok_identifier 61 tok_int_constant))
     ((tok_identifier)))
    (Const
     ((tok_const FieldType tok_identifier 61 ConstValue CommaOrSemicolonOptional)))
    (ConstValue
     ((tok_int_constant))
     ((tok_dub_constant))
     ((tok_literal))
     ((tok_identifier))
     ((ConstList))
     ((ConstMap)))
    (ConstList
     ((91 ConstListContents 93))
     (nil))
    (ConstListContents
     ((ConstListContents ConstValue CommaOrSemicolonOptional))
     (nil))
    (ConstMap
     ((123 ConstMapContents 125)))
    (ConstMapContents
     ((ConstMapContents ConstValue 58 ConstValue CommaOrSemicolonOptional))
     (nil))
    (StructHead
     ((tok_struct))
     ((tok_union)))
    (Struct
     ((StructHead tok_identifier XsdAll 123 FieldList 125 TypeAnnotations)))
    (XsdAll
     ((tok_xsd_all))
     (nil))
    (XsdOptional
     ((tok_xsd_optional))
     (nil))
    (XsdNillable
     ((tok_xsd_nillable))
     (nil))
    (XsdAttributes
     ((tok_xsd_attrs 123 FieldList 125))
     (nil))
    (Xception
     ((tok_xception tok_identifier 123 FieldList 125 TypeAnnotations)))
    (Service
     ((tok_service tok_identifier Extends 123 FlagArgs FunctionList UnflagArgs 125 TypeAnnotations)))
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
     ((CaptureDocText Oneway FunctionType tok_identifier 40 FieldList 41 Throws TypeAnnotations CommaOrSemicolonOptional)))
    (Oneway
     ((tok_oneway))
     ((tok_async))
     (nil))
    (Throws
     ((tok_throws 40 FieldList 41))
     (nil))
    (FieldList
     ((FieldList Field))
     (nil))
    (Field
     ((CaptureDocText FieldIdentifier FieldRequiredness FieldType FieldReference FieldName FieldValue XsdOptional XsdNillable XsdAttributes TypeAnnotations CommaOrSemicolonOptional)))
    (FieldName
     ((tok_identifier))
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
     ((tok_xception))
     ((tok_extends))
     ((tok_throws))
     ((tok_service))
     ((tok_enum))
     ((tok_const))
     ((tok_required))
     ((tok_optional)))
    (FieldIdentifier
     ((tok_int_constant 58))
     (nil))
    (FieldReference
     ((tok_reference))
     (nil))
    (FieldRequiredness
     ((tok_required))
     ((tok_optional))
     (nil))
    (FieldValue
     ((61 ConstValue))
     (nil))
    (FunctionType
     ((FieldType))
     ((tok_void)))
    (FieldType
     ((tok_identifier))
     ((BaseType))
     ((ContainerType)))
    (BaseType
     ((SimpleBaseType TypeAnnotations)))
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
     ((SimpleContainerType TypeAnnotations)))
    (SimpleContainerType
     ((MapType))
     ((SetType))
     ((ListType)))
    (MapType
     ((tok_map CppType 60 FieldType 44 FieldType 62)))
    (SetType
     ((tok_set CppType 60 FieldType 62)))
    (ListType
     ((tok_list CppType 60 FieldType 62)))
    (CppType
     ((tok_cpp_type tok_literal))
     (nil))
    (TypeAnnotations
     ((40 TypeAnnotationList 41))
     (nil))
    (TypeAnnotationList
     ((TypeAnnotationList TypeAnnotation))
     (nil))
    (TypeAnnotation
     ((tok_identifier TypeAnnotationValue CommaOrSemicolonOptional)))
    (TypeAnnotationValue
     ((61 tok_literal))
     (nil)))
   (Program))
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
(define-lex-regex-type-analyzer wisent-thrift-wy--<number>-regexp-analyzer
  "regexp analyzer for <number> tokens."
  semantic-lex-number-expression
  '((tok_dub_constant . "\\([+-]?[0-9]*\\(.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?\\)")
    (tok_int_constant . "\\([+-]?[0-9]+\\|[+-]?0x[0-9A-Fa-f]+\\)"))
  'number)

(define-lex-keyword-type-analyzer wisent-thrift-wy--<keyword>-keyword-analyzer
  "keyword analyzer for <keyword> tokens."
  "\\(\\sw\\|\\s_\\)+")

(define-lex-sexp-type-analyzer wisent-thrift-wy--<string>-sexp-analyzer
  "sexp analyzer for <string> tokens."
  "\\s\""
  'tok_literal)

(define-lex-regex-type-analyzer wisent-thrift-wy--<symbol>-regexp-analyzer
  "regexp analyzer for <symbol> tokens."
  "\\(\\sw\\|\\s_\\)+"
  nil
  'tok_identifier)


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
  wisent-thrift-wy--<number>-regexp-analyzer
  wisent-thrift-wy--<string>-sexp-analyzer
  ;; Must detect keywords before other symbols
  wisent-thrift-wy--<keyword>-keyword-analyzer
  wisent-thrift-wy--<symbol>-regexp-analyzer
  ;;;;
  semantic-lex-default-action)

(provide 'thrift-wy)

;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; End:

;;; thrift-wy.el ends here
