(prelude-require-packages
 '(rust-mode cargo lsp-mode lsp-rust company-lsp))

(setq rust-format-on-save t)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(with-eval-after-load 'lsp-mode
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
  (require 'lsp-flycheck)
  (require 'lsp-rust)
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode)
  (define-key rust-mode-map (kbd "C-c C-b") 'cargo-process-build)
  (define-key rust-mode-map (kbd "C-c C-t") 'cargo-process-test)
  (define-key rust-mode-map (kbd "<tab>") 'company-complete)
  (define-key rust-mode-map (kbd "C-c C-n") 'next-error)
  (define-key rust-mode-map (kbd "C-c C-p") 'previous-error)
)

(add-hook 'rust-mode-hook 'lsp-mode)

