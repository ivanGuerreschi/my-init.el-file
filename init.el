;; tell emacs to not initialize the package tool when it is loaded
(setq package-enable-at-startup nil)

;; load emacs' built-in package tool
(require 'package)

;; provide remote package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
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
      user-mail-address "ivanguerreschi86@gmail.com")

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(tool-bar-mode -1)

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

(global-prettify-symbols-mode 1)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(display-time-mode 1)
(setq display-time-24hr-format t)

(use-package lsp-mode
  :ensure t
  :hook
  (('csharp-mode . lsp)))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package diminish
  :ensure t)

(use-package beacon
  :ensure t
  )

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark t))

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

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :diminish which-key-mode)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package web-mode
  :ensure t
  :mode (("\\.djhtml$" .  web-mode)
	 ("\\.html$" . web-mode)
	 ("\\.erb$" .  web-mode))
  :config
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2))

(use-package emmet-mode
  :ensure t
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode) 
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  )

(setq js-indent-level 2)

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

(use-package flycheck
  :ensure t
  :config
  (setq-default flycheck-disabled-checkers '(c/c++-clang))
  :init
  (global-flycheck-mode))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  :diminish company-mode)

(use-package elpy
  :ensure t
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args "-i --simple-prompt")
  :hook
  (elpy-mode . flycheck-mode)
  :init
  (elpy-enable))

(setq elpy-rpc-virtualenv-path 'current)

(use-package py-autopep8
  :ensure t
  :hook
  (elpy-mode . py-autopep8-enable-on-save))

(use-package blacken
  :ensure t
  :after elpy
  :hook
  (elpy-mode . blacken-mode)
  :diminish blacken-mode)

(use-package haml-mode
  :ensure t)

(add-hook 'rubocop-mode-hook
          (lambda ()
            (make-variable-buffer-local 'flycheck-command-wrapper-function)
            (setq flycheck-command-wrapper-function
                  (lambda (command)
                    (append '("bundle" "exec") command)))))

(use-package vterm
  :ensure t)

(use-package cider
  :ensure t)

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)

(use-package csharp-mode
  :ensure t)

(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-local-mode 1))

(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(defun gnu-astyle ()
  (interactive)
  (shell-command-to-string
   (concat
    "astyle -s2 --style=gnu --pad-header --align-pointer=name --indent-col1-comments --pad-first-paren-out " (buffer-file-name)))
  (revert-buffer :ignore-auto :noconfirm))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight normal :height 113 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(csharp-mode which-key web-mode vterm use-package undo-tree solarized-theme smex smartparens rubocop rainbow-delimiters py-autopep8 powerline nyan-mode ido-vertical-mode haml-mode forge flycheck emmet-mode elpy diminish cider blacken beacon auto-package-update async))
 '(semantic-c-dependency-system-include-path
   '("/usr/include" "/home/ivan/Development/C-Cpp/goldfish/src/lib")))
