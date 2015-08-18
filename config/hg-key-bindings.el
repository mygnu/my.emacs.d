
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  ;;
;;        global keybindings        ;;
;;                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Navigation
;;; Code:
(key-chord-define-global "eo" "\C-e") ;end of line
(key-chord-define-global "ao" "\C-a") ;begining of line


(global-set-key (kbd "C-x C-SPC") 'ace-jump-mode-pop-mark)
(global-set-key (kbd "C-t") 'previous-line)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-t") 'backward-paragraph)
;; Use regex searches by default.
;; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
;; (global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Editing
(global-set-key (kbd "C-M-y") 'hg-duplicate-current-line-or-region)
(key-chord-define-global "ex" 'eval-last-sexp)
(key-chord-define-global "uu" 'undo)
(key-chord-define-global ",." "<>\C-b")
(key-chord-define-global "--" "_")
(key-chord-define-global "dd" 'kill-whole-line)
(key-chord-define-global "/=" "\C-a //") ;; comment in cc-mode
(key-chord-define-global ";;"  'column-newline)  ;; ; at the end of the line;
(key-chord-define-global "jj" 'join-line)
(key-chord-define-global "SS" 'er/expand-region) ;;seletc at cursor


;; my keybindings
(global-unset-key (kbd "C-r"))
(global-set-key (kbd "C-r 2") 'split-window-right-and-move-there-dammit)
(global-set-key (kbd "C-r s") 'sudo-edit)
(global-set-key (kbd "C-r i") 'ido-imenu)
(global-set-key (kbd "C-r q") 'hg-toggle-quotes)
(global-set-key (kbd "C-r a") 'ace-jump-mode)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;; Java
;; (global-set-key (kbd "C-r e s") 'start-eclimd)
;; (global-set-key (kbd "C-r e k") 'stop-eclimd)
;; (global-set-key (kbd "C-r e f") 'eclim-project-goto)



(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-o") 'hg-open-next-line)
(global-set-key (kbd "M-o") 'hg-open-previous-line)
;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Font size
(define-key global-map (kbd "C-M-=") 'text-scale-increase)
(define-key global-map (kbd "C-M--") 'text-scale-decrease)

;; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)


;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)
(global-set-key (kbd "<C-tab>") 'hg-indent-whole-buffer)
;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-;") 'comment-dwim)  

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)




;; Windows

(key-chord-define-global "33" 'hg-reset-ui)
(key-chord-define-global "22" 'split-window-vertically)
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
;; windows resize
;; (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "S-C-<down>") 'shrink-window)
;; (global-set-key (kbd "S-C-<up>") 'enlarge-window)
;; Window switching. (C-x o goes to the next window)
;;(windmove-default-keybindings) ;; Shift+direction
(key-chord-define-global "90" 'hg-toggle-eshell-visor)
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive) (other-window -1))) ; back one
(global-set-key (kbd "C-x C-o") (lambda ()
                                  (interactive) (other-window 2))) ;; forward two
(global-set-key (kbd "M-1") 'delete-other-windows) ; close other panes
(global-set-key (kbd "M-2") 'split-window-vertically) ; split pane top/bottom
(global-set-key (kbd "M-3") 'split-window-horizontally) ; split pane sides
(global-set-key (kbd "M-0") 'delete-window) ; close current pane



;; Buffers
(global-set-key (kbd "C-c f r") 'hg-rename-current-buffer-file)
(global-set-key (kbd "C-c f d") 'hg-delete-current-buffer-file)
(global-set-key (kbd "C-c s") 'hg-switch-between-two-buffers)
;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'hg-ido-choose-from-recentf) ;hg-ido.el
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x M-f") 'hexl-find-file)


;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'shell)
(global-set-key (kbd "C-*") 'shell)
;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))
;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'eshell)

(global-set-key (kbd "C-c t") 'hg-toggle-eshell-visor)
(global-set-key (kbd "C-c u") 'hg-reset-ui)

;; Short Commands
;; escape key is once is enough
(global-set-key(kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-<f3>") 'find-grep)
(global-set-key (kbd "<f3>") 'isearch-forward-regexp)
(global-set-key (kbd "<f4>") 'hg-switch-between-two-buffers)
(global-set-key (kbd "<f5>") 'kill-buffer-but-not-some); kill currunt buffer
(global-set-key (kbd "M-<f5>") 'delete-window); delete current window

(global-set-key (kbd "<f6>") 'ido-switch-buffer)
(global-set-key (kbd "<f7>") 'ido-find-file)
(global-set-key (kbd "C-<f7>") 'ido-find-file-other-window)

(global-set-key (kbd "<f8>") 'save-buffer)
(global-set-key (kbd "M-<f8>") 'save-some-buffers)

(global-set-key (kbd "<f9>") 'other-window)
(global-set-key (kbd "M-<f9>") 'hg-transpose-buffers)

(global-set-key (kbd "<f10>") 'sr-speedbar-toggle)
(global-set-key (kbd "M-<f10>") 'ecb-activate)

;; ;;Cprogramming related commands


;; Configuration
(global-set-key (kbd "C-r c") 'customize-apropos)
;; So good!
(global-set-key (kbd "C-x g") 'magit-status)

;; This is a little hacky since VC doesn't support git add internally
(eval-after-load 'vc
  (define-key vc-prefix-map "i"
    '(lambda () (interactive)
       (if (not (eq 'Git (vc-backend buffer-file-name)))
           (vc-register)
         (shell-command (format "git add %s" buffer-file-name))
         (message "Staged changes.")))))


(provide 'hg-key-bindings)
