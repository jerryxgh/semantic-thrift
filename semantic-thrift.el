;;; semantic-thrift.el --- Thrift LALR parser -*- lexical-binding: t -*-

;;; Copyright (C) 2022 Guanghui Xu
;;
;; Author: Guanghui Xu gh_xu@qq.com
;; Maintainer: Guanghui Xu gh_xu@qq.com
;; URL: https://github.com/jerryxgh/semantic-thrift
;; Created: 2022-11-29
;; Version: 0.0.1
;; Keywords: extensions, thrift, semantic
;; Homepage: https://github.com/jerryxgh/semantic-thrift
;; Package-Version: 0.0.1
;; Package-Requires: ((thrift "0.0.1") (emacs "28.2"))
;;

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
;; With thrift, semantic-thrift support semantic level jumping of thrift.
;; Until now, there is no tag tool for thrift in Emacs, including global, so I
;; create this tiny project, through wisent, this project implement grammatical
;; analysis of thirft, and through semantic, it's able to support semantic level
;; jumping, such like jumping to definiton, even in different file by include.

;;; Code:

(require 'semantic/wisent)
(require 'semantic/ctxt)
(require 'semantic/tag-file)
(require 'semantic/analyze)
(require 'semantic/java)
(require 'semantic/db-typecache)
(require 'semantic/imenu)
(require 'seq)
(require 'cc-mode)
(require 'thrift)
(require 'semantic-thrift-wy)

;;;;
;;;; Simple parser error reporting function
;;;;

(defun semantic-thrift-parse-error (msg)
  "Error reporting function called when a parse error occurs.
MSG is the message string to report."
  (message msg)
  ;;(debug)
  )

(define-mode-local-override semantic-dependency-tag-file thrift-mode (tag)
  "Find the filename represented from TAG."
  (unless (semantic-tag-of-class-p tag 'include)
    (signal 'wrong-type-argument (list tag 'include)))

  (let ((tfile (semantic-tag-include-filename tag)))
    (if (and (string-prefix-p "\"" tfile) (string-suffix-p "\"" tfile))
        (expand-file-name (substring tfile 1 -1))
        (expand-file-name tfile))))

(define-mode-local-override semantic-analyze-find-tag-sequence thrift-mode (sequence &optional scope typereturn throwsym &rest flags)
  "Attempt to find all tags in SEQUENCE.
Optional argument LOCALVAR is the list of local variables to use when
finding the details on the first element of SEQUENCE in case
it is not found in the global set of tables.
Optional argument SCOPE are additional terminals to search which are currently
scoped.  These are not local variables, but symbols available in a structure
which doesn't need to be dereferenced.
Optional argument TYPERETURN is a symbol in which the types of all found
will be stored.  If nil, that data is thrown away.
Optional argument THROWSYM specifies a symbol the throw on non-recoverable
error.
Remaining arguments FLAGS are additional flags to apply when searching."
  (let ((result '()))
    (dolist (ele sequence)
      (let ((val (semantic-analyze-find-tag-sequence-default (list ele) scope typereturn throwsym flags)))
        (if val
          (setq result (append val result)))))
    ;; only need the first one
    (if (length> result 0)
        (setq result (list (car result))))
    result))

(define-mode-local-override semanticdb-typecache-find thrift-mode (type &optional path find-file-match)
  "Search the typecache for TYPE in PATH.
If type is a string, split the string, and search for the parts.
If type is a list, treat the type as a pre-split string.
PATH can be nil for the current buffer, or a semanticdb table.
FIND-FILE-MATCH is non-nil to force all found tags to be loaded into a buffer."
  (let ((result (semanticdb-typecache-find-default type path find-file-match)))
    (dolist (ele (semantic-find-tags-by-class 'include semanticdb-current-table) result)
      (if (or (and (listp type) (equal (car type) (semantic-tag-get-attribute ele :alias)))
              (and (stringp type) (equal type (semantic-tag-get-attribute ele :alias))))
          (setq result ele)))
    result))


(define-mode-local-override semantic-analyze-possible-completions thrift-mode (context &rest flags)
  "Completions for thrift include, return a list of semantic tags which are possible completions."
  (let* ((a context)
         (prefix (oref a prefix))
         (rest (cadr prefix))
         (scope (oref a scope))
         (first-tag-search-result
          (ignore-errors
            (semantic-analyze-find-tag-sequence-default (first prefix) scope nil nil nil )))
         (first-tag (and (listp first-tag-search-result) (car first-tag-search-result)))
         (first-tag-class (semantic-tag-class first-tag))
         (is-include (and (length= prefix 2) (equal first-tag-class 'include))))

    (and is-include
         (let* ((f (semantic-dependency-tag-file first-tag))
                (table (and f (file-exists-p f) (semanticdb-file-table-object f)))
                (result nil))
           (cond
            ((and table rest (length> rest 0))
             (let* ((found (semantic-find-tags-for-completion rest table))
                    (tags (cond
                           ((and (consp found) (semantic-tag-p (car found))) found)
                           ((and (listp found) (consp (car found)) (semantic-tag-p (cadr (car found))))
                            (apply #'append (mapcar #'cdr found)))
                           (t found))))
               (setq result (seq-filter (lambda (t) (eq (semantic-tag-class t) 'type)) tags))))
            ((and table (or (null rest) (equal rest "")))
             (setq result (semantic-find-tags-by-class 'type table))))
           result))))

;;; Completion At Point function
(defun semantic-thrift-analyze-completion-at-point-function ()
  "Return possible analysis completions at point.
The completions provided are via `semantic-analyze-possible-completions'.
This function can be used by `completion-at-point-functions'."
  (when (semantic-active-p)
    (let* ((ctxt (semantic-analyze-current-context))
           (possible (semantic-analyze-possible-completions ctxt)))

      ;; The return from this is either:
      ;; nil - not applicable here.
      ;; A list: (START END COLLECTION . PROPS)
      (when possible
        (list (car (oref ctxt bounds))
              (cdr (oref ctxt bounds))
              possible
              :company-prefix-length t)))))

(setq-mode-local thrift-mode
                 semanticdb-find-default-throttle
                 '(local recursive project unloaded system))

(defvar semantic-thrift-syntax-table
  (let ((table (make-syntax-table)))

    ;; --- Whitespace ---
    ;; Already set in standard-syntax-table: space, tab, newline, etc.

    ;; --- Word constituents: letters and digits ---
    ;; Standard table already marks a-z, A-Z as 'w', and 0-9 as 'w' (in most locales)
    ;; But to be explicit and safe:
    (let ((i ?a))
      (while (<= i ?z)
        (modify-syntax-entry i "w" table)
        (setq i (1+ i))))
    (let ((i ?A))
      (while (<= i ?Z)
        (modify-syntax-entry i "w" table)
        (setq i (1+ i))))
    (let ((i ?0))
      (while (<= i ?9)
        (modify-syntax-entry i "w" table)
        (setq i (1+ i))))

    ;; Underscore is part of identifiers (e.g., my_struct)
    (modify-syntax-entry ?_ "w" table)

    ;; Minus/hyphen is NOT part of identifiers in Thrift → treat as punctuation
    (modify-syntax-entry ?- "." table)

    ;; Dollar sign is not used in Thrift identifiers
    (modify-syntax-entry ?$ "." table)

    ;; --- Parentheses and delimiters ---
    (modify-syntax-entry ?\( "()" table)
    (modify-syntax-entry ?\) ")(" table)
    (modify-syntax-entry ?\[ "(]" table)
    (modify-syntax-entry ?\] ")[" table)
    (modify-syntax-entry ?\{ "(}" table)
    (modify-syntax-entry ?\} "){" table)

    ;; Commas, semicolons, colons are punctuation
    (modify-syntax-entry ?, "." table)
    (modify-syntax-entry ?\; "." table)
    (modify-syntax-entry ?: "." table)

    ;; Operators like <, >, =, !, etc. are punctuation
    (dolist (c '(?< ?> ?= ?! ?& ?| ?~ ?^ ?% ?+ ?* ?/ ?\\))
      (modify-syntax-entry c "." table))

    ;; --- Strings: only double quotes "..." ---
    (modify-syntax-entry ?\" "\"" table)
    ;; Single quotes are NOT string delimiters in Thrift → treat as punctuation
    (modify-syntax-entry ?\' "." table)

    ;; --- Comments ---
    ;; // style: / is punctuation, but with special comment flags
    (modify-syntax-entry ?/ ". 124b" table)   ; can start // or /*, and help end */
    (modify-syntax-entry ?* ". 23" table)     ; for /* ... */

    ;; # style single-line comment
    (modify-syntax-entry ?# "< b" table)      ; starts comment until newline
    (modify-syntax-entry ?\n "> b" table)     ; newline ends # comment
    (modify-syntax-entry ?\r "> b" table)     ; also handle \r (for \r\n line endings)

    table)
  "Syntax table for Thrift (.thrift) files.")

;;;;
;;;; Semantic integration of the Thrift LALR parser
;;;;

(defun semantic-thrift-default-setup ()
  "Hook run to setup Semantic in `thrift-mode'.
Use the alternate LALR(1) parser."
  (semantic-thrift-wy--install-parser)
  (setq
   ;; Lexical analysis
   semantic-lex-number-expression semantic-java-number-regexp
   semantic-lex-analyzer #'semantic-thrift-lexer
   semantic-lex-syntax-table semantic-thrift-syntax-table
   semantic-lex-comment-regex "\\(\\s<\\|\\(?://+\\|/\\*+\\)\\s *\\)")
  ;; integration with imenu
  (setq-local imenu-create-index-function 'semantic-create-imenu-index)
  (add-hook 'completion-at-point-functions
            #'semantic-thrift-analyze-completion-at-point-function nil 'local))

(add-to-list 'semantic-new-buffer-setup-functions '(thrift-mode . semantic-thrift-default-setup))

(provide 'semantic-thrift)

;;; semantic-thrift.el ends here
