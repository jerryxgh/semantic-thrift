;;; thrift-wy.el --- Generated parser support file

;; Copyright (C) 2022 Guanghui Xu

;; Author: Guanghui Xu <gh_xu@qq.com>
;; Created: 2022-11-06 19:32:37+0800
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

;;; Declarations
;;
(eval-and-compile (defconst thrift-wy--expected-conflicts
                    nil
                    "The number of expected shift/reduce conflicts in this grammar."))

(defconst thrift-wy--keyword-table
  (semantic-lex-make-keyword-table
   '(("reference" . tok_reference))
   'nil)
  "Table of language keywords.")

(defconst thrift-wy--token-table
  (semantic-lex-make-type-table 'nil 'nil)
  "Table of lexical tokens.")

(defconst thrift-wy--parse-table
  (wisent-compiled-grammar
   ((tok_reference)
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
     ((91 ConstListContents 93)))
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
   nil)
  "Parser table.")

(defun thrift-wy--install-parser ()
  "Setup the Semantic Parser."
  (semantic-install-function-overrides
   '((semantic-parse-stream . wisent-parse-stream)))
  (setq semantic-parser-name "LALR"
        semantic--parse-table thrift-wy--parse-table
        semantic-debug-parser-source "thrift.wy"
        semantic-flex-keywords-obarray thrift-wy--keyword-table
        semantic-lex-types-obarray thrift-wy--token-table)
  ;; Collect unmatched syntax lexical tokens
  (add-hook 'wisent-discarding-token-functions
            #'wisent-collect-unmatched-syntax nil t))


;;; Analyzers
;;

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
