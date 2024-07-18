(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

; Set global directory for backup files so as to not dirty project directories
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(evil-mode 1)

; Use undo tree for undo history
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)

(setq evil-undo-system 'undo-tree)

; Exit insert/ replace modes with chord "jk"
(key-chord-mode 1)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-replace-state-map "jk" 'evil-normal-state)

