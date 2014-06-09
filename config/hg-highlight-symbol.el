(unless (package-installed-p 'highlight-symbol)
  (package-refresh-contents) (package-install 'highlight-symbol))


(require 'highlight-symbol-autoloads)
(highlight-symbol-mode t)

(provide 'hg-highlight-symbol)


