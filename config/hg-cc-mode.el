;;; Code:
(require 'cc-mode)

;;set default
(setq c-default-style "linux"
      c-basic-offset 4)

;; automatic indentation
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; auto header from header2.el


                                        ;To have Emacs update file headers automatically whenever you save a file
                                        ;To have Emacs add a file header whenever you create a new file in
;; (defun hg-gdb-many-windows-hook()
;;    (gdb-many-windows t))
;; (add-hook 'c-mode-common-hook 'hg-gdb-many-windows-hook)

(autoload 'auto-update-file-header "header2")

(add-hook 'c-mode-common-hook   'gtags-mode)
(setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))
;; dealing with "{" indentation
(sp-local-pair 'c-mode "{" nil :post-handlers '((hg-create-newline-and-enter-sexp "RET")))


;;compiling and debugging
(fset 'hg-eshell-compile-and-run
      [f8 f9 ?\C-x ?m ?m ?a ?k ?e ?  ?r ?u ?n return])

(fset 'hg-debug-compile
      [?\M-! ?m ?a ?k ?e ?  ?d ?b ?g return])

(fset 'hg-run-gdb
      [?\M-x ?g ?d ?b return return ?\M-x ?g ?d  ?b ?- ?m ?a ?n ?y
             ?- ?w ?i ?n ?d ?w ?s return])

(fset 'hg-exit-debug
      [?q return ?\M-x ?k ?i ?l ?l ?- ?b ?u ?f ?f ?e ?r ?- ?a ?n ?d ?-
          ?w ?i ?n ?d ?o ?w return])

(fset 'hg-eshell-compile-and-memcheck
      [f8 f9 ?\C-x ?m ?m ?a ?k ?e ?  ?m ?e ?m return])

(fset 'hg-compile-reset
      [?e ?x ?i ?t return f9]) ;;binded to all modes checks eshell though

(fset 'hg-compile-reset-shell
      [?e ?x ?i ?t return f5 f9]) ;;binded to all modes checks eshell though

(defun hg-exit-eshell-after-complie()
  (interactive)
  (if(string="eshell-mode" major-mode)
      (execute-kbd-macro(symbol-function 'hg-compile-reset))
    (if(string="shell-mode" major-mode)
        (execute-kbd-macro(symbol-function 'hg-compile-reset-shell))
      (if(string="gud-mode" major-mode)
          (execute-kbd-macro(symbol-function 'hg-exit-debug))
        (message "<f11> will only work in eshell or gud mode and exit it")))))




(defun hg-compile-and-run ()
  (interactive)
  (execute-kbd-macro (symbol-function 'hg-eshell-compile-and-run)))

(defun hg-compile-and-debug ()
  (interactive)
  (execute-kbd-macro (symbol-function 'hg-debug-compile))
  (execute-kbd-macro (symbol-function 'hg-run-gdb)))

(defun hg-compile-and-memcheck ()
  (interactive)
  (execute-kbd-macro (symbol-function 'hg-eshell-compile-and-memcheck)))



(eval-after-load "cc-mode"
  '(progn
     (define-key c-mode-map (kbd "<f11>") 'hg-compile-and-run)
     (define-key c-mode-map (kbd "C-c h") 'ff-find-other-file)
     (define-key c-mode-map (kbd "C-c C-c") 'mode-compile)
     (define-key c-mode-map (kbd "C-c C-k") 'mode-compile-kill)
     (define-key c-mode-map (kbd "C-c C-r") 'recompile)
     (define-key c-mode-map (kbd "<C-f11>") 'gdb)
     (define-key c-mode-map (kbd "<M-f11>") 'hg-compile-and-memcheck)))


(require 'compile)
(add-hook 'c-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   ;; emulate make's .c.o implicit pattern rule, but with
                   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
                   ;; variables:
                   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -o %s %s %s %s && ./%s"
                             (or (getenv "CC") "gcc")
                             (file-name-sans-extension file)
                             (or (getenv "CPPFLAGS") "")
                             (or (getenv "CFLAGS") "-std=gnu11 -Wall -ggdb")
                             file
                             (file-name-sans-extension file)))))))

;;mode-compile
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)


(setq compilation-finish-functions 'compile-autoclose)
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
         (bury-buffer "*compilation*")
         (winner-undo)
         (message "Build successful."))
        (t
         (message "Compilation exited abnormally: %s" string))))



(provide 'hg-cc-mode)
