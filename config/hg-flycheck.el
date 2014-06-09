

(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))
(unless (package-installed-p 'flycheck-pos-tip)
  (package-refresh-contents) (package-install 'flycheck-pos-tip))



                                        ;(add-hook 'after-init-hook 'global-flycheck-mode)

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function 'flycheck-pos-tip-error-messages)
    '(flycheck-pos-tip-timeout 10)
    '(flycheck-clang-include-path (quote ("/usr/include/gtk-3.0"
                                          "/usr/include/at-spi2-atk/2.0"
                                          "/usr/include/gio-unix-2.0/"
                                          "/usr/include/cairo"
                                          "/usr/include/pango-1.0"
                                          "/usr/include/harfbuzz"
                                          "/usr/include/atk-1.0"
                                          "/usr/include/pixman-1"
                                          "/usr/include/freetype2"
                                          "/usr/include/libdrm"
                                          "/usr/include/gdk-pixbuf-2.0"
                                          "/usr/include/libpng16"
                                          "/usr/include/glib-2.0"
                                          "/usr/lib64/glib-2.0/include"
                                          )))

    '(flycheck-clang-warnings (quote ("all" "extra")))
    '(flycheck-completion-system (quote ido))
    '(flycheck-display-errors-delay 0.8)
    '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
    '(flycheck-go-golint-executable "/data/git/go/src/bin/golint")
    '(flycheck-highlighting-mode (quote symbols))
    '(flycheck-idle-change-delay 1)
    '(flycheck-indication-mode (quote left-fringe))
    '(flycheck-standard-error-navigation t)))


(defun get-value-from-comments (marker-string line-limit)
  "gets a string from the header comments in the current buffer.
TAKEN FROM CSHARP MODE

This is used to extract the flycheck command and the compile
command from the comments.

It looks for \"marker-string:\" and returns the string that
follows it, or returns nil if that string is not found.

eg, when marker-string is \"flymake\", and the following
string is found at the top of the buffer:

flymake: csc.exe /r:Hallo.dll

...then this command will return the string

\"csc.exe /r:Hallo.dll\"

It's ok to have whitespace between the marker and the following
colon.

"

  (let (start search-limit found)
    ;; determine what lines to look in
    (save-excursion
      (save-restriction
        (widen)
        (cond ((> line-limit 0)
               (goto-char (setq start (point-min)))
               (forward-line line-limit)
               (setq search-limit (point)))
              ((< line-limit 0)
               (goto-char (setq search-limit (point-max)))
               (forward-line line-limit)
               (setq start (point)))
              (t ;0 => no limit (use with care!)
               (setq start (point-min))
               (setq search-limit (point-max))))))
    ;; look in those lines
    (save-excursion
      (save-restriction
        (widen)
        (let ((re-string
               (concat "\\b" marker-string "[ \t]*:[ \t]*\\(.+\\)$")))
          (if (and start
                   (< (goto-char start) search-limit)
                   (re-search-forward re-string search-limit 'move))

              (buffer-substring-no-properties
               (match-beginning 1)
               (match-end 1))))))))


;; vala check mode
;; (flycheck-def-option-var flycheck-vala-packages nil vala-check
;;   "A list of additional pakages for valac.

;; The value of this variable is a list of strings, where each
;; string is a package to syntax checking (compiling)."
;;   :type '(repeat (file :tag "Include package"))
;;   :safe #'flycheck-string-list-p
;;   :package-version '(flycheck . "0.15"))

(defun vala-check-set-flycheck()
  "set the flycheck compile arguments from comments in the source file
   example: //flycheck: valac --pkg gtk+-3.0 %f"

  (and (eq major-mode 'vala-mode)
       (let ((cmd-string
              (get-value-from-comments "flycheck" 100)))
         (and cmd-string
              (not (eq cmd-string ""))
              (let* ((cmd (split-string cmd-string " "))
                     (ferf (member "%f" cmd)))
                (and ferf (setcar ferf 'source))
                (put 'vala-check :flycheck-command cmd))))))


(eval-after-load "flycheck"
  '(progn
     (flycheck-define-checker vala-check
       "A Vala language checker.

See URL `https://wiki.gnome.org/Projects/Vala'."

       :command ("valac"
;                 (option-list "--pkg" flycheck-vala-packages)
                 source)
       :error-patterns

       ((error line-start
               (file-name)
               ":" line "." column "-" line "." column
               ": error" (message) line-end)
        (warning line-start
                 (file-name)
                 ":" line "." column "-" line "." column
                 ": warning: " (message) line-end))

       :modes vala-mode)

     (add-hook 'flycheck-before-syntax-check-hook #'vala-check-set-flycheck)
     (add-to-list 'flycheck-checkers 'vala-check)))





(provide 'hg-flycheck)
