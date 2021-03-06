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
(unless (package-installed-p 'web-mode)
  (package-refresh-contents) (package-install 'web-mode))
(unless (package-installed-p 'scss-mode)
  (package-refresh-contents) (package-install 'scss-mode))



(require 'web-mode)
(require 'scss-mode)

(setq scss-compile-at-save nil)                                      ;(require 'sgml-mode)
(add-to-list 'auto-mode-alist '("\.scss$" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; (setq web-mode-engines-alist
;;       '(("php" . "\\.php\\'")
;;         ("blade" . "\\.blade\\."))
;;       )
;; automatic indentation
(define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(define-key web-mode-map (kbd "<f10>") 'hg-toggle-web-element)

(defun expand-for-web-mode ()
  (when (equal mode-name "Web")
    (make-local-variable 'yas-extra-modes)
    (setq yas-extra-modes
          (let ((web-lang (web-mode-language-at-pos)))
            (cond
             ((equal web-lang "html")       '(html-mode))
             ((equal web-lang "css")        '(css-mode))
             ((equal web-lang "javascript") '(javascript-mode))
             )))))

(add-hook 'yas-before-expand-snippet-hook 'expand-for-web-mode)

(sp-local-pair 'web-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))
(sp-local-pair 'scss-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-block-face t)
;; (setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)


(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev))))


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

(add-hook 'scss-mode-hook 'hg-syntax-color-hex)

(defun hg-toggle-web-element()
  (interactive)
  (web-mode-fold-or-unfold)
  (hg-indent-whole-buffer)
  )

;; (setq web-mode-ac-sources-alist
;;       '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
;;         ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
;;         ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

;; (add-hook 'web-mode-before-auto-complete-hooks
;;           '(lambda ()
;;              (let ((web-mode-cur-language
;;                     (web-mode-language-at-pos)))
;;                (if (string= web-mode-cur-language "php")
;;                    (yas-activate-extra-mode 'php-mode)
;;                  (yas-deactivate-extra-mode 'php-mode))
;;                (if (string= web-mode-cur-language "ruby")
;;                    (yas-activate-extra-mode 'ruby-mode)
;;                  (yas-deactivate-extra-mode 'ruby-mode))
;;                (if (string= web-mode-cur-language "css")
;;                    (setq emmet-use-css-transform t)
;;                  (setq emmet-use-css-transform nil)))))


(provide 'hg-web-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-web-mode.el ends here
