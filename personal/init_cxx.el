(prelude-require-packages
 '(cmake-ide rtags helm-rtags cmake-project))

(cmake-ide-setup)
;; Set cmake-ide-flags-c++ to use C++1z
(setq cmake-ide-flags-c++ (append '("-std=c++1z")))

(setq rtags-autostart-diagnostics t)
;; (rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(rtags-enable-standard-keybindings c-mode-base-map "C-x r ")
(rtags-enable-standard-keybindings)

(setq rtags-use-helm t)

(defun comatose/c-mode-hook ()
  ;; Compiling:
  (define-key c++-mode-map (kbd "C-c C-c") 'cmake-ide-compile)
  ;; Change compilation command:
  (setq compile-command "cmake --build build")

  ;; Enable Google style things
  ;; This prevents the extra two spaces in a namespace that Emacs
  ;; otherwise wants to put... Gawd!
  (google-set-c-style)

  ;; Autoindent using google style guide
  (google-make-newline-indent)

  ;; Enable hide/show of code blocks
  (hs-minor-mode)

  ;; (c-toggle-hungry-state 1)
  (subword-mode 1)
  ;; (global-cwarn-mode 1)

  (setq gdb-many-windows t)
  (setq gdb-show-threads-by-default t)

  ;; Force flycheck to always use c++1z support. We use
  ;; the clang language backend so this is set to clang
  (setq flycheck-clang-language-standard "c++1z")

  (add-hook 'before-save-hook 'clang-format-buffer nil t)

  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode))
)

(add-hook 'prelude-c-mode-common-hook 'comatose/c-mode-hook 1)

