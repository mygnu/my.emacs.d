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

(defun evil-dvorak-turn-on-web-mode-keys ()
  "This turns on the evil-dvorak web-mode keyboard shortcuts."
  (interactive)
  (define-key evil-normal-state-map (kbd "Hta") 'web-mode-tag-attributes-sort)
  (define-key evil-normal-state-map (kbd "Htb") 'web-mode-tag-beginning)
  (define-key evil-normal-state-map (kbd "Hte") 'web-mode-tag-end)
  (define-key evil-normal-state-map (kbd "Htm") 'web-mode-tag-match)
  (define-key evil-normal-state-map (kbd "Htn") 'web-mode-tag-next)
  (define-key evil-normal-state-map (kbd "Htp") 'web-mode-tag-previous)
  (define-key evil-normal-state-map (kbd "Hts") 'web-mode-tag-select)
  (define-key evil-normal-state-map (kbd "Hek") 'web-mode-element-kill)
  (define-key evil-normal-state-map (kbd "Hev") 'web-mode-element-vanish)
  (define-key evil-normal-state-map (kbd "Hea") 'web-mode-element-content-select)
  (define-key evil-normal-state-map (kbd "Hec") 'web-mode-element-clone)
  (define-key evil-normal-state-map (kbd "Heb") 'web-mode-element-beginning)
  (define-key evil-normal-state-map (kbd "Hed") 'web-mode-element-child)
  (define-key evil-normal-state-map (kbd "Hee") 'web-mode-element-end)
  (define-key evil-normal-state-map (kbd "Hef") 'web-mode-element-children-fold-or-unfold)
  (define-key evil-normal-state-map (kbd "Hei") 'web-mode-element-insert)
  (define-key evil-normal-state-map (kbd "Hem") 'web-mode-element-mute-blanks)
  (define-key evil-normal-state-map (kbd "Hen") 'web-mode-element-next)
  (define-key evil-normal-state-map (kbd "Hep") 'web-mode-element-previous)
  (define-key evil-normal-state-map (kbd "Her") 'web-mode-element-rename)
  (define-key evil-normal-state-map (kbd "Hes") 'web-mode-element-select)
  (define-key evil-normal-state-map (kbd "Het") 'web-mode-element-transpose)
  (define-key evil-normal-state-map (kbd "Heu") 'web-mode-element-parent)
  (define-key evil-normal-state-map (kbd "Hew") 'web-mode-element-wrap)
  (define-key evil-normal-state-map (kbd "Hab") 'web-mode-attribute-beginning)
  (define-key evil-normal-state-map (kbd "Hae") 'web-mode-attribute-end)
  (define-key evil-normal-state-map (kbd "Hai") 'web-mode-attribute-insert)
  (define-key evil-normal-state-map (kbd "Hak") 'web-mode-attribute-kill)
  (define-key evil-normal-state-map (kbd "Han") 'web-mode-attribute-next)
  (define-key evil-normal-state-map (kbd "Has") 'web-mode-attribute-select)
  (define-key evil-normal-state-map (kbd "Hat") 'web-mode-attribute-transpose)
(define-key web-mode-map (kbd "H/") 'web-mode-element-close)
  )

  
  (define-key web-mode-map (kbd "RET") 'newline-and-indent)
  (define-key web-mode-map (kbd "<f10>") 'hg-toggle-web-element)


 (add-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys)



(provide 'hg-web-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-web-mode.el ends here
