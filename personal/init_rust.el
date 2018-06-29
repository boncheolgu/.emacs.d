(prelude-require-packages
 '(rust-mode cargo lsp-rust lsp-ui company-lsp racer company-racer))

(require 'rust-mode)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(push 'company-racer company-backends)

(add-hook 'rust-mode-hook 'cargo-minor-mode)
;; (add-hook 'rust-mode-hook #'lsp-mode)
;; (add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            ;; (define-key rust-mode-map (kbd "<tab>") 'company-complete)
            (define-key rust-mode-map (kbd "C-c C-n") 'next-error)
            (define-key rust-mode-map (kbd "C-c C-p") 'previous-error)
            (define-key rust-mode-map (kbd "M-i") 'helm-imenu)
            ;; (define-key rust-mode-map (kbd "M-i") 'lsp-ui-imenu)
            ;; (define-key rust-mode-map (kbd "TAB") #'completion-at-point)
            ;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
            (setq company-tooltip-align-annotations t)
            (define-key rust-mode-map (kbd "C-<tab>") #'racer-describe-tooltip)

            (setq rust-format-on-save t)

            ;; (require 'company-lsp)
            ;; (push 'company-lsp company-backends)
))
(add-hook 'rust-mode-hook 'subword-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'cargo-process-mode-hook (lambda () (setq truncate-lines nil)))
