;;; init.el --- My Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-
;;; Commentary:
;;; Code:

(use-package use-package
  :ensure nil
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-expand-minimally t)
  (use-package-enable-imenu-support t))

(use-package package
  :ensure nil
  :custom
  (package-enable-at-startup nil)
  :config
  (setq package-quickstart t)
  (when (or (featurep 'esup-child)
	          (daemonp)
	          noninteractive)
    (package-initialize))
  (setq package-archives
	      '(("gnu" . "https://elpa.gnu.org/packages/")
	        ("melpa" . "https://melpa.org/packages/")
	        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
	        ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package emacs
  :ensure nil
  :config
  (setq-default tab-width 2))

(use-package simple
  :ensure nil
  :hook
  (after-init . size-indication-mode)
  (after-init . line-number-mode)
  (after-init . column-number-mode)
  :config
  (setq-default indent-tabs-mode nil))

(use-package loaddefs
  :ensure nil
  :hook
  (after-init . save-place-mode))

(use-package which-key
  :ensure nil
  :hook (after-init . which-key-mode))

(use-package ibuffer
  :ensure nil
  :bind (("C-x C-b" . ibuffer)))

(use-package cus-edit
  :ensure nil
  :init
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory)))

(use-package files
  :ensure nil
  :init
  (setq auto-save-default nil)
  (setq make-backup-files nil))

(use-package hl-line
  :ensure nil
  :hook (prog-mode . global-hl-line-mode))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . global-display-line-numbers-mode))

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package paren
  :ensure nil
  :hook (prog-mode . show-paren-mode))

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind
  (("M-n" . flymake-goto-next-error)
   ("C-c f" . flymake-show-buffer-diagnostics)
   ("M-p" . flymake-goto-prev-error)))

(use-package evil
  :hook (after-init . evil-mode)
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil))

(use-package evil-leader
  :hook (evil-mode . global-evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "<SPC>" 'execute-extended-command
    "tt" 'emacs-init-time
    "ff" 'find-file
    "fb" 'consult-buffer
    "bk" 'kill-buffer))

(use-package evil-escape
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package evil-collection
  :hook (evil-mode . evil-collection-init))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-visualstar
  :hook (evil-mode . global-evil-visualstar-mode))

(use-package evil-nerd-commenter
  :after evil
  :bind
  (:map evil-normal-state-map
        ("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map
        ("gc" . evilnc-comment-or-uncomment-lines)))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 15)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-minor-modes t))

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package indent-bars
  :hook ((python-mode yaml-mode) . indent-bars-mode)
  :config
  (setq indent-bars-color '(font-lock-comment-face :face-bg nil :blend 0.4))
  (setq indent-bars-highlight-current-depth '(:face default :blend 0.4))
  (setq indent-bars-pattern ".")
  (setq indent-bars-width-frac 0.1)
  (setq indent-bars-pad-frac 0.1)
  (setq indent-bars-color-by-depth nil)
  (setq indent-bars-no-descend-string t)
  (setq indent-bars-prefer-character t))

(use-package ligature
  :hook (prog-mode . global-ligature-mode)
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://")))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package colorful-mode
  :hook (prog-mode . global-colorful-mode))

(use-package dashboard
  :hook (after-init . dashboard-setup-startup-hook)
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-icon-type 'nerd-icons))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :config
  (setq nerd-icons-ibuffer-human-readable-size t))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package winum
  :hook (doom-modeline-mode . winum-mode))

(use-package flyover
  :hook (flymake-mode . flyover-mode)
  :config
  (setq flyover-checkers '(flymake))
  (setq flyover-background-lightness 60)
  (setq flyover-icon-background-tint-percent 50)
  (setq flyover-display-mode 'hide-on-same-line))

(use-package vertico
  :hook (after-init . vertico-mode)
  :bind (:map vertico-map
	            ("RET" . vertico-directory-enter)
	            ("DEL" . vertico-directory-delete-char)
	            ("M-DEL" . vertico-directory-delete-word))
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 17)
  (setq vertico-resize nil)
  (setq vertico-cycle t))

(use-package marginalia
  :hook (after-init . marginalia-mode))

(use-package nerd-icons-completion
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion))))
  (orderless-component-separator #'orderless-escapable-split-on-space))

(use-package consult
  :bind
  (("C-c M-x" . consult-mode-command)
   ("C-c h" . consult-history)
   ("C-c k" . consult-kmacro)
   ("C-c i" . consult-info)
   ("C-c r" . consult-ripgrep)
   ("C-c T" . consult-theme)
   ("C-." . consult-imenu)
   ("C-c c e" . consult-colors-emacs)
   ("C-c c w" . consult-colors-web)
   ("C-c c f" . describe-face)
   ("C-c c l" . find-library)
   ("C-c c t" . consult-theme)
   ([remap Info-search] . consult-info)
   ([remap isearch-forward] . consult-line)
   ([remap recentf-open-files] . consult-recent-file)
   ("C-x M-:" . consult-complex-command)
   ("C-x b" . consult-buffer)
   ("C-x 4 b" . consult-buffer-other-window)
   ("C-x 5 b" . consult-buffer-other-frame)
   ("C-x r b" . consult-bookmark)
   ("C-x p b" . consult-project-buffer)
   ("M-#" . consult-register-load)
   ("M-'" . consult-register-store)
   ("C-M-#" . consult-register)
   ("M-y" . consult-yank-pop)
   ("M-g e" . consult-compile-error)
   ("M-g f" . consult-flymake)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
   ("M-g o" . consult-outline)
   ("M-g m" . consult-mark)
   ("M-g k" . consult-global-mark)
   ("M-g i" . consult-imenu)
   ("M-g I" . consult-imenu-multi)
   ("M-s d" . consult-find)
   ("M-s D" . consult-locate)
   ("M-s g" . consult-grep)
   ("M-s G" . consult-git-grep)
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line)
   ("M-s L" . consult-line-multi)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ("M-s e" . consult-isearch-history)
   :map isearch-mode-map
   ("M-e" . consult-isearch-history)
   ("M-s e" . consult-isearch-history)
   ("M-s l" . consult-line)
   ("M-s L" . consult-line-multi)
   :map minibuffer-local-map
   ("M-s" . consult-history)
   ("M-r" . consult-history)))

(use-package corfu
  :hook
  (after-init . global-corfu-mode)
  (global-corfu-mode . corfu-popupinfo-mode)
  (global-corfu-mode . corfu-history-mode)
  :config
  (setq corfu-auto t)
  (setq corfu-auto-prefix 2)
  (setq corfu-count 12)
  (setq corfu-preview-current nil)
  (setq corfu-on-exact-match nil)
  (setq corfu-auto-delay 0.2)
  (setq corfu-popupinfo-delay '(0.4 . 0.2))
  (setq global-corfu-modes '((not erc-mode circe-mode help-mode gud-mode vterm-mode) t)))

(use-package nerd-icons-corfu
  :autoload nerd-icons-corfu-formatter
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :commands (cape-file cape-elisp-block cape-keyword)
  :autoload (cape-wrap-noninterruptible cape-wrap-nonexclusive cape-wrap-buster)
  :autoload (cape-wrap-silent)
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (advice-add 'lsp-completion-at-point :around #'cape-wrap-noninterruptible)
  (advice-add 'lsp-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add 'comint-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-nonexclusive))

(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package symbol-overlay
  :hook (prog-mode . symbol-overlay-mode)
  :custom-face
  (symbol-overlay-default-face ((t (:inherit region :background unspecified :foreground unspecified))))
  (symbol-overlay-face-1 ((t (:inherit nerd-icons-blue :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-2 ((t (:inherit nerd-icons-pink :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-3 ((t (:inherit nerd-icons-yellow :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-4 ((t (:inherit nerd-icons-purple :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-5 ((t (:inherit nerd-icons-red :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-6 ((t (:inherit nerd-icons-orange :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-7 ((t (:inherit nerd-icons-green :background unspecified :foreground unspecified :inverse-video t))))
  (symbol-overlay-face-8 ((t (:inherit nerd-icons-cyan :background unspecified :foreground unspecified :inverse-video t))))
  :bind
  (("M-i"  . symbol-overlay-put)
   ("M-r"  . symbol-overlay-remove-all)))

(use-package hl-todo
  :hook ((prog-mode yaml-mode) . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("HACK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package diff-hl
  :hook
  (prog-mode . global-diff-hl-mode)
  (dired-mode . diff-hl-dired-mode))

(use-package exec-path-from-shell
  :when (memq window-system '(mac ns x))
  :defer 10
  :config
  (exec-path-from-shell-initialize))

(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-h C-d" . helpful-at-point)))

(use-package xclip
  :hook (after-init . xclip-mode))

(use-package markdown-mode)
(use-package nix-mode)
(use-package vimrc-mode)
(use-package web-mode)
(use-package yaml-mode)
(use-package csv-mode)
(use-package json-mode)
(use-package toml-mode)
(use-package rust-mode)
(use-package go-mode)
(use-package haskell-mode)
(use-package clojure-mode)
(use-package emmet-mode)
(use-package typescript-mode)
(use-package scss-mode)
(use-package cmake-mode)
(use-package julia-mode)
(use-package scala-mode)
(use-package dart-mode)
(use-package powershell)

(use-package lua-mode
  :config
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(use-package dape
  :commands dape)

(use-package esup
  :commands esup
  :config
  (setq esup-depth 0))

(use-package eat
  :commands eat)

(use-package magit
  :commands magit)

(use-package vundo
  :commands vundo)

(use-package quickrun
  :commands quickrun)

(use-package avy
  :bind
  (("M-g l" . avy-goto-line)
   ("M-g w" . avy-goto-word-0)
   ("M-g c" . avy-goto-char-timer)))

(use-package format-all
  :bind (("C-c =" . format-all-region-or-buffer)))

(use-package ace-window
  :bind (([remap other-window] . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;;; init.el ends here
