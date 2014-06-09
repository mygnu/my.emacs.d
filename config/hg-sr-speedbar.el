(unless (package-installed-p 'sr-speedbar)
  (package-refresh-contents) (package-install 'sr-speedbar))

;; speedbar in current frame

(require 'sr-speedbar)

(provide 'hg-sr-speedbar)
