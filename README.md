# lambda-thrift

A semantic plugin for thrift parsing, to support semantic level jumping and completion.


## Installation
```emacs-lisp
(add-to-list 'load-path "path to lambda-thrift-wy.el lambda-thrift-tags.el ")
(require 'lambda-thrift-tags)
(use-package thrift
  :ensure t
  :bind (:map thrift-mode-map ("M-." . semantic-ia-fast-jump))
  :custom
  (thrift-indent-level 4)
  (thrift-mode-syntax-table lambda-thrift-syntax-table)
  :hook (('thrift-mode . (lambda ()
                           (semantic-mode 1)
                           (if (featurep 'evil)
                               (setq evil-goto-definition-functions
                                     '(evil-goto-definition-imenu
                                       evil-goto-definition-semantic
                                       evil-goto-definition-search)))))))
```
