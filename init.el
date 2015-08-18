
;;INIT.el folders
;;; Code:
;;(add-to-list 'load-path "~/.emacs.d")
(setq debug-on-error t)
(add-to-list 'load-path "/home/mygnu/.emacs.d/config")

(require 'hg-elpa-packages)
(require 'hg-configuration)


;; don't change below this

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(ansi-color-names-vector
   ["#313131" "#D9A0A0" "#8CAC8C" "#FDECBC" "#99DDE0" "#E090C7" "#A0EDF0" "#DCDCCC"])
 '(ccm-vpos-init (quote (round (* 21 (window-text-height)) 34)))
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-base-file-name "~/.emacs.d/desktop")
 '(desktop-save-mode t)
 '(expand-region-skip-whitespace nil)
 '(fci-rule-color "#2D2D2D")
 '(fill-column 80)
 '(flycheck-clang-include-path
   (quote
    ("/usr/include/gtk-3.0" "/usr/include/at-spi2-atk/2.0" "/usr/include/gio-unix-2.0/" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/harfbuzz" "/usr/include/atk-1.0" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/libdrm" "/usr/include/gdk-pixbuf-2.0" "/usr/include/libpng16" "/usr/include/glib-2.0" "/usr/lib64/glib-2.0/include")))
 '(flycheck-clang-warnings (quote ("all" "extra")))
 '(flycheck-completion-system (quote ido))
 '(flycheck-display-errors-delay 0.8)
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(flycheck-highlighting-mode (quote symbols))
 '(flycheck-idle-change-delay 2)
 '(flycheck-indication-mode (quote left-fringe))
 '(flycheck-pos-tip-timeout 10)
 '(flycheck-standard-error-navigation t)
 '(flymake-log-file-name "~/.emacs.d/flymake.log")
 '(flymake-log-level 0)
 '(flymake-number-of-errors-to-display 1)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gtags-path-style (quote absolute))
 '(header-copyright-notice nil)
 '(header-free-software
   "This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.")
 '(inhibit-startup-screen t)
 '(list-matching-lines-face (quote bold))
 '(make-header-hook
(quote
 (header-title header-blank header-file-name header-description header-author header-copyright header-creation-date header-version header-pkg-requires header-modification-date header-update-count header-blank header-lib-requires header-blank header-blank header-end-line header-free-software header-code header-eof)))
'(midnight-mode t nil (midnight))
'(mouse-avoidance-mode (quote animate) nil (avoid))
'(next-line-add-newlines t)
'(recentf-exclude
(quote
 ("*Message*" "*scratch*" "*Compile-log*" "*Customize*" "*eshell*")))
'(recentf-max-menu-items 30)
'(recentf-mode t)
'(recentf-save-file "~/.emacs.d/.recentf")
'(ruby-align-chained-calls t)
'(show-paren-mode t)
'(sp-highlight-pair-overlay nil)
'(sp-highlight-wrap-overlay t)
'(sp-highlight-wrap-tag-overlay nil)
'(speedbar-default-position (quote left))
'(sr-speedbar-right-side nil)
'(tool-bar-mode nil)
'(truncate-lines nil)
'(vc-annotate-background "#202020")
'(vc-annotate-color-map
(quote
 ((20 . "#C99090")
  (40 . "#D9A0A0")
  (60 . "#ECBC9C")
  (80 . "#DDCC9C")
  (100 . "#EDDCAC")
  (120 . "#FDECBC")
  (140 . "#6C8C6C")
  (160 . "#8CAC8C")
  (180 . "#9CBF9C")
  (200 . "#ACD2AC")
  (220 . "#BCE5BC")
  (240 . "#CCF8CC")
  (260 . "#A0EDF0")
  (280 . "#79ADB0")
  (300 . "#89C5C8")
  (320 . "#99DDE0")
  (340 . "#9CC7FB")
  (360 . "#E090C7"))))
'(vc-annotate-very-old-color "#E090C7")
'(visible-bell t)
'(web-mode-attr-indent-offset 2)
'(web-mode-code-indent-offset 4)
'(web-mode-css-indent-offset 2)
'(web-mode-enable-block-face t)
'(web-mode-enable-current-column-highlight t)
'(web-mode-markup-indent-offset 2)
'(web-mode-sql-indent-offset 2)
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
