
;; auto header files

(unless (package-installed-p 'header2)
  (package-refresh-contents) (package-install 'header2))
  
(autoload 'auto-make-header "header2")
;;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)

;(add-hook 'write-file-hooks 'auto-update-file-header)


(provide 'hg-header2)
