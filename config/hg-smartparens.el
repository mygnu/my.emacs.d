;; smartparens
(unless (package-installed-p 'smartparens)
  (package-refresh-contents) (package-install 'smartparens))

(smartparens-global-mode t)
(sp-pair "'" nil :actions :rem)


(provide 'hg-smartparens)
