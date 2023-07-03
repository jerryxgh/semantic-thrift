# semantic-thrift

With `thrift-mode`, `semantic-thrift` support semantic level jumping of thrift.

Until now, there is no tag tool for `thrift` in emacs, `global` doesn't not support `thrift` currently, so I create this tiny project, through `wisent`, this project implement grammatical analysis of `thirft`, and through `semantic`, it's able to support semantic level jumping, such like jumping to definiton, even in different file.

## Installation
Until now `semantic-thrift` is not in melpa, so only manual installation is supported. Download `semantic-thrift` code and decompress it to where you wanted, add some code like below to emacs configuration:
```emacs-lisp
;; semantic-thrift depends on thrift-mode, so thrift-mode should be installed before going on. Just like this
;; (use-package thrift
;;   :ensure t)

(add-to-list 'load-path "<path to semantic-thrift>")
;; load semantic-thrift
(require 'semantic-thrift)
(with-eval-after-load 'semantic-thrift
  ;; enable semantic-mode when open thrift file
  (add-hook 'thrift-mode-hook (lambda () (semantic-mode 1)))
  ;; only thrift-mode use semantic, since at present most language use lsp instead of semantic
  (add-to-list 'semantic-inhibit-functions (lambda () (not (member major-mode '(thrift-mode)))))

  (if (bound-and-true-p evil-mode)
      ;; support evil-jump
      (define-key thrift-mode-map (kbd "M-.") 'evil-goto-definition)
    (define-key thrift-mode-map (kbd "M-.") 'semantic-ia-fast-jump))

  ;; thrift-mode syntax-table is too weak, it cann't process <> correctly
  (setq thrift-mode-syntax-table semantic-thrift-syntax-table))
```
