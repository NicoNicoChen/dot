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

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind
  (("M-n" . flymake-goto-next-error)
   ("M-p" . flymake-goto-prev-error)))

(use-package evil
  :hook (after-init . evil-mode))

(use-package evil-escape
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package color-theme-sanityinc-tomorrow
  :hook (after-init . (lambda () (load-theme 'sanityinc-tomorrow-bright t))))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-minor-modes nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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

;;; init.el ends here
