(add-to-list 'load-path
             (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path
             (expand-file-name "../.." (file-name-directory (or load-file-name (buffer-file-name)))))

(require 'semantic-thrift)

(when (featurep 'company)
  (setq company-semantic-modes '(thrift-mode))
  )

(setq thrift-indent-level 4)
(add-hook 'thrift-mode-hook (lambda ()
                              (semantic-mode 1)))
;; only thrift-mode use semantic, since at present most language use lsp instead of semantic
(add-to-list 'semantic-inhibit-functions (lambda () (not (member major-mode '(thrift-mode)))))

(if (bound-and-true-p evil-mode)
    ;; support evil-jump
    (define-key thrift-mode-map (kbd "M-.") 'evil-goto-definition)
  (define-key thrift-mode-map (kbd "M-.") 'semantic-ia-fast-jump))

;; thrift-mode syntax-table is too weak, it cann't process <> correctly
(setq thrift-mode-syntax-table semantic-thrift-syntax-table)
