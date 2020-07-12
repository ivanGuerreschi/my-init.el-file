;; tell emacs to not initialize the package tool when it is loaded
(setq package-enable-at-startup nil)

;; load emacs' built-in package tool
(require 'package)

;; provide remote package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

;; tell built-in package tool to get started
(package-initialize)

;; Bootstrap `use-package': if not installed, refresh remotes, install it.
;; https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; for now accept that this is magic
(eval-when-compile
  (require 'use-package))

(setq user-full-name "Ivan Guerreschi"
  user-mail-address "IvanGuerreschi@protonmail.com")

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(tool-bar-mode -1)
(display-time-mode 1)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(setq confirm-nonexistent-file-or-buffer nil)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq-default initial-major-mode 'org-mode
      major-mode 'org-mode
      initial-scratch-message ""
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      mouse-yank-at-point t
      inhibit-startup-screen t
      package-check-signature nil
      )

(setq ring-bell-function 'ignore )

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(transient-mark-mode 1)
(setq cua-keep-region-after-copy t)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

(global-hl-line-mode 1)

(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark t))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

(require 'ido)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'allways)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))

(use-package nyan-mode
  :ensure t
  :init
  (nyan-mode t)
  (nyan-start-animation))

(use-package diminish
  :ensure t)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package paren
  :ensure t
  :config
  (show-paren-mode t))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  :diminish smartparens-mode)

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :diminish which-key-mode)

(use-package magit
  :ensure t
  :init
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package forge
  :ensure t
  :after magit)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode)
  :diminish undo-tree-mode)

(defun gnu-astyle ()
  (interactive)
  (shell-command-to-string
   (concat
    "astyle -s2 --style=gnu --pad-header --align-pointer=name --indent-col1-comments --pad-first-paren-out " (buffer-file-name)))
  (revert-buffer :ignore-auto :noconfirm))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (undo-tree forge magit which-key smartparens rainbow-delimiters smex diminish nyan-mode ido-vertical-mode powerline beacon solarized-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
