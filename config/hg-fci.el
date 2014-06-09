;(add-hook 'emacs-startup-hook 'fci-mode)
;(fci-mode t)

(unless (package-installed-p 'fill-column-indicator)
  (package-refresh-contents) (package-install 'fill-column-indicator))
  
(define-globalized-minor-mode
 global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)

(setq fci-rule-color "yellow")


(provide 'hg-fci)
