(prelude-require-packages
 '(julia-mode julia-repl))

(quelpa '(lsp-julia :fetcher github :repo "non-Jedi/lsp-julia"))

(add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
(add-hook 'julia-repl-hook #'julia-repl-use-emacsclient)
(add-hook 'julia-repl-hook #'lsp-mode)

