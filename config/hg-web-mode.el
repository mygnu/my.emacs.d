;;; hg-web-mode.el ---
;;
;; Filename: hg-web-mode.el
;; Description:
;; Author:
;; Created: Sun Apr 20 22:45:07 2014 (+0930)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sun Apr 27 22:13:44 2014 (+0930)
;;     Update #: 20
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:
(require 'web-mode)
(require 'sgml-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(setq web-mode-engines-alist '(("php" . "\\.php\\'") ("blade" . "\\.blade\\.")) )
;; automatic indentation
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(sp-local-pair 'web-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))

(defun hg-syntax-color-hex ()
  "Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer)
  )
(add-hook 'web-mode-hook 'hg-syntax-color-hex)

(defun web-mode-match-paren (arg)
  "Go to the matching tag if on tag, otherwise insert %."
  (interactive "p")
  (cond ((looking-at "<")
         (sgml-skip-tag-forward 1))
        ((looking-back ">")
         (sgml-skip-tag-backward 1))
        (t (self-insert-command (or arg 1)))))

(defun web-mode-element-unwrap ()
  "Like `web-mode-element-vanish', but you don't need jump parent tag to unwrap.
Just like `paredit-splice-sexp+' style."
  (interactive)
  (save-excursion
    (web-mode-element-parent)
    (web-mode-element-vanish)
    (back-to-indentation)
    ))

(defun my-web-mode-hook ()
  (setq web-mode-enable-auto-pairing nil)
  ;(flycheck-mode t)
  (smartparens-mode t)
  (auto-complete-mode t))

(add-hook 'web-mode-hook 'my-web-mode-hook)


(provide 'hg-web-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-web-mode.el ends here
