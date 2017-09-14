;;
;;
;; RPINDER INIT.EL FILE
;;   http://github.com/rpinder
;;
;

;; last edited: 2017/08/10

;; TODO
;; + email inside emacs
;; + set up eirc
;; + latex environment - learn latex
;; + set up rtags or something similar

;-------------------------------------------------------------------------------

;; remove useless (to me) clutter
;;   I have this here so I don't see them when emacs is loading
(menu-bar-mode -1)
(tool-bar-mode -1)      ;; so turning them off isn't needed
(scroll-bar-mode -1)

(setq custom-file "~/.emacs.d/custom.el") ;; I don't want the custom stuff 
(load custom-file)                        ;; inside this file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          AUTOMATIC PACKAGE INSTALLATION
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This code is from the "Automatically installing Packages" section of the
;; "From Vim to Emacs in Fourteen Days article by Arron Bieber posted on May
;; 24th 2015

;; http://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it's not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
         (package-install package)))
   packages))

;; Make sure to have downloaded archive descriptions
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(package-initialize)

(ensure-package-installed
 'ido-completing-read+
 'ido-vertical-mode
 'org-bullets
 'smex
 'flycheck
 'quickrun
 'magit
 'rbenv
 ;; 'nlinum-relative
 ;; 'key-chord
 'which-key
 'github-browse-file
 'yasnippet
 'smooth-scrolling
 'company
 'irony
 'company-irony
 'company-c-headers
 'flycheck-irony
 'fiplr
 'shell-pop
 ;; 'dashboard
 'pyenv-mode
 ;; 'evil
 ;; 'evil-surround
 'company-jedi
 'exec-path-from-shell
 'rainbow-mode
 'diminish
 'gruvbox-theme
 'ace-window
 'avy
 'simple-mpc
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          UI CONFIG
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'gruvbox)

(show-paren-mode)           ;; highlights matching parens

(setq column-number-mode t) ;; puts column number in the mode line

;; puts a space between number line and window border
(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

(setq inhibit-startup-screen t) ;; disables emacs start screen

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;           CUSTOM FUNCTIONS 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; opens emacs configuration file
(defun rp/open-dotfile ()
  " Opens the file ~/dotfiles/emacs/.emacs.d/init.el "
  (interactive)
  (find-file "~/dotfiles/emacs/.emacs.d/init.el"))

(defun rp/open-dotfile-other-window ()
  " Opens the file ~/dotfiles/emacs/.emacs.d/init.el in another window "
  (interactive)
  (find-file-other-window "~/dotfiles/emacs/init.el")
  (previous-multiframe-window))

;; opens zsh configuration fil
(defun rp/open-zsh ()
  " Opens the file ~/dotfiles/zshrc/.zshrc"
  (interactive)
  (find-file "~/dotfiles/zsh/.zshrc"))

(defun rp/open-zsh-other-window ()
  " Opens the file ~/dotfiles/zsh/zshrc in another window "
  (interactive)
  (find-file-other-window "~/dotfiles/zsh/.zshrc")
  (previous-multiframe-window))

;; loads the emacs initialization file
(defun rp/load-emacs ()
  " loads the emacs configuration file "
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; This turns off line numbers and line highlighting,
;; and also gets rid of the fringe
(defun rp/setup-eshell ()
  " sets up eshell by
  removing line numbers
  removng fringes
  turning off line highlghting "
  (nlinum-mode -1)
  (set-window-fringes nil 0 0 ))

;; Inserts comment subheadings like the ones in the PACKAGE CONFIG section
;; This is probably done horribly, tell me how to improve it
(defun rp/sub-comment ()
  " Inserts elisp comment sub-headings "
  (interactive)
  (let ((x (read-string "Enter comment: ")))
    (message "inserting subheading comment with the text: %s." x)
    (insert ";;----------------------------------------------------------\n")
    (insert ";;          " x "\n")
    (insert ";;----------------------------------------------------------\n")))

;; inserts comment headings such as "HOOKS" or "CUSTOM FUNCTIONS"
(defun rp/heading-comment ()
  " Inserts elisp comment headings "
  (interactive)
  (let ((x (read-string "Enter comment: ")))
    (message "inserting heading comment with the test: %s." x)
    (insert ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n")
    (insert ";;\n")
    (insert ";;          " x "\n"))
  (insert ";;\n")
  (insert ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"))

(defun rp/find-other-file-in-other-window ()
  " opens corresponding .c, .cpp, .h, .hpp etc file in other window "
  (interactive)
  (ff-find-other-file t nil)
  (previous-multiframe-window))

(defun rp/scroll-other-window-two ()
  " scrolls the other window by 2 lines "
  (interactive)
  (scroll-other-window 2))

(defun rp/scroll-other-window-down-two ()
  " scrolls the other window down by 2 lines "
  (interactive)
  (scroll-other-window-down 2))

;; setup emacs for prog buffers
(defun rp/setup-prog-buffers ()
  " enables line highlighting and line numbers for programming buffers "
  ;; (nlinum-mode 1)
  ;; (nlinum-relative-mode 1)
  (electric-pair-local-mode))

(defun rp/setup-c-buffers ()
  " enables c local key binds "
  (local-set-key (kbd "C-c c a") 'ff-find-other-file)
  (local-set-key (kbd "C-c c A") 'find-other-file-in-other-window))

;; launches a live markdown preview of the current file
;; This sort of works? I would like for it to be ran outside of emacs but I am
;; not sure how to do that
(defun rp/launch-vmd ()
  " launches a live markdown preview of the currnent file using vmd "
  (interactive)
  (shell-command (concat "vmd " (buffer-file-name) " &")))

(defun rp/window-left-to-right (prefix)
  " moves window from the left of the screen to the right of the screen "
  (interactive "p")
  (other-window 1)
  (delete-window)
  (split-window-right)
  (switch-to-buffer (other-buffer)))

(defun rp/window-right-to-left (prefix)
  " moves window from the right of the screen to the left of the screen "
  (interactive "p")
  (delete-window)
  (split-window-right)
  (switch-to-buffer (other-buffer))
  (other-window 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          HOOKS 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; makes the eshell experience more pleasant
(add-hook 'eshell-mode-hook  'rp/setup-eshell)

(add-hook 'prog-mode-hook 'rp/setup-prog-buffers)

(add-hook 'c-mode-common-hook 'rp/setup-c-buffers)

;; (add-hook 'simple-mpc-mode-hook (lambda()
;;                                   (evil-emacs-state)))

;; (add-hook 'simple-mpc-query-mode-hook (lambda()
;;                                   (evil-emacs-state)))

;; (add-hook 'simple-mpc-current-playlist-mode-hook (lambda()
;;                                   (evil-emacs-state)))

;; turns off yas-minor-mode for term-mode buffers so tab completion works
(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          CUSTOM KEYBINDS 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; line is automatically indented
(define-key global-map (kbd "RET") 'newline-and-indent)

;; C-c o(pen)  use shift to open that file in another window
(global-set-key (kbd "C-c o d") 'rp/open-dotfile)
(global-set-key "\C-co\S-d" 'rp/open-dotfile-other-window)

(global-set-key (kbd "C-c o z") 'rp/open-zsh)
(global-set-key "\C-co\S-z" 'rp/open-zsh-other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          MISCELLANEOUS  
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use spaces for indenting
(setq-default indent-tabs-mode nil)

;; put all backups into one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; stop emacs from autosaving
(setq auto-save-default nil)

;; always follow symlinks
(setq vc-follow-symlinks t)

(setq initial-scratch-message (concat ";; " emacs-version)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          PACKAGE CONFIG  
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;----------------------------------------------------------
;;          COMPANY-MODE
;;----------------------------------------------------------

;; load company mode after emacs has initialized
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; start irony-mode when these file-types are open
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; make the autocomplete window appear faster
(setq company-idle-delay 0.1)

;; show numbers in completion window
(setq company-show-numbers t)

;; use irony-mode as a backend for company
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; autocomplete c header files
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-c-headers))

;; use jedi as a backend for company
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-jedi))

;;----------------------------------------------------------
;;          EVIL
;;----------------------------------------------------------

;; ;; enables evil mode
;; (setq evil-want-C-u-scroll t)
;; (require 'evil)
;; (evil-mode t)

;; (setq evil-mode-line-format '(before . mode-line-front-space))
;;     (setq evil-normal-state-tag   (propertize " N ")
;;           evil-emacs-state-tag    (propertize " E ")
;;           evil-insert-state-tag   (propertize " I ")
;;           evil-motion-state-tag   (propertize " M ")
;;           evil-visual-state-tag   (propertize " V ")
;;           evil-replace-state-tag  (propertize " R ")
;;           evil-operator-state-tag (propertize " N "))

;; ;; enables an evil port of tpope's surround.vim plugin
;; (require 'evil-surround)
;; (global-evil-surround-mode 1)

;; (define-key evil-normal-state-map "\S-k" 'rp/scroll-other-window-down-two)
;; (define-key evil-normal-state-map "\S-j" 'rp/scroll-other-window-two)


;; ;; I never use vim arrow keys so these get in the way of useful
;; ;; things such as snake and tetris
;; (define-key evil-motion-state-map (kbd "<left>")  nil)
;; (define-key evil-motion-state-map (kbd "<down>")  nil)
;; (define-key evil-motion-state-map (kbd "<up>")    nil)
;; (define-key evil-motion-state-map (kbd "<right>") nil)

;;----------------------------------------------------------
;;          INTERACTIVELY DO THINGS (ido)
;;----------------------------------------------------------

;; enable ido-mode
(require 'ido)
(ido-mode 1)

;; display results vertically
(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;; use C-n and C-p to navigate results
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; if the entered string does not match any item, any item containing the
;; entered characters in the given sequence will match.
(setq ido-enable-flex-matching t)

;; use ido whereever possible
(setq ido-everywhere t)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

;; M-x enhancement for emacs built on top of ido
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key "\C-x\S-f" 'ido-find-file-other-window)
(global-set-key "\C-x\S-b" 'ido-switch-buffer-other-window)

;;----------------------------------------------------------
;;         FLYCHECK 
;;----------------------------------------------------------

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disables something annoying
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; use irony-mode flycheck checker for C, C++ and Objective-C
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;----------------------------------------------------------
;;          TRAMP
;;----------------------------------------------------------

(require 'tramp)

;;----------------------------------------------------------
;;          QUICKRUN
;;----------------------------------------------------------

(require 'quickrun)

;;----------------------------------------------------------
;;          RBENV
;;----------------------------------------------------------

(require 'rbenv)

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME")
                       "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; removes the colors in the mode-line
(setq rbenv-modeline-function 'rbenv--modeline-plain)

;;----------------------------------------------------------
;;          Line numbers
;;----------------------------------------------------------

;; (require 'nlinum-relative)
;; (setq nlinum-relative-redisplay-delay 0)
;; (setq nlinum-relative-current-symbol "")
;; (setq nlinum-relative-offset 0)

;;----------------------------------------------------------
;;          KEY-CHORD
;;----------------------------------------------------------

;; (require 'key-chord)
;; (key-chord-mode 1)

;; ;; mashing jk when in evil insert mode will put me into normal mode
;; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;;----------------------------------------------------------
;;          ACE-WINDOW
;;----------------------------------------------------------

(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;----------------------------------------------------------
;;          AVY
;;----------------------------------------------------------

(global-set-key (kbd "C-;") 'avy-goto-word-1)

;;----------------------------------------------------------
;;          WHICH-KEY
;;----------------------------------------------------------

;; displays keybindings following your currently entered incomplete command
(require 'which-key)
(which-key-mode)

;;----------------------------------------------------------
;;          ORG MODE
;;----------------------------------------------------------

;; each time you turn an entry from a TODO state into a DONE state a line
;; 'CLOSED: [timestamp] will be inserted just after the headline
(defvar org-log-done 'time)

;; show org-mode bullets as UTF-8 characters
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;----------------------------------------------------------
;;          YASNIPPET
;;----------------------------------------------------------

;; template system for emacs
(require 'yasnippet)
(yas-global-mode 1)

;;----------------------------------------------------------
;;          SMOOTH SCROLLING
;;----------------------------------------------------------

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

;; screen with scroll when the cursor reaches 10 lines from top/bottom
(setq smooth-scroll-margin 10)

;;---------------------------------------------------------
;;          FIPLR
;;---------------------------------------------------------

(require 'fiplr)
(global-set-key (kbd "C-c f") 'fiplr-find-file)
(global-set-key "\C-c\S-f" 'fiplr-find-file-other-window)

;;----------------------------------------------------------
;;          SHELL POP
;;----------------------------------------------------------

(require 'shell-pop)
(global-set-key (kbd "C-c t") 'shell-pop)
(add-hook 'shell-pop-out-hook (lambda() (kill-buffer "*eshell-1*")))

;;----------------------------------------------------------
;;          DASHBOARD
;;----------------------------------------------------------

;; (require 'dashboard)
;; (dashboard-setup-startup-hook)
;; (setq dashboard-banner-logo-title "RPinder Emacs Configuration")
;; (setq dashboard-items '((recents . 5)
;;                         (bookmarks . 5)
;;                         (agenda . 5)))

;;----------------------------------------------------------
;;          PYENV MODE
;;----------------------------------------------------------

(pyenv-mode)

;;----------------------------------------------------------
;;          DIMINISH
;;----------------------------------------------------------

(diminish 'flycheck-mode)
(diminish 'company-mode)
(diminish 'undo-tree-mode)
(diminish 'yas-global-mode)
(diminish 'yas-minor-mode)
(diminish 'which-key-mode)
(diminish 'page-break-lines-mode)
(diminish 'irony-mode)
(diminish 'abbrev-mode)
(diminish 'auto-revert-mode)

;;-----------------------------------------------------------------------------

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Sorry")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil)
    (message "Using MacOS specific keybinds")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))
