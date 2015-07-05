(unless (package-installed-p 'ecb)
  (package-refresh-contents) (package-install 'ecb))

;;; activate ecb
(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-layout-name "left6")

(provide 'hg-emacs-code-browser)
