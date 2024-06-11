# semantic-thrift
[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](https://melpa.org/packages/semantic-thrift-badge.svg)](https://melpa.org/#/semantic-thrift)

With `thrift`, `semantic-thrift` support semantic level jumping of thrift.

Until now, there is no tag tool for `thrift` in emacs, `global` doesn't not support `thrift` currently, so I create this tiny project, through `wisent`, this project implement grammatical analysis of `thirft`, and through `semantic`, it's able to support semantic level jumping, such like jumping to definiton, even in different file by include.

## Installation
### From source
Because `semantic-thrift` depends on `thrift`, so `thrift` should be installed before going on. Then download `semantic-thrift` code and decompress it to where you wanted, add some code like below to emacs configuration:
```emacs-lisp
;; make sure semantic-thrift is in load-path:
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
### From MELPA
semantic-thrift is available on [MELPA](http://melpa.org/#/semantic-thrift), follow the [instructions](https://melpa.org/#/getting-started) to set up the repository.
Install `semantic-thrift` with `M-x package-install RET semantic-thrift RET`.
Then add the following:
```emacs-lisp
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

We recommend `use-package` like tools to manage package, like this:
```emacs-lisp
(use-package semantic-thrift
  :ensure t
  :config
  ;; enable semantic-mode when open thrift file
  (add-hook 'thrift-mode-hook (lambda () (semantic-mode 1)))
  ;; only thrift-mode use semantic, since at present most languages use lsp instead of semantic
  (add-to-list 'semantic-inhibit-functions (lambda () (not (member major-mode '(thrift-mode)))))

  (if (bound-and-true-p evil-mode)
      ;; support evil-jump
      (define-key thrift-mode-map (kbd "M-.") 'evil-goto-definition)
    (define-key thrift-mode-map (kbd "M-.") 'semantic-ia-fast-jump))

  ;; thrift-mode syntax-table is too weak, it cann't process <> correctly
  (setq thrift-mode-syntax-table semantic-thrift-syntax-table))
```
