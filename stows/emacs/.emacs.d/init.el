;;
;; FILE          ~/.emacs.d/init.el
;;
;; AUTHOR        Ilya Akkuzin <gr3yknigh1@gmail.com>
;;
;; NOTICE        Copyright 2024 (c) Ilya Akkuzin <gr3yknigh1@gmail.com>, all rights reserved
;;

(setq default-directory "P:\\")

;; Setting up shell
(setq explicit-shell-file-name "cmdproxy")
;; (setq explicit-shell-file-name "cmd")
;; (setq shell-command-switch "/c")
;; (setq w32-quote-process-args nil)


(add-to-list 'load-path "~/.emacs.d/lisp")

(global-auto-revert-mode t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-file "~/.emacs.d/themes/handmade-theme.el")
(load-theme 'handmade t)

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
;(toggle-truncate-lines)
(global-set-key (kbd "C-c w") 'toggle-truncate-lines)

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
(electric-pair-mode nil)

;; Grep mode
;; TODO(gr3yknigh1): Make it optional for GNU/Linux.
;; (setenv "PATH"
;;   (concat
;;    "C:\\cygwin64\\bin;"
;;    (getenv "PATH")))

(setq grep-command "git grep -rn ")
(setq grep-use-null-device nil)

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
(add-hook 'prog-mode-hook
	  (lambda ()
	    ;(setq display-line-numbers 'relative)
	    (display-line-numbers-mode -1)))

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
  ;; (load-theme 'gruvbox-dark-medium 0)
  )

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

(use-package lua-mode)

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
   "C-x f" 'find-file
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
   '("7e7555ba0d27f693b50e010008ae30ba7f50fc38063a79a4b62c24c22c027f9a" "4367dd3f99147ddeed82638dfdc017d1441ef9a26a98b526b38146b5b75ffd89" "6d08b8160529bdfd637859277c08ceeccb4a57cc743546ead6123ce08eb9879d" "a66d44c98db4b32bd71350c0666d1c754c943a4101228d84d88f6609adb2e4d6" "e9aa26ba271cdfa3172f5781a2e10647068a29c8c8538ed025ca05d37b5e2df9" "1805183d7af29f78bf429e3f5cdafc7168069206cad16658200df7058f76555f" "4388dba2d9f56323e3c5d80046850eeb193f12fb397f761f25ed3ef3c2ef0fc9" "d8deefb892ca1d8baf1b2151f8d7b844d206d0fc85bea392928a967ef0c6d938" "46b7037ec3abef9f3546672b81426295dd4d05e6dc0f8b997ea3115280a62809" "d8df605a1f45174a29b73c9e9edd9123be310c56abe8e1bfd7355d5c9087f28a" "cff624a732416c291300d86b3473fb65582d06d6b3d7f5429b23e9a539659d3c" "729eb49e632017d77c6f618c51c50411387f2159e85399193173c1e7d9ed316c" "d55a871f0eb1e2a610cee13c9e532b27539b5c881cebaaf985709d4021570832" "ef5c7f5d08e97f68828561ec9aa2fe45f6c89b9efe1d6879901b8d107c40045f" "e39a481e5dfac6e8f054d7a5f0a9b8044bbf107b7e3040b1aae80f69a0f774a8" "1ec56769d70b12a96eb5ec5175875fe61df7f6234833515bdf2f3ecf08b50a3d" "e102bbf40c6dfd2b5d750d79b8b64873c06e4004979ec5ad7293bd285146ab4f" "81e492f8223b3c908dd1308bbef732649125550647e9ad63b6e5b129b8a6ef99" "26f55148e26454baac0658ba32d7a6972b0b0193d785215ee12926f5c5a89576" "c48443a6c78268f0717e88b29236efdde15f1a06052dd531be7165c7c4136269" "4c61af87b66a806e7381cf8105722452588939138d20547a83b2c328b292b35c" "2a26fdea5daa44fa65fc905304d81274f1a3330ba375cee431156648968a8e7f" "d7cefd08c16695efd8ce882b2260411e4373a888ca0af7b79ef0cf7ff10959ba" "3e8d03e3f739d7d985e6c3050e06a54624457b987993ed1e176124a082a27235" "ca10674ccf34fe5f4d691c5b60fb0813d3f753b63f8dbede90ee4df909a3083c" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" default))
 '(package-selected-packages
   '(lua-mode general councel ivy-rich which-key rainbow-delimiters gruvbox-theme editorconfig cua-mode swiper doom-modeline diminish command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
