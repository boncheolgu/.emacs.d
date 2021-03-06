(prelude-require-packages
 '(lsp-ui company-lsp flycheck-rust))

(push 'company-lsp company-backends)

(setq lsp-rust-server 'rust-analyzer)

(add-hook 'rust-mode-hook
          (lambda ()
            (setq rust-format-goto-problem nil)
            (setq rust-format-show-buffer nil)

            (lsp-ui-doc-mode -1)
            (setq lsp-file-watch-threshold 10000)

            (define-key rust-mode-map (kbd "C-c C-n") 'next-error)
            (define-key rust-mode-map (kbd "C-c C-p") 'previous-error)
            ;; (define-key rust-mode-map (kbd "M-i") 'helm-imenu)
            (define-key rust-mode-map (kbd "M-i") 'lsp-ui-imenu)
            (subword-mode)
            ))

(add-hook 'cargo-process-mode-hook
          (lambda ()
            (setq truncate-lines nil)
            (ansi-color-for-comint-mode-on)
            ))
