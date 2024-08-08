(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(global-display-line-numbers-mode 1)
(global-git-gutter-mode 1)

(set-face-background 'git-gutter:modified "purple3")
(set-face-background 'git-gutter:added "green4")
(set-face-foreground 'git-gutter:deleted "red3")

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

(key-chord-define evil-normal-state-map "]d" 'git-gutter:next-hunk)
(key-chord-define evil-normal-state-map "[d" 'git-gutter:previous-hunk)


; Disable the bell for certain commands
(defun my-bell-function ()
    (unless (memq this-command '(
		    isearch-abort
		    isearch-printing-char
		    abort-recursive-edit
		    exit-minibuffer
		    abort-minibuffers
		    keyboard-quit
		    mwheel-scroll
		    down
		    up
		    next-line
		    previous-line
		    backward-char
		    evil-backward-char
		    forward-char
		    evil-forward-char))
	(ding)))

(setq ring-bell-function 'my-bell-function)
