# semantic-thrift

With thrift-mode, support semantic level jumping of thrift.

## Installation
Until now semantic-thrift is not in melpa, so only manual installation is allowed. Download semantic-mode code and decompress it to where you wanted, add some code like below:
```emacs-lisp
;; semantic-thrift depends on thrift-mode, please install thrift-mode like this
;; (use-package thrift
;;   :ensure t)

(add-to-list 'load-path "<path to semantic-thrift>")
;; load semantic-thrift
(evil-after-load "")
(require )
  (if (bound-and-true-p evil-mode)
      ;; support evil-jump
      (define-key thrift-mode-map (kbd "M-.") 'evil-goto-definition)
    (define-key thrift-mode-map (kbd "M-.") 'semantic-ia-fast-jump))
  (setq thrift-mode-syntax-table semantic-thrift-syntax-table))

(use-package thrift
  :ensure t
  :hook ((thrift-mode . (lambda () (semantic-mode 1))))
  :pin melpa
  :config
```
