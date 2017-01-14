;;
;;
;; RPINDER INIT.EL FILE
;;   http://github.com/rpinder
;;
;;

;; last edited: 29/12/2016

;; I know very little elisp

;; TODO
;; + email inside emacs
;; + set up eirc
;; + latex environment
;; + set up emacs for python and ruby
;;   - jedi?
;; + set up rtags or something similar
;;   - and an easy way to search tags (like vim's ctrlp)

;-------------------------------------------------------------------------------

;; remove useless (to me) clutter
;;   I have this here so I don't see them when emacs is loading
(menu-bar-mode -1)
(when (display-graphic-p) ;; these elements don't exist in the terminal emacs
  (tool-bar-mode -1)      ;; so turning them off isn't needed
  (scroll-bar-mode -1))

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
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive descriptions
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(package-initialize)

(ensure-package-installed
 'ido-vertical-mode
 'org-bullets
 'smex
 'ido-ubiquitous
 'flycheck
 'quickrun
 'magit
 'rbenv
 'hlinum
 'key-chord
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
 'dashboard
 'projectile
 'pyenv-mode
 'evil
 'evil-surround
 'powerline
 'airline-themes
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          UI CONFIG
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (if (display-graphic-p)
;;     (progn
;;      (load-theme 'soothe t)) ;; loads spacegray theme if using emacs window
;;   (load-theme 'ample t t)       ;; loads ample theme in terminal
;;   (enable-theme 'ample))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'base16-ocean)

(show-paren-mode)           ;; highlights matching parens


(setq column-number-mode t) ;; puts column number in the mode line

;; puts a space between number line and window border
(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

(setq inhibit-startup-screen t) ;; disables emacs start screen

;; Inactive modeline is darker 
;; (when (display-graphic-p)
;;   (set-face-foreground 'modeline-inactive "#777777")
;;   (set-face-background 'modeline-inactive "#181b22"))

(setq display-time-24hr-format t)
(display-time-mode 1)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;           CUSTOM FUNCTIONS 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; opens emacs configuration file
(defun open-dotfile ()
  " Opens the file ~/dotfiles/emacs/init.el "
  (interactive)
  (find-file "~/dotfiles/emacs/init.el"))

(defun open-dotfile-other-window ()
  " Opens thne file ~/dotfiles/emacs/init.el in another window "
  (interactive)
  (find-file-other-window "~/dotfiles/emacs/init.el")
  (previous-multiframe-window))

;; opens zsh configuration file
(defun open-zsh ()
  " Opens the file ~/dotfiles/.zshrc "
  (interactive)
  (find-file "~/dotfiles/.zshrc"))

(defun open-zsh-other-window ()
  " Opens the file ~/dotfiles/.zshrc in another window "
  (interactive)
  (find-file-other-window "~/dotfiles/.zshrc")
  (previous-multiframe-window))

;; loads the emacs initialization file
(defun load-emacs ()
  " loads the emacs configuration file "
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; This turns off line numbers and line highlighting,
;; and also gets rid of the fringe
(defun setup-eshell ()
" sets up eshell by
  removing line numbers
  removng fringes
  turning off line highlghting "
  (linum-mode -1)
  (set-window-fringes nil 0 0 )
  (hl-line-mode -1))

;; Inserts comment subheadings like the ones in the PACKAGE CONFIG section
;; This is probably done horribly, tell me how to improve it
(defun sub-comment ()
  " Inserts elisp comment sub-headings "
  (interactive)
  (let ((x (read-string "Enter comment: ")))
    (message "inserting subheading comment with the text: %s." x)
    (insert ";;----------------------------------------------------------\n")
    (insert ";;          " x "\n")
    (insert ";;----------------------------------------------------------\n")))

;; inserts comment headings such as "HOOKS" or "CUSTOM FUNCTIONS"
(defun heading-comment ()
  " Inserts elisp comment headings "
  (interactive)
  (let ((x (read-string "Enter comment: ")))
    (message "inserting heading comment with the test: %s." x)
    (insert ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n")
    (insert ";;\n")
    (insert ";;          " x "\n"))
    (insert ";;\n")
    (insert ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"))

(defun find-other-file-in-other-window ()
  " opens corresponding .c, .cpp, .h, .hpp etc file in other window "
  (interactive)
  (ff-find-other-file t nil)
  (previous-multiframe-window))

(defun scroll-other-window-two ()
  " scrolls the other window by 2 lines "
  (interactive)
  (scroll-other-window 2))

(defun scroll-other-window-down-two ()
  " scrolls the other window down by 2 lines "
  (interactive)
  (scroll-other-window-down 2))

;; setup emacs for prog buffers
(defun setup-prog-buffers ()
  " enables line highlighting and line numbers for programming buffers "
  (hl-line-mode 1)
  (linum-mode 1)
  (electric-pair-local-mode))

(defun setup-c-buffers ()
  " enables c local key binds "
  (local-set-key (kbd "C-c c a") 'ff-find-other-file)
  (local-set-key (kbd "C-c c A") 'find-other-file-in-other-window))

;; launches a live markdown preview of the current file
;; This sort of works? I would like for it to be ran outside of emacs but I am
;; not sure how to do that
(defun launch-vmd ()
  " launches a live markdown preview of the currnent file using vmd "
  (interactive)
  (shell-command (concat "vmd " (buffer-file-name) " &")))

(defun window-left-to-right (prefix)
" moves window from the left of the screen to the right of the screen "
  (interactive "p")
  (other-window 1)
  (delete-window)
  (split-window-right)
  (switch-to-buffer (other-buffer)))

(defun window-right-to-left (prefix)
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
(add-hook 'eshell-mode-hook  'setup-eshell)

;; all programming buffers have line highlighting
(add-hook 'prog-mode-hook 'setup-prog-buffers)

(add-hook 'c-mode-common-hook 'setup-c-buffers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;          CUSTOM KEYBINDS 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; line is automatically indented
(define-key global-map (kbd "RET") 'newline-and-indent)

;; C-c o(pen)  use shift to open that file in another window
(global-set-key (kbd "C-c o d") 'open-dotfile)
(global-set-key "\C-co\S-d" 'open-dotfile-other-window)

(global-set-key (kbd "C-c o z") 'open-zsh)
(global-set-key "\C-co\S-z" 'open-zsh-other-window)

;; scroll other window with shift+jk
(global-set-key "\S-k" 'scroll-other-window-down-two)
(global-set-key "\S-j" 'scroll-other-window-two)

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

;;----------------------------------------------------------
;;          EVIL
;;----------------------------------------------------------

;; enables evil mode
(require 'evil)
(evil-mode t)

;; places a box at the start of the modeline containing text of the current evil state
;; and a background color (from spacegray theme) to match
;; (setq evil-mode-line-format '(before . mode-line-front-space))
;; (setq evil-normal-state-tag   (propertize " NORMAL  " 'face '((:background "#343d46")))
;;       evil-emacs-state-tag    (propertize " EMACS   " 'face '((:background "#C189EB")))
;;       evil-insert-state-tag   (propertize " INSERT  " 'face '((:background "#27AE60")))
;;       evil-motion-state-tag   (propertize " MOTION  " 'face '((:background "#89EBCA")))
;;       evil-visual-state-tag   (propertize " VISUAL  " 'face '((:background "#DCA432")))
;;       evil-replace-state-tag  (propertize " REPLACE " 'face '((:background "#bf616a")))
;;       evil-operator-state-tag (propertize " NORMAL  " 'face '((:background "#343d46"))))

;; enables an evil port of tpope's surround.vim plugin
(require 'evil-surround)
(global-evil-surround-mode 1)

(define-key evil-normal-state-map "\S-j" nil) ;; I'm using these keys for 
(define-key evil-motion-state-map "\S-k" nil) ;; scrolling the other window 

;; I never use vim arrow keys so these get in the way of useful
;; things such as snake and tetris
(define-key evil-motion-state-map (kbd "<left>")  nil)
(define-key evil-motion-state-map (kbd "<down>")  nil)
(define-key evil-motion-state-map (kbd "<up>")    nil)
(define-key evil-motion-state-map (kbd "<right>") nil)

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
(require 'ido-ubiquitous)
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
;;          HLINUM
;;----------------------------------------------------------

;; extends linum-mode to highlight current line number
(require 'hlinum)
(hlinum-activate)

;;----------------------------------------------------------
;;          KEY-CHORD
;;----------------------------------------------------------

(require 'key-chord)
(key-chord-mode 1)

;; mashing jk when in evil insert mode will put me into normal mode
;; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;;----------------------------------------------------------
;;          WINUM
;;----------------------------------------------------------

;; (require 'winum)

;; ;; puts the mode-line indicator in the space after buffer indicator but before
;; ;; current line number percentage of total file
;; (setq winum-mode-line-position 8)

;; ;; winum-keymap-prefix is currently broken so I'm doing this instead
;; (global-set-key (kbd "C-c 0") 'winum-select-window-0-or-10)
;; (global-set-key (kbd "C-c 1") 'winum-select-window-1)
;; (global-set-key (kbd "C-c 2") 'winum-select-window-2)
;; (global-set-key (kbd "C-c 3") 'winum-select-window-3)
;; (global-set-key (kbd "C-c 4") 'winum-select-window-4)
;; (global-set-key (kbd "C-c 5") 'winum-select-window-5)
;; (global-set-key (kbd "C-c 6") 'winum-select-window-6)
;; (global-set-key (kbd "C-c 7") 'winum-select-window-7)
;; (global-set-key (kbd "C-c 8") 'winum-select-window-8)
;; (global-set-key (kbd "C-c 9") 'winum-select-window-9)

;; (winum-mode)

;; ;;----------------------------------------------------------
;; ;;          WHICH-KEY
;; ;;----------------------------------------------------------

;; ;; displays keybindings following your currently entered incomplete command
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

;; ;;----------------------------------------------------------
;; ;;          SWITCH WINDOW
;; ;;----------------------------------------------------------

;; ;; offer a visual way to choose a window to switch to
;; (require 'switch-window)
;; (global-set-key (kbd "C-x o") 'switch-window)

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

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "https://github.com/rpinder/dotfiles")
(setq dashboard-startup-banner "~/dotfiles/emacs/banner.png")

;;----------------------------------------------------------
;;          PYENV MODE
;;----------------------------------------------------------

(pyenv-mode)

;;----------------------------------------------------------
;;          powerline
;;----------------------------------------------------------

(require 'powerline)
(require 'airline-themes)
(load-theme 'airline-base16)

;;-----------------------------------------------------------------------------

(fringe-mode 0)
