;;; hg-vala-mode.el ---
;;
;; Filename: hg-vala-mode.el
;; Description:
;; Author:
;; Created: Sun May  4 10:45:47 2014 (+0930)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sun May  4 10:50:04 2014 (+0930)
;;     Update #: 1
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
;(unless (package-installed-p 'vala-mode)
 ; (package-refresh-contents) (package-install 'vala-mode))

(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))
 
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c-mode-common-hook 'auto-complete-mode)
;;set default
(setq c-default-style "linux"
      c-basic-offset 4)
;; dealing with "{" indentation
(sp-local-pair 'vala-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))


 
(provide 'hg-vala-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-vala-mode.el ends here
