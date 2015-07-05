(unless (package-installed-p 'enh-ruby-mode)
  (package-refresh-contents) (package-install 'enh-ruby-mode))

(provide 'hg-ruby)
;;; hg-ruby.el ends here
