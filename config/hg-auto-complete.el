;;; auto complete mode
;;; should be loaded after yasnippet so that they can work together
(unless (package-installed-p 'auto-complete)
  (package-refresh-contents) (package-install 'auto-complete))
(unless (package-installed-p 'ac-ispell)
  (package-refresh-contents) (package-install 'ac-ispell))

;;popup is required for yasnippet
(unless (package-installed-p 'popup)
  (package-refresh-contents) (package-install 'popup))

(unless (package-installed-p 'yasnippet)
  (package-refresh-contents) (package-install 'yasnippet))

                                        ;(require 'cl)
(require 'yasnippet)
(setq yas-snippet-dirs "~/.emacs.d/config/snippets/") ; my snippets

(yas-global-mode t)

(ac-config-default)

(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/config/dict")
(setq ac-quick-help-delay 0.3)
(setq ac-auto-start 3) ;; so it starts after the third letter
(setq ac-auto-show-menu 1)
(setq ac-menu-height 10)
(setq ac-ignore-case nil)
(setq ac-use-menu-map t)
(global-auto-complete-mode t)
(setq ac-dwim t)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
;; ;; dirty fix for having AC everywhere
;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                            (auto-complete-mode 1))
;;                        ))
;; (real-global-auto-complete-mode t)

;; Completion words longer than 4 characters
(custom-set-variables
 '(ac-ispell-requires 4)
 '(ac-ispell-fuzzy-limit 2))

(eval-after-load "auto-complete"
  '(progn
     (ac-ispell-setup)))

(add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
(add-hook 'mail-mode-hook 'ac-ispell-ac-setup)

(provide 'hg-auto-complete)
