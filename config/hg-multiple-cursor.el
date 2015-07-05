
(unless (package-installed-p 'multiple-cursors)
  (package-refresh-contents) (package-install 'multiple-cursors))
(require 'multiple-cursors)


(provide 'hg-multiple-cursor)
