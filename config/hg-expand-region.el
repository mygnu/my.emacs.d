(package-initialize)
(unless (package-installed-p 'expand-region)
  (package-refresh-contents) (package-install 'expand-region))


(require 'expand-region)
;;keybindings


(provide 'hg-expand-region)
