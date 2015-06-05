
;;INIT.el folders
;;; Code:
(add-to-list 'load-path "/data/git/my.emacs.d")
(add-to-list 'load-path "/data/git/my.emacs.d/config")

(require 'hg-elpa-packages)
(require 'hg-configuration)


;; don't change below this

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-user-dictionary (quote ("~/.emacs.d/config/dict")))
 '(ccm-vpos-init (quote (round (* 21 (window-text-height)) 34)))
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-base-file-name "~/.emacs.d/desktop")
 '(desktop-save-mode t)
 '(expand-region-skip-whitespace nil)
 '(fill-column 80)
 '(flymake-log-file-name "~/.emacs.d/flymake.log")
 '(flymake-log-level 0)
 '(flymake-number-of-errors-to-display 1)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(global-auto-complete-mode t)
 '(global-linum-mode t)
 '(gtags-path-style (quote absolute))
 '(header-copyright-notice nil)
 '(header-free-software "This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.")
 '(highlight-symbol-idle-delay 1)
 '(highlight-symbol-on-navigation-p t)
 '(icicle-TAB-completion-methods (quote (swank basic fuzzy)))
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(list-matching-lines-face (quote bold))
 '(make-header-hook (quote (header-title header-blank header-file-name header-description header-author header-copyright header-creation-date header-version header-pkg-requires header-modification-date header-update-count header-blank header-lib-requires header-blank header-blank header-end-line header-free-software header-code header-eof)))
 '(midnight-mode t nil (midnight))
 '(mouse-avoidance-mode (quote animate) nil (avoid))
 '(next-line-add-newlines t)
 '(recentf-exclude (quote ("*Message*" "*scratch*" "*Compile-log*" "*Customize*" "*eshell*")))
 '(recentf-max-menu-items 30)
 '(recentf-mode t)
 '(recentf-save-file "~/.emacs.d/.recentf")
 '(show-paren-mode t)
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay t)
 '(sp-highlight-wrap-tag-overlay nil)
 '(speedbar-default-position (quote left))
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil)
 '(truncate-lines nil)
 '(visible-bell t)
 '(word-wrap nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 155 :width normal))))
 '(flymake-errline ((t (:foreground "red"))))
 '(font-lock-warning-face ((t (:foreground "red" :weight bold))))
 '(hi-blue-b ((t (:foreground "deep sky blue" :weight bold)))))
;;; init.el ends here
