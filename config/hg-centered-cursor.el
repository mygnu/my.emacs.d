
;; cursor stayes in center
(unless (package-installed-p 'centered-cursor-mode)
  (package-refresh-contents) (package-install 'centered-cursor-mode))

(require 'centered-cursor-mode)
(global-centered-cursor-mode +1)


(provide 'hg-centered-cursor)
