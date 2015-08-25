(unless (package-installed-p 'evil)
  (package-refresh-contents) (package-install 'evil))
(unless (package-installed-p 'powerline-evil)
  pagkafe-install 'powerline-evil)
(require 'powerline-evil)
(require 'hg-evil-nerd-commenter)

(require 'cl) ;; required for the following function
;; defuns for fill keymap
;; from https://github.com/marktran/emacs.d/tree/master/definitions

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
(evil-mode 1)
(eval-after-load 'evil
  '(progn
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
                  (kbd "TAB") #'indent-for-tab-command
                  (kbd "s-z") #'evil-emacs-state
                  (kbd "s-l") #'org-link
                  (kbd "s-z") #'evil-normal-state
                  (kbd "C-w h") #'windmove-down
                  (kbd "C-w t") #'windmove-up
                  (kbd "b") #'(lambda ()
                                "Switch to the previous buffer"
                                (interactive)
                                (switch-to-buffer nil))
                  "B" #'(lambda ()
                          "display all possible buffers and pick the one you want"
                          (interactive)
                          (list-buffers))
                  ;;(define-key evil-normal-state-map (kbd "Q") 'anzu-query-replace-regexp)
                  ;; This for when I use visual line mode mode. Now visual line mode should work for basic
                  ;; key movements
                  ;; This is not working.
                  (kbd "h") #'next-line
                  (kbd "t") #'previous-line
                  (kbd "n") #'backward-char
                  (kbd "s") #'forward-char
                  "k" 'kill-line
                  "K" #'(lambda () (interactive)
                          "kill from point to the beginning of the line"
                          (kill-line 0))
                  "I" 'evil-append
                  "$" 'ispell-word
                  ";" 'evilnc-comment-or-uncomment-lines
                  "C-c l" 'evilnc-quick-comment-or-uncomment-to-the-line
                  "C-c c" 'evilnc-copy-and-comment-lines
                  "C-c p" 'evilnc-comment-or-uncomment-paragraphs
                  "C-s" 'evil-substitute
                  (kbd "C-l") 'recenter-top-bottom
                  "l" 'recenter-top-bottom
                  "\M-o" 'evil-open-above
                  "\C-o" 'evil-open-below
                  "o" 'evil-backward-word-begin
                  "e" 'evil-forward-word-begin
                  "O" 'evil-backward-WORD-end
                  "E" 'evil-forward-WORD-end
		  "j" 'join-line
                  "J" #'(lambda () (interactive)
                          "join this line at the end of the line below"
                          (join-line 1))
                  (kbd "C-h") 'evil-open-below
                  (kbd "C-t") 'evil-open-above
                  (kbd "C-c r") 'evil-record-macro
                  ;; (kbd "C-w h") 'windmove-down
                  ;; (kbd "C-w t") 'windmove-up
                  ;; (kbd "C-w n") 'windmove-left
                  ;; (kbd "C-w s") 'windmove-right
                  "," 'undo-tree-undo
                  "'" 'evil-goto-mark
                  "Q" 'anzu-query-replace-regexp
                  (kbd "q") '(lambda ()
                               "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
                               (interactive)
                               (save-buffer)
                               (let (kill-buffer-query-functions) (kill-buffer)))
                  (kbd "<backspace>") 'ace-jump-char-mode
                  (kbd "l") 'recenter-top-bottom
                  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
                  ;;at least so the documentation claimed
                  (kbd "<return>") 'newline-and-indent
                  (kbd "a") 'evil-first-non-blank
                  (kbd "A") 'evil-insert-line
                  (kbd "u") 'evil-end-of-line
                  (kbd "U") 'evil-append-line
                  (kbd "C-d") 'delete-char
                  (kbd "<") 'beginning-of-buffer
                  (kbd ">") 'end-of-buffer
                  (kbd "l") 'recenter-top-bottom
                  ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
                  (kbd "<return>") 'newline-and-indent
                  (kbd "C-a") 'mark-whole-buffer)

     (fill-keymap evil-visual-state-map

                  (kbd "h") #'next-line
                  (kbd "t") #'previous-line
                  (kbd "n") #'backward-char
                  (kbd "l") #'forward-char
                  ";" 'evilnc-comment-or-uncomment-lines
                  "C-c l" 'evilnc-quick-comment-or-uncomment-to-the-line
                  "C-c c" 'evilnc-copy-and-comment-lines
                  "C-c p" 'evilnc-comment-or-uncomment-paragraphs
                  ) 
     ;;key bindings for escape
     (define-key evil-normal-state-map [escape] 'keyboard-quit)
     (define-key evil-visual-state-map [escape] 'keyboard-quit)
     (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
     (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

     ;; change state
     (define-key evil-normal-state-map (kbd "<menu>") 'execute-extended-command)
     (define-key evil-insert-state-map (kbd "<menu>") 'evil-normal-state)
     (define-key evil-visual-state-map (kbd "<menu>") 'evil-change-to-previous-state)
     (define-key evil-replace-state-map (kbd "<menu>") 'evil-normal-state)
     (define-key evil-emacs-state-map (kbd "<menu>")  'execute-extended-command)

     ;; set state for modes
     (evil-set-initial-state 'git-commit-mode 'insert)
     (evil-set-initial-state 'shell-mode 'emacs)
     ))




(provide 'hg-evil)
