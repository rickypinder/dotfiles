(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-linum-mode 1)
(global-hl-line-mode 1)

(add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))
(add-hook 'eshell-mode-hook (lambda () (set-window-fringes nil 0 0)))
(add-hook 'eshell-mode-hook (lambda () (global-hl-line-mode -1)))
(add-hook 'ruby-mode-hook (lambda () (global-rbenv-mode)))

(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "C-c g") 'magit-status)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(defvar org-log-done t)

(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-default nil)
 
(setq inhibit-startup-screen t)

(require 'package)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it's not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive descriptions
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

(ensure-package-installed 'evil
                          'evil-surround
                          'ido-vertical-mode
                          'org-bullets
                          'neotree
                          'smex
                          'ido-ubiquitous
                          'powerline
                          'airline-themes
                          'flycheck
                          'quickrun
                          'magit
                          'switch-window
                          'base16-theme
                          'rbenv
                          )

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'evil)
(evil-mode t)

(require 'evil-surround)
(global-evil-surround-mode 1)


(load-theme 'spacemacs-dark t)


(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'neotree)
(setq neo-theme 'ascii)
(global-set-key "\C-cn" 'neotree-toggle)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'powerline)                                ;;
;; (require 'airline-themes)                           ;;
;; (setq powerline-utf-8-separator-left        #xe0b0  ;;
;;       powerline-utf-8-separator-right       #xe0b2  ;;
;;       airline-utf-glyph-separator-left      #xe0b0  ;;
;;       airline-utf-glyph-separator-right     #xe0b2  ;;
;;       airline-utf-glyph-subseparator-left   #xe0b1  ;;
;;       airline-utf-glyph-subseparator-right  #xe0b3  ;;
;;       airline-utf-glyph-branch              #xe0a0  ;;
;;       airline-utf-glyph-readonly            #xe0a2  ;;
;;       airline-utf-glyph-linenumber          #xe0a1) ;;
;; (load-theme 'airline-base16-gui-dark t)             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(require 'tramp)

(setq package-enable-at-startup nil)

(require 'quickrun)

(require 'rbenv)
;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))
(setq rbenv-modeline-function 'rbenv--modeline-plain)

(ac-config-default)

(require 'google-translate)
(require 'google-translate-default-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "7790dbc91156dd9a5c7f2ee99e5f7e6549f244038b46ed6352d7693be2e0aec6" "0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "1b27e3b3fce73b72725f3f7f040fd03081b576b1ce8bbdfcb0212920aec190ad" "8ee0c6bcfe3105114a7855fa68a2dc083a5fe687f464cc6395c172fa2e10650f" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" default)))
 '(package-selected-packages
   (quote
    (spacemacs-theme helm spaceline switch-window smex rbenv quickrun org-bullets neotree magit ido-vertical-mode ido-ubiquitous google-translate flycheck exec-path-from-shell evil-surround dracula-theme base16-theme auto-complete airline-themes)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Meslo LG M DZ for Powerline" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal)))))


(put 'erase-buffer 'disabled nil)
