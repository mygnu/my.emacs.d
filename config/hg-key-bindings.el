
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  ;;
;;        global keybindings        ;;
;;                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Navigation
;;; Code:

;; my keybindings
(global-unset-key (kbd "C-r"))
(global-set-key (kbd "C-r 2") 'split-window-right-and-move-there-dammit)
(global-set-key (kbd "C-r s") 'sudo-edit)
(global-set-key (kbd "C-r i") 'ido-imenu)

(global-set-key (kbd "<C-tab>") 'hg-indent-whole-buffer)
;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Windows
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

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

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'shell)
(global-set-key (kbd "C-*") 'shell)
;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))
;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'eshell)

;; Short Commands
;; escape key is once is enough
;; (global-set-key(kbd "<escape>") 'keyboard-escape-quit)
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
