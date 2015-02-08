;; defuns for fill keymap
;; from https://github.com/marktran/emacs.d/tree/master/definitions

;;; Code:
(defun set-key (map spec cmd)
  "Set in `map' `spec' to `cmd'.
`Map' may be `'global' `'local' or a keymap.
A `spec' can be a `read-kbd-macro'-readable string or a vector."
  (let ((setter-fun (case map
                      (global #'global-set-key)
                      (local #'local-set-key)
                      (t (lambda (key def) (define-key map key def)))))
        (key (typecase spec
               (vector spec)
               (string (read-kbd-macro spec))
               (t (error "wrong argument")))))
    (funcall setter-fun key cmd)))
(defun pour-mappings-to (map mappings)
  "Calls `set-key' with `map' on every key-fun pair in `MAPPINGS'.
`MAPPINGS' is a list of string-fun pairs, with a `READ-KBD-MACRO'-readable string and a interactive-fun."
  (dolist (mapping (group mappings 2))
    (set-key map (car mapping) (cadr mapping)))
  map)
(defun group (lst n)
  "Group `LST' into portions of `N'."
  (let (groups)
    (while lst
      (push (take n lst) groups)
      (setq lst (nthcdr n lst)))
    (nreverse groups)))
(defun take (n lst)
  "Return atmost the first `N' items of `LST'."
  (let (acc '())
    (while (and lst (> n 0))
      (cl-decf n)
      (push (car lst) acc)
      (setq lst (cdr lst)))
    (nreverse acc)))
;; from https://github.com/cofi/dotfiles/blob/master/emacs.d/config/cofi-evil.el
(defun fill-keymap (keymap &rest mappings)
  "Fill `KEYMAP' with `MAPPINGS'.
See `pour-mappings-to'."
  (pour-mappings-to keymap mappings))


(setq evil-move-cursor-back nil) ;;and maybe also:
;; (setq evil-highlight-closing-paren-at-point-states nil)

(evil-mode t)
;;powerline

(powerline-default-theme)
                                        ;(require 'surround)
                                        ;(global-surround-mode 1)

(defun evil-undefine ()
  (interactive)
  (let (evil-mode-map-alist)
    (call-interactively (key-binding (this-command-keys)))))
(defun hg-evil-after-save()
  (evil-normal-state t))
;; (define-key evil-normal-state-map (kbd "TAB") 'evil-undefine)

(eval-after-load 'evil
  '(progn
;;; esc quits
     (powerline-center-evil-theme)
     (setq evil-search-module 'evil-search)
     (setq evil-magic 'very-magic)
     (setq evil-want-fine-undo t)
     (setq evil-emacs-state-cursor '("purple" box))
     (setq evil-normal-state-cursor '("red" box))
     (setq evil-visual-state-cursor '("yellow" box))
     (setq evil-insert-state-cursor '("green" bar))
     (setq evil-replace-state-cursor '("pink" box))
     (setq evil-operator-state-cursor '("red" hollow))
     (fill-keymap evil-normal-state-map
                  ;; my modyfied key
                  "k 1" 'delete-other-windows
                  "k 3" 'other-window
                  "k 2" 'split-window-right-and-move-there-dammit
                  "k a" 'prelude-move-beginning-of-line
                  "k e" 'evil-end-of-line
                  "k b i" 'indent-buffer

                  "k b k" 'kill-this-buffer
                  "k b e" 'eval-buffer
                  "k d o" 'delete-other-windows
                  "k f r" 'hg-rename-current-buffer-file
                  "k f d" 'hg-delete-current-buffer-file
                  "k SPC" 'execute-extended-command
                  "k /" 'isearch-forward
                  "k ?" 'isearch-backword
                  "k w" 'kill-region
                  "k y" 'kill-ring-save
                  "k p" 'yank
                  "k t" 'flycheck-next-error
                  "k n" 'flycheck-previous-error
                  ;; navigation keys
                  "s" 'forward-char
                  "h" 'backward-char
                  "n" 'previous-line
                  "t" 'next-line
                  ;; "h" 'backward-char
                  ;; "j" 'next-line
                  ;; "k" 'previous-line
                  ;; "l" 'forward-char
                  ;; "<M-right>" 'tabbar-forward-tab
                  ;; "<M-left>" 'tabbar-backward-tab
                  ;; "l" 'evil-search-next
                  "C-j" 'hg-move-line-region-down
                  "C-k" 'hg-move-line-region-up
                  "<return>" 'newline-and-indent

                  "k ;" 'comment-dwim-2

                  ;;editing
                  "SPC" 'evil-insert-state
                  "k j" 'join-line

                  "<DEL>" 'backward-delete-char-untabify)

     (fill-keymap evil-visual-state-map
                  ;; navigation
                  ";" 'comment-dwim-2
                  "k b i" 'indent-buffer-or-region
                  "h" 'backward-char
                  "k e" 'evil-end-of-line

                  ;; navigation keys
                  "s" 'forward-char
                  "h" 'backward-char
                  "n" 'previous-line
                  "t" 'next-line

                  "k s" 'er/expand-region
                  "k p" 'duplicate-thing
                  "C-h" 'hg-move-line-region-down
                  "C-t" 'hg-move-line-region-up
                  "<return>" 'newline-and-indent)

     (fill-keymap evil-insert-state-map
                  "<return>" 'newline-and-indent
                  "M-;" 'comment-dwim-2)
     ;;key bindings for escape
     (define-key evil-normal-state-map [escape] 'keyboard-quit)
     (define-key evil-visual-state-map [escape] 'keyboard-quit)
     (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

     ;; keep general keybingings
     (define-key evil-normal-state-map "\C-y" 'yank)
     (define-key evil-insert-state-map "\C-y" 'yank)
     (define-key evil-visual-state-map "\C-y" 'yank)
     (define-key evil-insert-state-map "\C-e" 'evil-end-of-line)
     ;; editing
     ;; (evil-declare-key 'motion completion-list-mode-map (kbd "<return>") 'choose-completion)
     ;; (evil-declare-key 'motion browse-kill-ring-mode-map (kbd "<return>") 'browse-kill-ring-insert-and-quit)
     ;; (evil-declare-key 'motion occur-mode-map (kbd "<return>") 'occur-mode-goto-occurrence)
     ;;comments nered comment mode
     ;; change state
     (define-key evil-normal-state-map (kbd "<menu>") 'helm-M-x)
     (define-key evil-insert-state-map (kbd "<menu>") 'evil-normal-state)
     (define-key evil-visual-state-map (kbd "<menu>") 'evil-change-to-previous-state)
     ;; (define-key evil-replace-state-map (kbd "<menu>") 'evil-normal-state)
     ;; (define-key evil-emacs-state-map (kbd "<menu>") 'helm-M-x)
     ;; set state for modes
     (evil-set-initial-state 'git-commit-mode 'insert)
     (evil-set-initial-state 'shell-mode 'emacs)
     (evil-set-initial-state 'dired-mode 'emacs)
     ;; hooks
     ;; (add-hook 'evil-insert-state-exit-hook 'my-save-if-bufferfilename)
     ;; (add-hook 'evil-insert-normal-exit-hook 'my-save-if-bufferfilename)
     (add-hook 'after-save-hook 'hg-evil-after-save)
     (add-hook 'evil-insert-state-entry-hook 'indent-according-to-mode)))

(provide 'setup-evil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'hg-evil)
