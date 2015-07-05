(unless (package-installed-p 'icicles)
  (package-refresh-contents) (package-install 'icicles))


;; icicle-mode
(icy-mode t)






(provide 'hg-icicle)
