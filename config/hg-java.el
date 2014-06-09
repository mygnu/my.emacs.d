;;; hg-java.el ---
;;
;; Filename: hg-java.el
;; Description:
;; Author: mygnu
;; Created: Wed May 21 21:41:20 2014 (+0930)
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

;; eclim config
(unless (package-installed-p 'emacs-eclim)
  (package-refresh-contents) (package-install 'emacs-eclim))

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)

;; Variables
(setq eclim-auto-save t
      eclim-executable "/opt/eclipse/eclim"
      eclimd-executable "/opt/eclipse/eclimd"
      eclimd-wait-for-process nil
      eclimd-default-workspace "~/workspace"
      eclim-use-yasnippet t
      help-at-pt-display-when-idle t
      help-at-pt-timer-delay 0.1
      )

;; Call the help framework with the settings above & activate
;; eclim-mode

;; Hook eclim up with auto complete mode
(require 'auto-complete-config)
(ac-config-default)
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)


;; syntex checking

(require 'flymake)
(add-hook 'java-mode-hook 'flymake-mode-on)

(defun my-flymake-init ()
  (list "javac"
        (list (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-with-folder-structure))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.java$" my-flymake-init flymake-simple-cleanup))


;; (add-hook 'c-mode-common-hook   'gtags-mode)
                                        ;(add-hook 'java-mode-hook 'gtags-mode)
                                        ;(add-hook 'java-mode-hook (lambda ()
;;(setq c-basic-offset 4
;;      tab-width 4
;;      indent-tabs-mode t)))

(defun java-style-hook()
  (setq c-basic-offset 4
        tab-width 4
        c-label-offset 0
        indent-tabs-mode t
        ;;compile-command "cd ~/src/drifting/jms && mvn -q -o -DskipTests package"
        require-final-newline nil))

(add-hook 'java-mode-hook 'java-style-hook)

(sp-local-pair 'java-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))

(defun hg-java-save-and-run ()
  "bind to f11"
  (interactive)
  (save-buffer)
  (eclim-run-class))

(defun hg-java-mode-hook ()
  (auto-fill-mode)
  (gtags-mode)
  (flyspell-prog-mode)
  (flymake-mode)
                                        ;(subword-mode)
                                        ;(smartscan-mode)

  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
  (define-key c-mode-base-map (kbd "<f2>") 'eclim-problems)

  ;; Setting up a number of Java related shortcuts to mimic IDEA.
  (define-key c-mode-base-map (kbd "C-M-g") 'eclim-java-find-declaration)
  (define-key c-mode-base-map (kbd "C-M-o") 'eclim-java-import-organize)
  (define-key c-mode-base-map (kbd "C-r d") 'eclim-java-show-documentation-for-current-element)
  (define-key c-mode-base-map (kbd "M-i") 'eclim-java-implement) ;; IDEA is C-i
  (define-key c-mode-base-map (kbd "<M-RET>") 'eclim-problems-correct)
  (define-key c-mode-base-map (kbd "<M-f7>") 'eclim-java-find-references)
  (define-key c-mode-base-map (kbd "C-r C-r") 'eclim-java-refactor-rename-symbol-at-point)
  (define-key c-mode-base-map (kbd "<S-f3>") 'gtags-find-tag-from-here)
  (define-key c-mode-base-map (kbd "<f11>") 'hg-java-save-and-run)
  
  
  ;; Fix indentation for anonymous classes
  (c-set-offset 'substatement-open 0)
  (if (assoc 'inexpr-class c-offsets-alist)
      (c-set-offset 'inexpr-class 0))

  ;; Indent arguments on the next line as indented body.
  (c-set-offset 'arglist-intro '+))

(add-hook 'c-mode-common-hook 'hg-java-mode-hook)











;; java jdee mode

                                        ;(add-to-list 'load-path "~/.emacs.d/config/jdee-2.4.1/lisp")
                                        ;(load "jde")
                                        ;(require 'jde)
                                        ;(autoload 'jde-mode "jde" "Jdee Mode for Java" t)
                                        ;(add-to-list 'auto-mode-alist '("\\.java\\'" . jde-mode))



;; (eval-after-load "jde-mode"
;;   '(progn
;;      (define-key jde-mode-map (kbd "C-c C-c") 'jde-compile)
;;      ))

                                        ;(define-key jde-mode-map [C-c C-c] 'jde-compile)



(provide 'hg-java)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-java.el ends here
