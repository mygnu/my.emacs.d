(unless (package-installed-p 'evil-nerd-commenter)
  (package-refresh-contents) (package-install 'evil-nerd-commenter))



(provide 'hg-evil-nerd-commenter)
