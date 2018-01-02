(prelude-require-packages
 '(rust-mode cargo lsp-mode lsp-rust company-lsp))

(setq rust-format-on-save t)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(with-eval-after-load 'lsp-mode
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
  (require 'lsp-flycheck)
  (require 'lsp-rust)
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode))
(add-hook 'rust-mode-hook 'lsp-mode)
