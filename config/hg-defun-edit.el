;;; hg-defun-edit.el ---
;;
;; Filename: hp-defun-edit.el
;; Description:
;; Author:
;; Created: Wed Apr 30 18:26:27 2014 (+0930)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri May  2 18:39:44 2014 (+0930)
;;     Update #: 17
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


(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(defun sudo-edit (&optional arg)
  "sudo edit a file"
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;; this function is to use with smartparens
(defun hg-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression,
with relevant newlines and indent."
  (indent-according-to-mode)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions
to cause them to autoindent.")


;; Behave like vi's o command
(defun hg-open-next-line (arg)
  "Move to the next line and then opens a line.
  See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (forward-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

(defun hg-open-previous-line (arg)
  "Open a new line before the current one.
   See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(defun column-newline()
  "key chord ;;"
  (interactive)
  (end-of-line)
  (insert ";")
  (when newline-and-indent
    (indent-according-to-mode)))

;; Move region or line up down
(defun hg-move-line-up ()
  "Move line at point Up"
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)
    (indent-according-to-mode)))

(defun hg-move-line-down ()
  "Move line at point Down"
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)
    (indent-according-to-mode)))

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (indent-according-to-mode)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the region up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the region down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))


(defun hg-move-line-region-up (&optional start end n)
  "Move line or region Up"
  (interactive "r\np")
  (if (use-region-p) (move-region-up start end n) (hg-move-line-up)))

(defun hg-move-line-region-down (&optional start end n)
  "Move line or region Down"
  (interactive "r\np")
  (if (use-region-p) (move-region-down start end n) (hg-move-line-down)))



;; indent the whole buffer
(defun hg-indent-whole-buffer ()
  "indent whole buffer, and Delete trailing white space"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (indent-according-to-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;duplicate current line or region
;;;###autoload
(defun hg-duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated."
  (interactive "p")
  (save-excursion
    (if (region-active-p)
        (hg-duplicate-region arg)
      (hg-duplicate-current-line arg))))

;;;###autoload
(defun hg-duplicate-region (num &optional start end)
  "Duplicates the region bounded by START and END NUM times.
If no START and END is provided, the current region-beginning and
region-end is used. Adds the duplicated text to the kill ring."
  (interactive "p")
  (let* ((start (or start (region-beginning)))
         (end (or end (region-end)))
         (region (buffer-substring start end)))
    (kill-ring-save start end)
    (goto-char start)
    (dotimes (i num)
      (insert region))))

;;;###autoload
(defun hg-duplicate-current-line (num)
  "Duplicate the current line NUM times."
  (interactive "p")
  (when (eq (point-at-eol) (point-max))
    (goto-char (point-max))
    (newline)
    (forward-char -1))
  (hg-duplicate-region num (point-at-bol) (1+ (point-at-eol))))

;; toggle quotes

(defun current-quotes-char ()
  (nth 3 (syntax-ppss)))

(defalias 'point-is-in-string-p 'current-quotes-char)

(defun move-point-forward-out-of-string ()
  (while (point-is-in-string-p) (forward-char)))

(defun move-point-backward-out-of-string ()
  (while (point-is-in-string-p) (backward-char)))

(defun alternate-quotes-char ()
  (if (eq ?' (current-quotes-char)) ?\" ?'))

;; (defun hg-toggle-quotes ()
;;   "toggle quote for a string taken from mangers emacs.d on github"
;;   (interactive)
;;   (if (point-is-in-string-p)
;;       (let ((old-quotes (char-to-string (current-quotes-char)))
;;             (new-quotes (char-to-string (alternate-quotes-char)))
;;             (start (make-marker))
;;             (end (make-marker)))
;;         (save-excursion
;;           (move-point-forward-out-of-string)
;;           (backward-delete-char 1)
;;           (set-marker end (point))
;;           (insert new-quotes)
;;           (move-point-backward-out-of-string)
;;           (delete-char 1)
;;           (insert new-quotes)
;;           (set-marker start (point))
;;           (replace-string new-quotes (concat "\\" new-quotes) nil start end)
;;           (replace-string (concat "\\" old-quotes) old-quotes nil start end)))
;;     (error "Point isn\'t in a string")))

(defun new-line-dwim ()
  (interactive)
  (let ((break-open-pair (or (and (looking-back "{" 1) (looking-at "}"))
                             (and (looking-back ">" 1) (looking-at "<"))
                             (and (looking-back "(" 1) (looking-at ")"))
                             (and (looking-back "\\[" 1) (looking-at "\\]")))))
    (newline)
    (when break-open-pair
      (save-excursion
        (newline)
        (indent-for-tab-command)))
    (indent-for-tab-command)))

;; (defun ido-imenu ()
;;   "Update the imenu index and then use ido to select a symbol to navigate to.
;; Symbols matching the text at point are put first in the completion list."
;;   (interactive)
;;   (imenu--make-index-alist)
;;   (let ((name-and-pos '())
;;         (symbol-names '()))
;;     (flet ((addsymbols
;;             (symbol-list)
;;             (when (listp symbol-list)
;;               (dolist (symbol symbol-list)
;;                 (let ((name nil) (position nil))
;;                   (cond
;;                    ((and (listp symbol) (imenu--subalist-p symbol))
;;                     (addsymbols symbol))

;;                    ((listp symbol)
;;                     (setq name (car symbol))
;;                     (setq position (cdr symbol)))

;;                    ((stringp symbol)
;;                     (setq name symbol)
;;                     (setq position (get-text-property 1 'org-imenu-marker symbol))))

;;                   (unless (or (null position) (null name))
;;                     (add-to-list 'symbol-names name)
;;                     (add-to-list 'name-and-pos (cons name position))))))))
;;       (addsymbols imenu--index-alist))
;;     ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
;;     (let ((symbol-at-point (thing-at-point 'symbol)))
;;       (when symbol-at-point
;;         (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
;;                (matching-symbols (delq nil (mapcar (lambda (symbol)
;;                                                      (if (string-match regexp symbol) symbol))
;;                                                    symbol-names))))
;;           (when matching-symbols
;;             (sort matching-symbols (lambda (a b) (> (length a) (length b))))
;;             (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
;;                   matching-symbols)))))
;;     (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
;;            (position (cdr (assoc selected-symbol name-and-pos))))
;;       (push-mark (point))
;;       (goto-char position))))


(provide 'hg-defun-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-defun-edit.el ends here
