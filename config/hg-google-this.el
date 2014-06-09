(unless (package-installed-p 'google-this)
  (package-refresh-contents) (package-install 'google-this))


(require 'google-this)
(google-this-mode t)
(global-set-key (kbd "C-c g") 'google-this)

(provide 'hg-google-this)

