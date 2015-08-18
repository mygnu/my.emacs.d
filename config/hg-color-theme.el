(unless (package-installed-p 'color-theme)
  (package-refresh-contents) (package-install 'color-theme))

;; (unless (package-installed-p 'solarized-theme)
;;   (package-refresh-contents) (package-install 'solarized-theme))

;; (unless (package-installed-p 'monokai-theme)
;;   (package-refresh-contents) (package-install 'monokai-theme))

(unless (package-installed-p 'powerline)
  (package-refresh-contents) (package-install 'powerline))

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(load-theme 'cyberpunk t)
;; (color-theme-clarity)
;; (color-theme-euphoria)
;; (load-theme 'monokai t)

;; load powerline default theme
(powerline-default-theme)

;; (color-theme-subtle-hacker)
;; (custom-set-faces
;;  '(default ((t (:family "Anonymous Pro" :foundry "unknown" :slant normal
;;  :weight normal :height 165 :width normal)))))


(provide 'hg-color-theme)
