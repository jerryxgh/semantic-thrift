;;; thrift-tags.el --- Thrift LALR parser for Emacs -*- lexical-binding: t -*-

;; Copyright (C) 2022 Guanghui Xu
;;
;; Author: Guanghui Xu gh_xu@qq.com
;; Maintainer: Guanghui Xu gh_xu@qq.com
;; Created: 2022-11-29
;; Version: 0.0.1
;; Keywords:
;; Homepage: not distributed yet
;; Package-Version: 0.0.1
;; Package-Requires:
;;

;; This file is not part of GNU Emacs.

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'thrift-tags)

;;; Change Log:

;; Version $(3) 2022-11-29 GuanghuiXu
;;   - Initial release

;;; Code:

;; (add-to-list 'load-path "/Users/bytedance/repository/public/lambda-thrift")
;; (require 'thrift-wy)
;; (require 'thrift-tags)
;; (add-to-list 'semantic-new-buffer-setup-functions '(thrift-mode . wisent-thrift-default-setup))

(require 'semantic/wisent)
(require 'semantic/ctxt)
(require 'semantic/tag-file)
(require 'semantic/analyze)
(require 'semantic/java)
(require 'semantic/db-typecache)
(require 'cc-mode)
(require 'thrift-wy)
(require 'thrift)

;;;;
;;;; Simple parser error reporting function
;;;;

(defun wisent-thrift-parse-error (msg)
  "Error reporting function called when a parse error occurs.
MSG is the message string to report."
;;   (let ((error-start (nth 2 wisent-input)))
;;     (if (number-or-marker-p error-start)
;;         (goto-char error-start)))
  (message msg)
  ;;(debug)
  )

;;;;
;;;; Local context
;;;;

;; (define-mode-local-override semantic-get-local-variables
;;   thrift-mode ()
;;   "Get local values from a specific context.
;; Parse the current context for `field_declaration' nonterminals to
;; collect tags, such as local variables or prototypes.
;; This function override `get-local-variables'."
;;   (let ((vars nil)
;;         (ct (semantic-current-tag))
;;         ;; We want nothing to do with funny syntaxing while doing this.
;;         (semantic-unmatched-syntax-hook nil))
;;     (while (not (semantic-up-context (point) 'function))
;;       (save-excursion
;;         (forward-char 1)
;;         (setq vars
;;               (append (semantic-parse-region
;;                        (point)
;;                        (save-excursion (semantic-end-of-context) (point))
;;                        'field_declaration
;;                        0 t)
;;                       vars))))
;;     vars))

;;;
;;; Analyzer and type cache support
;;;
;; (define-mode-local-override semantic-analyze-split-name thrift-mode (name)
;;   "Split up tag names on colon . boundaries."
;;   (let ((ans (split-string name "\\.")))
;;     (if (= (length ans) 1)
;;         name
;;       (delete "" ans))))

;; (define-mode-local-override semantic-analyze-unsplit-name thrift-mode (namelist)
;;   "Assemble the list of names NAMELIST into a namespace name."
;;   (mapconcat #'identity namelist "."))

(define-mode-local-override semantic-dependency-tag-file thrift-mode (tag)
  "Find the filename represented from TAG."
  (unless (semantic-tag-of-class-p tag 'include)
    (signal 'wrong-type-argument (list tag 'include)))

  (let ((tfile (semantic-tag-include-filename tag)))
    (if (and (string-prefix-p "\"" tfile) (string-suffix-p "\"" tfile))
        (expand-file-name (substring tfile 1 -1) (file-name-directory (semantic-tag-file-name tag)))
        (expand-file-name tfile (file-name-directory (semantic-tag-file-name tag)))
      )))

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
  ;; (message "semantic-analyze-find-tag-sequence,sequence:%S" sequence)
  (semantic-analyze-find-tag-sequence-default (last sequence) scope typereturn throwsym flags))

(define-mode-local-override semanticdb-typecache-find thrift-mode (type &optional path find-file-match)
  "Search the typecache for TYPE in PATH.
If type is a string, split the string, and search for the parts.
If type is a list, treat the type as a pre-split string.
PATH can be nil for the current buffer, or a semanticdb table.
FIND-FILE-MATCH is non-nil to force all found tags to be loaded into a buffer."
  ;; (message "semanticdb-typecache-find,type:%S,stringp:%S" type (stringp type))
  (let ((result (semanticdb-typecache-find-default type path find-file-match)))
    (message "semanticdb-typecache-find,result:%S" result)
    (if result result
      (dolist (ele (semantic-find-tags-by-class 'include semanticdb-current-table) result)
        (if (or (and (listp type) (equal (car type)(semantic-tag-get-attribute ele :alias)))
                (and (stringp type) (equal type (semantic-tag-get-attribute ele :alias))))
            (setq result ele)))
      )
    result))

(setq-mode-local thrift-mode
                 semanticdb-find-default-throttle
                 '(local recursive project unloaded system))

;;;;
;;;; Semantic integration of the Java LALR parser
;;;;

;; In semantic/imenu.el, not part of Emacs.
(defvar semantic-imenu-summary-function)

;;;###autoload
(defun wisent-thrift-default-setup ()
  "Hook run to setup Semantic in `thrift-mode'.
Use the alternate LALR(1) parser."
  (message "running_wisent-thrift-default-setup")
  (wisent-thrift-wy--install-parser)
  (setq
   ;; Lexical analysis
   semantic-lex-number-expression semantic-java-number-regexp
   semantic-lex-analyzer #'wisent-thrift-lexer
   semantic-lex-syntax-table java-mode-syntax-table
   semantic-lex-comment-regex "\\(//[^\\n]*\\)\\|\\(#[^\n]*\\)"
   ;; Parsing
   ;; semantic-tag-expand-function #'semantic-java-expand-tag
   ;; Environment
   ;; semantic-imenu-summary-function #'semantic-format-tag-prototype
   ;; imenu-create-index-function #'semantic-create-imenu-index
   ;; semantic-type-relation-separator-character '(".")
   ;; semantic-command-separation-character ";"
   ;; speedbar and imenu buckets name
   ;; semantic-symbol->name-assoc-list-for-type-parts
   ;; ;; in type parts
   ;; '((type     . "Classes")
   ;;   (variable . "Variables")
   ;;   (function . "Methods"))
   ;; semantic-symbol->name-assoc-list
   ;; ;; everywhere
   ;; (append semantic-symbol->name-assoc-list-for-type-parts
   ;;         '((include  . "Imports")
   ;;           (package  . "Package")))
   ;; navigation inside 'type children
   ;; senator-step-at-tag-classes '(function variable)
   ;; Remove 'recursive from the default semanticdb find throttle
   ;; since java imports never recurse.
   semanticdb-find-default-throttle (remq 'recursive (default-value 'semanticdb-find-default-throttle))
   ))

(provide 'thrift-tags)

;;; thrift-tags.el ends here
