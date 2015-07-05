;;; hg-go-mode.el ---
;;
;; Filename: hg-go-mode.el
;; Description:
;; Author:
;; Created: Wed Mar 26 14:54:57 2014 (+1030)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Mar 26 19:30:04 2014 (+1030)
;;     Update #: 8
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
(require 'go-autocomplete)

(require 'auto-complete-config)
;;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

(defun go-run-buffer()
"Runs current file in command line"
  (interactive)
  (when (buffer-modified-p)
    (when (y-or-n-p "Buffer modified. Do you want to save first?")
      (save-buffer) ) )
  (shell-command (concat "go run " (buffer-name))))

(defun go-kill()
  (interactive)
  (if (go-mode-in-string)
      (paredit-kill-line-in-string)
    (paredit-kill)))

(defun go-backward-delete()
  (interactive)
  (if (go-mode-in-string)
      (paredit-backward-delete-in-string)
    (paredit-backward-delete)))

;;; ### Golang ###



(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c")  'go-run-buffer)
            (local-set-key (kbd "C-c C-f") 'gofmt)
            (local-set-key (kbd "C-c C-d") 'godoc)
            (local-set-key (kbd "C-c C-a") 'go-import-add)
            (local-set-key (kbd "C-8") 'godef-jump)
            (lacal-set-key (kbd "C-u C-8") 'godef-jump-other-window)
            (local-set-key (kbd "C-k") 'go-kill)
            (local-set-key (kbd "M-o") 'go-backward-delete)
            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
            (add-hook 'before-save-hook 'gofmt-before-save)
            (local-set-key (kbd "C-c i") 'go-goto-imports)))


(provide 'hg-go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-go-mode.el ends here
