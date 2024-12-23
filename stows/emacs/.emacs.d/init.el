;; @file ~/.emacs.d/init.el
;; @author Ilya Akkuzin <gr3yknigh1@gmail.com>
;; @copyright 2024 (c) Ilya Akkuzin <gr3yknigh1@gmail.com>, all rights reserved
;;
;; Basic settings

(setq default-directory "P:\\")

;; Setting up shell
(setq explicit-shell-file-name "cmdproxy")
;; (setq explicit-shell-file-name "cmd")
;; (setq shell-command-switch "/c")
;; (setq w32-quote-process-args nil)

(setq dired-listing-switches "-aBhl  --group-directories-first")

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Bind zoom keys
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(global-set-key [?\C-\=] 'text-scale-increase)
(global-set-key [?\C-\-] 'text-scale-decrease)

;; Stops starting message
(setq inhibit-splash-screen t)

;; TODO(gr3yknigh1): Add platform-dependent configuration [2024/07/30]
;; Set default font
;; Linux:
;;(set-face-attribute 'default nil
;;  :font "JetBrainsMono Nerd Font-14")  
;; Windows
;; TODO(gr3yknigh1): Check if this is working on Linux [2024/07/29]
(set-face-attribute 'default nil
  ;;:family "JetBrainsMono NF" :height 140)
  :family "Iosevka NF" :height 120)

;; Word wrap
(setq word-wrap 1)
;; (toggle-word-wrap)

;; Maximize screen on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable menu on startup
(menu-bar-mode -1)

;; Disable tools on startup
(tool-bar-mode -1)

;; Disable tooltip-mode on startup
(tooltip-mode -1)

;; Disable scroll
(scroll-bar-mode -1)

;; Disable visible bell
(setq visible-bell t)

;; Display whitespace
(global-whitespace-mode -1)

;; Makes ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Pair mode
(electric-pair-mode 1)

;; Grep mode
;; TODO(gr3yknigh1): Make it optional for GNU/Linux.
;; (setenv "PATH"
;; 	(concat
;; 	 "C:\\cygwin64\\bin;"
;; 	 (getenv "PATH")))

;; Set "GNU" style indenting for C lang
(setq c-default-style "linux"
      c-basic-offset 4)

;; Copy & paste

;; NOTE(gr3yknigh1): Conflicts with evil mode's visual C-v. [2024/08/03]
;;(cua-mode t)
;;(setq cua-auto-tabify-rectangles nil)
;;(transient-mark-mode 1)
;;(setq cua-keep-region-after-copy t)

;; Number lines while in programming mode
;;(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode)
	    (setq display-line-numbers 'relative)))

;; Yaml mode (should be inside ~/.emacs.d/)
;; Source: https://github.com/yoshiki/yaml-mode

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(require 'cmake-mode)

;; Packaging configuration

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
;; NOTE(gr3yknigh1): One of the way to list package archives
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)  ;; NOTE(gr3yknigh1): Ensures if all required packages installed (they will be "ensured")

(use-package diminish)
(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init (ivy-mode 1))

(use-package swiper
  :diminish
  :bind(("C-s" . swiper)))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x C-b" . counsel-switch-buffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)
  ;; Second bind for buffer switching
  ;; TODO(gr3yknigh1): Deside leave that or remove [2024/07/30]
  (global-set-key (kbd "C-M-j") 'counsel-switch-buffer))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-define-key
   "C-x g" 'grep
   "C-x f" 'grep-find
   "C-x s" 'counsel-grep-or-swiper))

;; (use-package undo-tree
;;   :config
;;   (global-undo-tree-mode)
;;   (setq evil-undo-system 'undo-tree))

(use-package evil
  :init
  ;; (setq evil-undo-system 'undo-tree)  ;; NOTE: Is this okey?

  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  (setq evil-auto-balance-windows t)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)

  (setq evil-want-C-u-scroll nil)
  (setq evil-want-C-i-jump nil)
  ;; :hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-set-initial-state 'eshell-mode 'insert)  ;; NOTE: Unable to change?
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" default))
 '(package-selected-packages
   '(general councel ivy-rich which-key rainbow-delimiters gruvbox-theme editorconfig cua-mode swiper doom-modeline diminish command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
