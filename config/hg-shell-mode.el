;;; hg-shell-mode.el ---
;;
;; Filename: hg-shell-mode.el
;; Description:
;; Author:
;; Created: Tue Apr  8 15:53:39 2014 (+0930)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Apr  8 17:39:47 2014 (+0930)
;;     Update #: 3
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
(defun hg-clear-shell()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun hg-shell-setup()
  (define-key shell-mode-map (kbd "C-l") 'hg-clear-shell)
  (define-key shell-mode-map (kbd "<up>") 'comint-previous-input)
  (define-key shell-mode-map (kbd "<down>") 'comint-next-input))

(setq shell-mode-hook 'hg-shell-setup)
(provide 'hg-shell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-shell-mode.el ends here
