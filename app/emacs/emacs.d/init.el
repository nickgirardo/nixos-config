(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)


(setq evil-undo-system 'undo-tree)
(evil-mode 1)
