;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start emacs server
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(server-start)

;; We don't want to type yes and no all the time so, do y and n
(defalias 'yes-or-no-p 'y-or-n-p)
;; Disable the horrid auto-save
(setq auto-save-default nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set packages to install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prelude-require-packages
 '(ace-window ag async auctex auto-complete clang-format
              cmake-mode company dash epl
              google-c-style helm helm-core helm-ls-git helm-ls-hg hungry-delete
              iedit let-alist levenshtein magit markdown-mode pkg-info
              popup seq solarized-theme switch-window vlf web-mode
              window-numbering writegood-mode yasnippet
              color-theme-sanityinc-solarized yaml-mode toml-mode quelpa smex
              dumb-diff dumb-jump))

(key-chord-unset-global "jl") ; for julia

(transient-mark-mode -1)

(setq flycheck-global-modes nil)

(setq delete-by-moving-to-trash t)

(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always t)
(defvar aw-dispatch-alist
  '((?0 aw-delete-window " Ace - Delete Window")
    (?m aw-swap-window " Ace - Swap Window")
    (?o aw-flip-window)
    (?c aw-split-window-fair " Ace - Split Fair Window")
    (?2 aw-split-window-vert " Ace - Split Vert Window")
    (?3 aw-split-window-horz " Ace - Split Horz Window")
    (?1 delete-other-windows " Ace - Maximize Window")
    (?b balance-windows))
  "List of actions for `aw-dispatch-default'.")

;; switch-window
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)

;; dumb-jump
(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-j .") 'dumb-jump-go)
(global-set-key (kbd "C-j ,") 'dumb-jump-back)

(setq switch-window-shortcut-style 'qwerty)
(setq switch-window-qwerty-shortcuts
      '("a" "s" "d" "f" "j" "k" "l" ";" "w" "e" "i" "o"))
(setq window-combination-resize t)

(setq default-input-method "korean-hangul")
;; (global-set-key (kbd "<Hangul>") 'toggle-input-method)
;; (global-set-key (kbd "S-SPC") 'toggle-input-method)

(custom-set-faces
 '(magit-diff-added ((t (:background "dark green"))))
 '(magit-diff-added-highlight ((t (:background "dark green")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use C-c h for helm instead of C-x c
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "<f1>") 'helm-select-action)

(setq
 helm-split-window-in-side-p           t
                                        ; open helm buffer inside current window,
                                        ; not occupy whole other window
 helm-move-to-line-cycle-in-source     t
                                        ; move to end or beginning of source when
                                        ; reaching top or bottom of source.
 helm-ff-search-library-in-sexp        t
                                        ; search for library in `require' and `declare-function' sexp.
 helm-scroll-amount                    8
                                        ; scroll 8 lines other window using M-<next>/M-<prior>
 helm-ff-file-name-history-use-recentf t
 ;; Allow fuzzy matches in helm semantic
 helm-semantic-fuzzy-match t
 helm-imenu-fuzzy-match    t)
;; Have helm automaticaly resize the window
(helm-autoresize-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up code completion with company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-company-mode)
(global-set-key (kbd "<M-tab>") 'company-complete-common)
(define-key company-active-map (kbd "C-n") #'company-select-next)
(define-key company-active-map (kbd "C-p") #'company-select-previous)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window numbering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package window-numbering installed from package list
;; Allows switching between buffers using meta-(# key)
(when (display-graphic-p)
  (window-numbering-mode t)
  )

;; Change tab key behavior to insert spaces instead
(setq-default indent-tabs-mode nil)

;; Set the number of spaces that the tab key inserts (usually 2 or 4)
(setq c-basic-offset 2)
;; Set the size that a tab CHARACTER is interpreted as
;; (unnecessary if there are no tab characters in the file!)
(setq tab-width 2)
;; Set python tab width...
(setq-default tab-width 2)
(setq-default python-indent 2)
;; (setq-default python-indent-offset 0)
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 2)))

;; We want to be able to see if there is a tab character vs a space.
;; global-whitespace-mode allows us to do just that.
;; Set whitespace mode to only show tabs, not newlines/spaces.
(setq whitespace-style '(tabs tab-mark))
;; Turn on whitespace mode globally.
(global-whitespace-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-log-done 'time
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "blue" :weight bold))))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Tweaks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq kill-whole-line t)
;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)
;; Overwrite region selected
(delete-selection-mode t)
;; Show column numbers by default
(setq column-number-mode t)
;; Prevent emacs from creating a bckup file filename~
(setq make-backup-files nil)
;; Show date and time in modeline
(display-time)
;; Settings for searching
(setq-default case-fold-search nil ;case sensitive searches by default
              search-highlight t) ;hilit matches when searching
;; Highlight the line we are currently on
(global-hl-line-mode 1)
;; Disable the toolbar at the top since it's useless
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load hungry Delete, caus we're lazy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set hungry delete:
(global-hungry-delete-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The deeper blue theme is loaded but the resulting text
;; appears black in Aquamacs. This can be fixed by setting
;; the font color under Menu Bar->Options->Appearance->Font For...
;; and then setting "Adopt Face and Frame Parameter as Frame Default"
(when window-system
  ;; (color-theme-sanityinc-solarized-dark)
  (load-theme 'sanityinc-solarized-dark)
  )

;; I don't care to see the splash screen
(setq inhibit-splash-screen t)

(when (display-graphic-p)
  ;; Set default window size and position
  (setq default-frame-alist
        '((top . 0) (left . 0) ;; position
          (width . 110) (height . 90) ;; size
          ))
  )

(unless (display-graphic-p)
  (setq linum-format "%d "))

;; Enable line numbers on the LHS
(global-linum-mode 1)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To get a bunch of extra snippets that come in super handy see:
;; https://github.com/AndreaCrotti/yasnippet-snippets
;; or use:
;; git clone https://github.com/AndreaCrotti/yasnippet-snippets.git ~/.emacs.d/yassnippet-snippets/
(yas-global-mode 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets/")
(yas-reload-all)

(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(custom-set-variables
 '(split-height-threshold 200))

(defun init-appearance (_)
  (set-scroll-bar-mode nil)  ;; Hide the scroll-bar

  ;; default font for English
  (set-face-attribute 'default nil :family "NanumGothicCoding")
  ;; default font for Korean
  (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
  )

(init-appearance nil)

;; Add the following hook, if spawned emacsclient windows have different appearance.
;; (add-to-list 'after-make-frame-functions #'init-appearance t)
(provide 'init)

;;; init.el ends here
