(package-initialize)
(unless (package-installed-p 'key-chord)
  (package-refresh-contents) (package-install 'key-chord))


(key-chord-mode 1)


(provide 'hg-chord)
