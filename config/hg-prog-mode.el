;;; hg-prog-mode.el --- progmode hooks
;; 
;; Filename: hg-progmode.el
;; Description: 
;; Author: 
;; Created: Sun Mar  9 10:53:23 2014 (+1030)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: Sun Mar  9 10:56:17 2014 (+1030)
;;     Update #: 2
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

(add-hook 'prog-mode-hook   'flyspell-prog-mode)
(add-hook 'prog-mode-hook   'which-func-mode)
;; (add-hook 'prog-mode-hook   'highlight-symbol-mode)
(add-hook 'prog-mode-hook   'flycheck-mode)

;;elisp mode
;; (add-hook 'emacs-lisp-mode-hook 'auto-make-header)



(provide 'hg-prog-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-progmode.el ends here
