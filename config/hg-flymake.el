
(require 'flymake)

;; flymake show error message in minibuffer
(defun hg-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'hg-flymake-show-help)
(add-hook 'find-file-hook 'flymake-find-file-hook)


(provide 'hg-flymake)
