;; Stops starting message
(setq inhibit-splash-screen t)

;; Set default font
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-14")

;; Maximize screen on startup
(add-hook 'window-setup-hook 'toggle-frame--maximized t)

;; Disable menu on startup
(menu-bar-mode -1)

;; Disable tools on startup
(tool-bar-mode -1)

;; Disable scroll
(scroll-bar-mode -1)

;; Set "GNU" style indenting for C lang
(setq c-default-style "linux"
      c-basic-offset 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" default))
 '(package-selected-packages '(gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
