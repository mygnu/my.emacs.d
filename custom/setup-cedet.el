(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

(semantic-mode 1)

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Enable EDE only in C/C++
(require 'ede)
(global-ede-mode)

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function 'flycheck-pos-tip-error-messages)
    '(flycheck-pos-tip-timeout 10)
    '(flycheck-clang-include-path (quote ("/usr/include/qt/QtCore/"
                                          "/usr/include/gtk-3.0"
                                          "/usr/include/qt/QtGui/"
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
(add-hook 'prog-mode-hook 'flycheck-mode)


(provide 'setup-cedet)
