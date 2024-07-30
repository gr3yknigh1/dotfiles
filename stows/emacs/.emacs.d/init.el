;; @file ~/.emacs.d/init.el
;; @author Ilya Akkuzin <gr3yknigh1@gmail.com>
;; @copyright 2024 (c) Ilya Akkuzin <gr3yknigh1@gmail.com>, all rights reserved
;;
;; Basic settings

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
  :family "JetBrainsMono NF" :height 140)

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

;; Set "GNU" style indenting for C lang
(setq c-default-style "linux"
      c-basic-offset 4)

;; Number lines while in programming mode
;;(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode)
	    (setq display-line-numbers 'relative)))

(load-theme 'wombat)

;;;; Themes
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(custom-safe-themes
;;   '("3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" default))
;; '(package-selected-packages
;;   '(ivy lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )
;; 
;;(load-theme 'gruvbox-dark-medium t)
;;
;;(electric-pair-mode 1)
;;
;;;; Copy and paste
;;(cua-mode t)
;;(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;;(transient-mark-mode 1)               ;; No region when it is not highlighted
;;(setq cua-keep-region-after-copy t)   ;; Standard Windows behaviour(global-cua-moded)


;; =============================== Packaging configuration =================================== ;;

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



;;(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
;;    projectile hydra flycheck company avy which-key helm-xref dap-mode))
;;
;;(when (cl-find-if-not #'package-installed-p package-selected-packages)
;;  (package-refresh-contents)
;;  (mapc #'package-install package-selected-packages))

;; HELM

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
;;(helm-mode)
;;(require 'helm-xref)
;;(define-key global-map [remap find-file] #'helm-find-files)
;;(define-key global-map [remap execute-extended-command] #'helm-M-x)
;;(define-key global-map [remap switch-to-buffer] #'helm-mini)

;; LSP

;;(which-key-mode)
;;(add-hook 'c-mode-hook 'lsp)
;;(add-hook 'c++-mode-hook 'lsp)
;;
;;(setq gc-cons-threshold (* 100 1024 1024)
;;      read-process-output-max (* 1024 1024)
;;      treemacs-space-between-root-nodes nil
;;      company-idle-delay 0.0
;;      company-minimum-prefix-length 1
;;      lsp-idle-delay 0.1)  ;; clangd is fast
;;
;;(with-eval-after-load 'lsp-mode
;;  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;  (require 'dap-cpptools)
;;  (yas-global-mode))
;;
;;(setq lsp-keymap-prefix "\\")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(swiper ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
