(unless (package-installed-p 'color-theme)
  (package-refresh-contents) (package-install 'color-theme))

(unless (package-installed-p 'solarized-theme)
  (package-refresh-contents) (package-install 'solarized-theme))

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(color-theme-clarity)
;; Color theme settings
;;(color-theme-initialize)
;;(require 'solarized-dark-theme)

;; (color-theme-subtle-hacker)
;; (custom-set-faces
;;  '(default ((t (:family "Anonymous Pro" :foundry "unknown" :slant normal
;;  :weight normal :height 165 :width normal)))))


(provide 'hg-color-theme)
