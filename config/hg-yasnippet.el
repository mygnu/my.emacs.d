
;;; Code:
;;; yasnippet
;;; should be loaded before auto complete so that they can work together

;;popup is required for yasnippet
(unless (package-installed-p 'popup)
  (package-refresh-contents) (package-install 'popup))

(unless (package-installed-p 'yasnippet)
  (package-refresh-contents) (package-install 'yasnippet))

;(require 'cl)
(require 'yasnippet)
(setq yas-snippet-dirs "~/.emacs.d/config/snippets/") ; my snippets

(yas-global-mode t)

;; ;;; use popup menu for yas-choose-value
;; (require 'popup)

;; ;; add some shotcuts in popup menu mode
;; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

;; (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
;;   (when (featurep 'popup)
;;     (popup-menu*
;;      (mapcar
;;       (lambda (choice)
;;         (popup-make-item
;;          (or (and display-fn (funcall display-fn choice))
;;              choice)
;;          :value choice))
;;       choices)
;;      :prompt prompt
;;      ;; start isearch mode immediately
;;      :isearch t
;;      )))

;; ;;;###autoload
;; (defun yas-popup-prompt (prompt choices &optional display-fn)
;;   "Select a snippet with popup library."
;;   (poppup-menu*
;;    (mapcar (lambda (choice)
;;              (popup-make-item
;;               (or (and display-fn (funcall display-fn choice))
;;                   choice)
;;               :value choice))
;;            choices)
;;    :prompt prompt))
;; ;; Select a snippet with popup library
;; (setq yas-prompt-functions '(yas-popup-isearch-prompt yas-popup-prompt yas-no-prompt))
;; ;(setq yas-prompt-functions '(yas-popup-prompt yas-no-prompt)) 

(provide 'hg-yasnippet)

