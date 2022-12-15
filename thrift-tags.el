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
(require 'semantic/java)
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

(define-mode-local-override semantic-get-local-variables
  thrift-mode ()
  "Get local values from a specific context.
Parse the current context for `field_declaration' nonterminals to
collect tags, such as local variables or prototypes.
This function override `get-local-variables'."
  (let ((vars nil)
        (ct (semantic-current-tag))
        ;; We want nothing to do with funny syntaxing while doing this.
        (semantic-unmatched-syntax-hook nil))
    (while (not (semantic-up-context (point) 'function))
      (save-excursion
        (forward-char 1)
        (setq vars
              (append (semantic-parse-region
                       (point)
                       (save-excursion (semantic-end-of-context) (point))
                       'field_declaration
                       0 t)
                      vars))))
    vars))

;;;
;;; Analyzer and type cache support
;;;
(define-mode-local-override semantic-analyze-split-name thrift-mode (name)
  "Split up tag names on colon . boundaries."
  (let ((ans (split-string name "\\.")))
    (if (= (length ans) 1)
        name
      (delete "" ans))))

(define-mode-local-override semantic-analyze-unsplit-name thrift-mode (namelist)
  "Assemble the list of names NAMELIST into a namespace name."
  (mapconcat #'identity namelist "."))



;;;;
;;;; Semantic integration of the Java LALR parser
;;;;

;; In semantic/imenu.el, not part of Emacs.
(defvar semantic-imenu-summary-function)

;;;###autoload
(defun wisent-thrift-default-setup ()
  "Hook run to setup Semantic in `thrift-mode'.
Use the alternate LALR(1) parser."
  (wisent-thrift-wy--install-parser)
  (setq
   ;; Lexical analysis
   semantic-lex-number-expression semantic-java-number-regexp
   semantic-lex-analyzer #'wisent-thrift-lexer
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
   semanticdb-find-default-throttle
   (remq 'recursive (default-value 'semanticdb-find-default-throttle))
   ))

(provide 'thrift-tags)

;;; thrift-tags.el ends here
