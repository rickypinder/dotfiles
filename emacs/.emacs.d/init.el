;;; init.el --- Emacs init file
;;; Commentary:
;                       $$\                 $$\
;                       \__|                $$ |
;    $$$$$$\   $$$$$$\  $$\ $$$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$\
;   $$  __$$\ $$  __$$\ $$ |$$  __$$\ $$  __$$ |$$  __$$\ $$  __$$\
;   $$ |  \__|$$ /  $$ |$$ |$$ |  $$ |$$ /  $$ |$$$$$$$$ |$$ |  \__|
;   $$ |      $$ |  $$ |$$ |$$ |  $$ |$$ |  $$ |$$   ____|$$ |
;   $$ |      $$$$$$$  |$$ |$$ |  $$ |\$$$$$$$ |\$$$$$$$\ $$ |
;   \__|      $$  ____/ \__|\__|  \__| \_______| \_______|\__|
;             $$ |
;             $$ |  https://github.com/rpinder/dotfiles/
;             \__|
;;; Code:

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq column-number-mode t)

(setq-default frame-title-format '("%b"))

(winner-mode)

(display-battery-mode 1)

(show-paren-mode)
(electric-pair-mode)

(setq vc-follow-symlinks t)

(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq default-frame-alist '((font . "Source Code Pro-14")))

(setq-default c-set-style "k&r")
(setq-default c-basic-offset 4)

(defun rp/load-emacs ()
  "Load init.el."
  (interactive)
  (load-file "~/.emacs.d/init.el")
  (message "Reloaded init.el"))

(global-set-key (kbd "C-c e") 'rp/load-emacs)

(defun rp/recompile ()
  "Recompiles from last compile command."
  (interactive)
  (recompile)
  (other-window 1))

(defun rp/setup-c-buffers ()
  "Keybindings for c buffers."
  (local-set-key (kbd "C-c a") 'ff-find-other-file)
  (local-set-key (kbd "C-c A") 'find-othe-file-in-other-window)
  (local-set-key (kbd "C-c c") 'rp/recompile))

(add-hook 'c-mode-hook 'rp/setup-c-buffers)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-magit
  :ensure t)

(use-package apropospriate-theme
  :ensure t
  :config
  (load-theme 'apropospriate-light))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("M-p" . ace-window))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package helm
  :ensure t
  :bind
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  ("C-x C-f" . helm-find-files)
  ("C-c v g" . helm-git-do-git-grep)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-display-header-line nil)
  (helm-autoresize-mode 1)
  (setq helm-autoresize-max-height 30)
  (setq helm-autoresize-min-height 30)
  (setq helm-split-window-inside-p t)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action))

(use-package helm-swoop
  :ensure t
  :bind ("C-s". helm-swoop))


(use-package helm-ls-git
  :ensure t
  :bind ("C-c v f" . helm-ls-git-ls))

(use-package helm-dash
  :ensure t
  :bind ("C-c h" . helm-dash-at-point)
  :config
  (setq helm-dash-browser-func 'eww)
  (setq helm-dash-common-docsets '("bash" "Emacs Lisp" "C" "python 3" "Javascript" "Haskell")))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'helm))

(use-package mingus
  :ensure t)

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

(use-package haskell-mode
  :ensure t)

(use-package hindent
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode))

;; (use-package company
;;   :ensure t
;;   :config
;;   (setq company-idle-delay 0.3)
;;   (global-company-mode 1)
;;   (global-set-key (kbd "C-<tab>") 'company-complete))

;; (use-package company-lsp
;;   :ensure t
;;   :commands company-lsp
;;   :config
;;   (push 'company-lsp company-backends)
;;   (setq company-transformers nil
;;         company-lsp-async t
;;         company-lsp-cache-candidates nil))

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp)
  :commands lsp)
  ;; :config
  ;; (setq lsp-prefer-flymake nil))
  ;; ;; (setq lsp-clients-clangd-executable "/usr/local/bin/clangd")
  ;; (setq lsp-clients-clangd-args '("-j=4" "-background-index", "-log=error")))

(use-package helm-xref
  :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :config

;;   (setq lsp-ui-doc-enable t
;;         lsp-ui-doc-use-childframe t
;;         lsp-ui-doc-position 'top
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-sideline-enable nil
;;         lsp-ui-flycheck-enable t
;;         lsp-ui-flycheck-list-position 'right
;;         lsp-ui-flycheck-live-reporting t
;;         lsp-ui-peek-enable t
;;         lsp-ui-peek-list-width 60
;;         lsp-ui-peek-peek-height 25)

;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;;; init.el ends here
