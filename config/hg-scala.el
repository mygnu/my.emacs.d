;;; hg-scala-mode.el ---
;;
;; Filename: hg-scala-mode.el
;; Description:
;; Author: mygnu
;; Created: Tue May 20 22:47:56 2014 (+0930)
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;     Update #: 0
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

(add-hook 'scala-mode-hook '(lambda ()
                              ;; sbt-find-definitions is a command that tries to find (with grep)
                              ;; the definition of the thing at point.
                              (local-set-key (kbd "M-.") 'sbt-find-definitions)

                              ;; use sbt-run-previous-command to re-compile your code after changes
                              (local-set-key (kbd "C-x '") 'sbt-run-previous-command)
                              ))

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(eval-after-load "scala-mode"
  '(progn
     (define-key scala-mode-map (kbd "<f9>") 'ensime-builder-build)
     (define-key scala-mode-map (kbd "<f10>") 'ensime-inf-switch)))

(eval-after-load "scala-mode"
  '(progn
     (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
     (define-key scala-mode-map (kbd "<f9>") 'scala-run)
     (define-key scala-mode-map (kbd "RET") 'newline-and-indent)
     ))

(defun scala-run ()
  (interactive)
  (ensime-sbt-action "run")
  (ensime-sbt-action "~compile")
  (let ((c (current-buffer)))
    (switch-to-buffer-other-window
     (get-buffer-create (ensime-sbt-build-buffer-name)))
    (switch-to-buffer-other-window c)))
(setq exec-path
      (append exec-path (list "~/.opt/scala/bin"))) ;;REPLACE THIS with the directory of your scalac executable!


(provide 'hg-scala)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-scala-mode.el ends here
