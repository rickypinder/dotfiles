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

(setq vc-follow-symlinks t)

(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq default-frame-alist '((font . "Source Code Pro-14")))

(setq-default c-set-style "k&r")
(setq-default c-basic-offset 4)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package flatui-theme
  :config
  (load-theme 'flatui))

(use-package ivy
  :config
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1))
  
(use-package counsel
  :bind ("M-x" . counsel-M-x)
        ("C-x C-f" . counsel-find-file)
        ("C-h f" . counsel-describe-function)
        ("C-h v" . counsel-describe-variable)
        ("C-c g g" . counsel-git)
        ("C-c g f" . counsel-git-grep))

(use-package swiper
  :bind ("C-s" . swiper))

(use-package magit
  :bind ("C-c m" . magit-status))

(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("M-p" . ace-window))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package try)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (eval-after-load 'company
    '(add-to-list
      'company-backends '(company-irony company-irony-c-headers))))

(use-package irony-mode
  :config
  (defvar irony-mode-map)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)

  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))

  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony-c-headers)

(use-package flycheck
  :config
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package flycheck-irony
  :config
  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package counsel-gtags
  :config

  (add-hook 'c-mode-hook 'counsel-gtags-mode)
  (add-hook 'c++-mode-hook 'counsel-gtags-mode)

  (with-eval-after-load 'counsel-gtags
    (define-key counsel-gtags-mode-map (kbd "C-c t d") 'counsel-gtags-find-definition)
    (define-key counsel-gtags-mode-map (kbd "C-c t s") 'counsel-gtags-find-symbol)
    (define-key counsel-gtags-mode-map (kbd "C-c t r") 'counsel-gtags-find-reference)
    (define-key counsel-gtags-mode-map (kbd "C-c t f") 'counsel-gtags-find-file)
    (define-key counsel-gtags-mode-map (kbd "C-c t c") 'counsel-gtags-create-tags)
    (define-key counsel-gtags-mode-map (kbd "C-c t u") 'counsel-gtags-update-tags)
    (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward)
    (define-key counsel-gtags-mode-map (kbd "M-.") 'counsel-gtags-dwim)))

(use-package which-key
  :config
  (which-key-mode))
