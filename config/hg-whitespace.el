;;; Code:

(require 'whitespace)
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(tabs newline space-mark tab-mark newline-mark face lines-tail))
(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
      '(
        (space-mark nil) ; 32 SPACE, 183 MIDDLE DOT
        (newline-mark 10 [172 10]) ; 10 LINE FEED
        (tab-mark 9 [183 9] [92 9]) ; 9 TAB, MIDDLE DOT
        ))
;; ;; (setq whitespace-global-modes '(not org-mode web-mode "Web" emacs-lisp-mode))
(global-whitespace-mode)

(provide 'hg-whitespace)
;;;
