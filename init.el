

(add-to-list 'load-path "/home/mygnu/.emacs.d/config")

(require 'hg-elpa-packages)
(require 'hg-configuration)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(midnight-mode t nil (midnight))
'(mouse-avoidance-mode (quote animate) nil (avoid))
'(next-line-add-newlines t)
'(recentf-exclude
(quote
 ("*Message*" "*scratch*" "*Compile-log*" "*Customize*" "*eshell*")))
'(recentf-max-menu-items 30)
'(recentf-mode t)
'(recentf-save-file "~/.emacs.d/.recentf")
'(show-paren-mode t)
'(visible-bell t)
 '(inhibit-startup-screen t)
'(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-base-file-name "~/.emacs.d/desktop")
 '(desktop-save-mode t)
 '(expand-region-skip-whitespace nil)
 '(fill-column 80)
 '(inhibit-startup-screen t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
'(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 155 :width normal))))
 '(flymake-errline ((t (:foreground "red"))))
 '(font-lock-warning-face ((t (:foreground "red" :weight bold))))
 '(hi-blue-b ((t (:foreground "deep sky blue" :weight bold))))
 )
