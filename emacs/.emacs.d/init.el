
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

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq column-number-mode t)

(winner-mode)

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
    (interactive)
    (load-file "~/.emacs.d/init.el")
    (message "Reloaded init.el"))

(global-set-key (kbd "C-c e") 'rp/load-emacs)

(defun rp/recompile ()
  (interactive)
  (recompile)
  (other-window 1))

(defun rp/setup-c-buffers ()
  (local-set-key (kbd "C-c a") 'ff-find-other-file)
  (local-set-key (kbd "C-c A") 'find-othe-file-in-other-window)
  (local-set-key (kbd "C-c c") 'rp/recompile))

(add-hook 'c-mode-hook 'rp/setup-c-buffers)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
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

(use-package hc-zenburn-theme
  :ensure t
  :config
  (load-theme 'hc-zenburn))

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

(use-package ycmd
  :ensure t
  :config 
  (add-hook 'c-mode-hook 'ycmd-mode)
  (add-hook 'c++-mode-hook 'ycmd-mode)
  (add-hook 'javascript-mode 'ycmd-mode)
  (set-variable 'ycmd-server-command `("python", (file-truename "~/ycmd/ycmd")))
  (set-variable 'ycmd-global-config (file-truename "~/.ycm_extra_conf.py")))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-show-numbers t))

(use-package company-ycmd
  :ensure t
  :config
  (company-ycmd-setup))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (when (not (display-graphic-p))
    (setq flycheck-indication-mode nil)))

(use-package flycheck-ycmd
  :ensure t
  :config
  (flycheck-ycmd-setup))

;;  (eval-after-load 'company
;;    '(add-to-list
;;    'company-backends '(company-irony company-irony-c-headers))))

;; (use-package irony
;;   :ensure t
;;   :config
;;   (defvar irony-mode-map)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'c++-mode-hook 'irony-mode)

;;   (defun my-irony-mode-hook ()
;;     (define-key irony-mode-map [remap completion-at-point]
;;       'irony-completion-at-point-async)
;;     (define-key irony-mode-map [remap complete-symbol]
;;       'irony-completion-at-point-async))

;;   (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; (use-package company-irony-c-headers
;;   :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :config
;;   (add-hook 'c++-mode-hook 'flycheck-mode)
;;   (add-hook 'c-mode-hook 'flycheck-mode)
;;   (add-hook 'after-init-hook #'global-flycheck-mode)
;;   (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; (use-package flycheck-irony
;;   :ensure t
;;   :config
;;   (eval-after-load 'flycheck
;;     '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

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
  (setq helm-split-window-in-side-p t)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action))

(use-package helm-swoop
  :ensure t
  :bind ("C-s". helm-swoop))

(use-package helm-gtags
  :ensure t
  :bind
  ("C-c g a" . helm-gtags-in-this-function)
  ("C-j" . helm-gtags-select)
  ("M-." . helm-gtags-dwim)
  ("M-," . helm-gtags-pop-stack)
  ("C-c <" . helm-gtags-previous-history)
  ("C-c >" . helm-gtags-next-history)
  :init
  (setq
   helm-gtags-ignore-case t
   helm-gtags-auto-update t
   helm-gtags-use-input-at-cursor t
   helm-gtags-pulse-at-cursor t
   helm-gtags-prefix-key "\C-c g"
   helm-gtags-suggested-key-mapping t)
  :config
  (add-hook 'dired-mode-hook 'helm-gtags-mode)
  (add-hook 'eshell-mode-hook 'helm-gtags-mode)
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'asm-mode-hook 'helm-gtags-mode))

(use-package helm-ls-git
  :ensure t
  :bind ("C-c v f" . helm-ls-git-ls))

(use-package helm-dash
  :ensure t
  :bind ("C-c h" . helm-dash-at-point)
  :config 
  (setq helm-dash-browser-func 'eww)
  (setq helm-dash-common-docsets '("bash" "Emacs Lisp" "C" "python_3" "Javascript")))

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
  (projectile-global-mode)
  (setq projectile-completion-system 'helm))

(use-package mingus
  :ensure t)

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))
