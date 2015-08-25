(unless (package-installed-p 'company)
  (package-refresh-contents) (package-install 'company))
(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))

;; (package-require 'company)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-\\") 'company-complete)

(setq company-global-modes '(not term-mode))

(setq company-minimum-prefix-length 2
      company-idle-delay 0.3
      ;; company-selection-wrap-around t
      ;; company-show-numbers t
      company-tooltip-align-annotations t
      company-begin-commands '(self-insert-command)
      company-tooltip-limit 10
      company-tooltip-flip-when-above t
      company-require-match nil)

;;; Javascript

;; (package-require 'company-tern)
(unless (package-installed-p 'company-tern)
  (package-install 'company-tern))
(add-to-list 'company-backends 'company-tern)

(unless (package-installed-p 'company-web)
  (package-install 'company-web))

(add-to-list 'company-backends 'company-web-html)
(add-to-list 'company-backends 'company-web-jade)
(add-to-list 'company-backends 'company-web-slim)


(require 'yasnippet)
(setq yas-snippet-dirs "~/.emacs.d/config/snippets/") ; my snippets

(yas-global-mode t)

(provide 'hg-company)
