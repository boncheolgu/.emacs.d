(prelude-require-packages
 '(rust-mode cargo lsp-mode lsp-rust company-lsp))

(require 'lsp-imenu)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

(setq rust-format-on-save t)

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook #'lsp-mode)
(add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (define-key rust-mode-map (kbd "<tab>") 'company-complete)
            (define-key rust-mode-map (kbd "C-c C-n") 'next-error)
            (define-key rust-mode-map (kbd "C-c C-p") 'previous-error)
            (define-key rust-mode-map (kbd "M-i") 'helm-imenu)
))

(with-eval-after-load 'lsp-mode
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
  (require 'lsp-flycheck)
  (require 'lsp-rust)

  (require 'company-lsp)

  ;; (push 'company-lsp company-backends)
)
