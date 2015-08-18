(unless (package-installed-p 'enh-ruby-mode)
  (package-refresh-contents) (package-install 'enh-ruby-mode))

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;; (setq enh-ruby-program "/home/mygnu/.rvm/rubies/ruby-2.2.1/bin/ruby")
;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)


(provide 'hg-ruby)
;;; hg-ruby.el ends here
