(unless (package-installed-p 'whole-line-or-region)
  (package-refresh-contents) (package-install 'whole-line-or-region))

(whole-line-or-region-mode t)

(provide 'hg-whole-line-or-region)
