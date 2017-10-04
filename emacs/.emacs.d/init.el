(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
