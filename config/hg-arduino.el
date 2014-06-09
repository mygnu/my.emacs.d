(unless (package-installed-p 'arduino-mode)
  (package-refresh-contents) (package-install 'arduino-mode))

;(add-hook 'arduino-mode-hook 'fci-mode)

(provide 'hg-arduino)
