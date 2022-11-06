;;; thrift.el --- thrift parsing library -*- lexical-binding: t -*-

;; Copyright (C) 2022 Guanghui Xu
;;
;; Author: Guanghui Xu gh_xu@qq.com
;; Maintainer: Guanghui Xu gh_xu@qq.com
;; Created: 2022-10-17
;; Version: 0.0.1
;; Keywords: thrift
;; Homepage: not distributed yet
;; Package-Version: 0.0.1
;; Package-Requires: semantic
;;

;; This file is not part of GNU Emacs.

;;; Commentary:

;; thrift parsing

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'thrift)

;;; Change Log:

;; Version $(3) 2022-10-17 GuanghuiXu
;;   - Initial release

;;; Code:
(require 'thrift-wy)
(require 'semantic)

;; (define-mode-local-override semantic-tag-components thrift-mode (tag)
;;   "Return the children of tag TAG."
;;   (cond
;;    ((memq (semantic-tag-class tag)
;;          '(generic-node graph-attributes node link))
;;     (semantic-tag-get-attribute tag :attributes)
;;     )
;;    ((memq (semantic-tag-class tag)
;;          '(digraph graph))
;;     (semantic-tag-get-attribute tag :members)
;;     )))

;;;###autoload
(defun wisent-thrift-setup-parser ()
  "Setup buffer for parse."
  (thrift-wy--install-parser)

  (setq
   ;; Lexical Analysis
   semantic-lex-analyzer 'wisent-thrift-lexer
   ;; semantic-lex-syntax-modifications
   ;; '(
   ;;   (?- ".")
   ;;   (?= ".")
   ;;   (?, ".")
   ;;   (?> ".")
   ;;   (?< ".")
   ;;   )
   ;; Parsing
   ;; Environment
   semantic-imenu-summary-function 'semantic-format-tag-name
   imenu-create-index-function 'semantic-create-imenu-index
   ;; semantic-command-separation-character ";"
   ;; Speedbar
   ;; semantic-symbol->name-assoc-list
   ;; '((graph . "Graph")
   ;;   (digraph . "Directed Graph")
   ;;   (node . "Node")
   ;;   )
   ;; Navigation
   ;; senator-step-at-tag-classes '(graph digraph)
   ))

;;;###autoload
(add-hook 'thrift-mode-hook 'wisent-dot-setup-parser)

(provide 'thrift)

;;; thrift.el ends here
