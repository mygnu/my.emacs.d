;; ace jump mode

(unless (package-installed-p 'ace-jump-mode)
  (package-refresh-contents) (package-install 'ace-jump-mode))

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(provide 'hg-ace-jump)
