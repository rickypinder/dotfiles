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

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq column-number-mode t)

(setq-default frame-title-format '("%b"))

(winner-mode)

(show-paren-mode)
(electric-pair-mode)

(setq vc-follow-symlinks t)

(setq-default indent-tabs-mode nil)

(setq tramp-default-method "ssh")

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq default-frame-alist '((font . "Source Code Pro-14")))

(setq-default c-set-style "k&r")
(setq-default c-basic-offset 4)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(defun rp/load-emacs ()
  "Load init.el."
  (interactive)
  (load-file "~/.emacs.d/init.el")
  (message "Reloaded init.el"))

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

(load-theme 'modus-operandi)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake 'nil))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode-hook . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (lsp-headerline-breadcrumb-mode -1))

(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-process-path-hie "hie-wrapper"))

(use-package lsp-java
  :ensure t
  :config
  (add-hook 'java-mode-hook #'lsp))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-magit
  :ensure t)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

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

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-normal-state-map "gr" 'lsp-find-references)
  (key-chord-define evil-normal-state-map "gd" 'lsp-find-definition))

(use-package haskell-mode
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode))

(use-package hindent
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode))

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

(use-package helm-xref
  :ensure t)

(use-package helm-swoop
  :ensure t
  :bind ("C-s". helm-swoop))

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
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'helm))

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

(use-package try
  :ensure t)

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("M-p" . ace-window))


(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java
  :ensure nil
  :after (lsp-java))

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil))

(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook 'lsp-deferred))

(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook #'lsp))

(use-package ocamlformat
  :ensure t
  :custom (ocamlformat-enable 'enable-outside-detected-project)
  :hook (before save . ocamlformat-before-save))

(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

(use-package tuareg
  :ensure t)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
