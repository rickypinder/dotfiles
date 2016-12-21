(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-linum-mode 1)
(global-hl-line-mode 1)

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

(defun open-dotfile () (interactive)
       (find-file "~/dotfiles/emacs")
       (emacs-lisp-mode))

(add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))
(add-hook 'eshell-mode-hook (lambda () (set-window-fringes nil 0 0)))
(add-hook 'eshell-mode-hook (lambda () (global-hl-line-mode -1)))
(add-hook 'ruby-mode-hook (lambda () (global-rbenv-mode)))

(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x o") 'switch-window)

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
                          'flycheck
                          'quickrun
                          'magit
                          'switch-window
                          'rbenv
                          'spacegray-theme
                          'hlinum
                          'auto-complete
                          'auto-complete-c-headers
                          'pdf-tools
                          )

(load-theme 'spacegray t)

(ac-config-default)

(pdf-tools-install)

(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'evil)
(evil-mode t)
; I should just use a modeline plugin
(setq evil-mode-line-format '(before . mode-line-front-space))
(setq evil-normal-state-tag   (propertize " N " 'face '((:background "#343d46" :foreground "black")))
      evil-emacs-state-tag    (propertize " E " 'face '((:background "#C189EB" :foreground "black")))
      evil-insert-state-tag   (propertize " I " 'face '((:background "#B4EB90" :foreground "black")))
      evil-motion-state-tag   (propertize " M " 'face '((:background "green"   :foreground "black")))
      evil-visual-state-tag   (propertize " V " 'face '((:background "#DCA432" :foreground "black")))
      evil-operator-state-tag (propertize " O " 'face '((:background "#C189EB" :foreground "black"))))

(require 'evil-surround)
(global-evil-surround-mode 1)

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

(require 'hlinum)
(hlinum-activate)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Meslo LG M DZ for Powerline" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal))))
 '(linum-highlight-face ((t (:background "#343d46" :foreground "yellow")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1b27e3b3fce73b72725f3f7f040fd03081b576b1ce8bbdfcb0212920aec190ad" "64ca5a1381fa96cb86fd6c6b4d75b66dc9c4e0fc1288ee7d914ab8d2638e23a9" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" default)))
 '(package-selected-packages
   (quote
    (pdf-tools hlinum switch-window smex rbenv quickrun org-bullets neotree magit ido-vertical-mode ido-ubiquitous flycheck evil-surround base16-theme))))
