(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(winner-mode)

(load-theme 'leuven)

(setq create-lockfiles nil)

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

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-ise-virtual-buffers t))

(use-package counsel
  :ensure t
  :bind ("M-x" . counsel-M-x)
        ("C-x C-f" . counsel-find-file)
        ("C-h f" . counsel-describe-function)
        ("C-h v" . counsel-describe-variable)
        ("C-c g g" . counsel-git)
        ("C-c g f" . counsel-git-grep))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))
