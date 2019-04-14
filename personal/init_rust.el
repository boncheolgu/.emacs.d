(prelude-require-packages
 '(lsp-ui company-lsp))

(push 'company-lsp company-backends)

(add-hook 'rust-mode-hook
          (lambda ()
            ;; (flycheck-mode)
            (lsp-ui-mode)
            (define-key rust-mode-map (kbd "C-c C-n") 'next-error)
            (define-key rust-mode-map (kbd "C-c C-p") 'previous-error)
            ;; (define-key rust-mode-map (kbd "M-i") 'helm-imenu)
            (define-key rust-mode-map (kbd "M-i") 'lsp-ui-imenu)
            (subword-mode)
            ))

(add-hook 'cargo-process-mode-hook
          (lambda ()
            (setq truncate-lines nil)
            ('ansi-color-for-comint-mode-on)
            ))

