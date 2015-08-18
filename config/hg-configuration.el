

;;;;;; ;;   ;;   ;;   /;;;;  ;;;,
;;     ;;;.;;;  ;;;;  ;;  ' ;;  ;
;;;;   ;; V ;; ;;..;; ;;     ++.
;;     ;;   ;; ;;  ;; ;;  , ;  ;;
;;;;;; ;;   ;; ;;  ;; \;;;;  ;;;    INIT


                                        ;this file contains saving and buffer settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             setup Backup & Autosave directory                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Code:
;; gtags must be loaded in the beginnig
(setq load-path (cons "/usr/share/emacs24/site-lisp/global/gtags.elc"
                      load-path))
(autoload 'gtags-mode "gtags" "" t)

;; autosave dir
(defvar my-auto-save-folder "~/.emacs.d/auto-save-list/"); folder for auto-saves
(setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list/.saves-"); set prefix for auto-saves
(setq auto-save-file-name-transforms `((".*" ,my-auto-save-folder t))); location for all auto-save files
(setq tramp-auto-save-directory my-auto-save-folder); auto-save tramp files in local directory

(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
(setq backup-by-copying t) ; makes backup by coping the file
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files
(setq cerate-lockfiles nil)
;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; winner mode to save windows configuration
(if (fboundp 'winner-mode) (winner-mode 1))

;; fires when an emacs frame is created (emacsclient)
;; invoke like this ( on osx):
;; emacsclient -c -n; osascript -e "tell application \"Emacs\" to activate"
;; (add-hook 'after-make-frame-functions 'hg-full-ui)

;; hook for setting up UI when not running in daemon mode
                                        ;(add-hook 'emacs-startup-hook 'hg-full-ui)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
                                        ;(flyspell-mode t)
                                        ;(visual-line-mode t)
(setq-default indent-tabs-mode nil)
(byte-recompile-directory "." 0)


(require 'hg-smartparens)

;; (require 'hg-abbrev)
(require 'hg-ace-jump)
;; (require 'hg-alias)
;; (require 'hg-arduino)
;; (require 'hg-auto-complete) ;; also includes yasnippet
;; (require 'hg-binview)
;; (require 'hg-cc-mode)
;; (require 'hg-cedet)
(require 'hg-company)
;; (require 'hg-c-eldoc)
(require 'hg-centered-cursor)
(require 'hg-chord)
(require 'hg-color-theme)
(require 'hg-defun)
(require 'hg-defun-edit)
;; (require 'hg-diminish)
;; (require 'hg-emacs-code-browser)
(require 'hg-expand-region)
(require 'hg-fci)
(require 'hg-flycheck)
;; (require 'hg-flymake)
;; (require 'hg-go-mode)
;; (require 'hg-google-this)
;; (require 'hg-header2)
;; (require 'hg-highlight-symbol)
;; (require 'hg-icicle)
(require 'hg-ido)
(require 'hg-key-bindings)
;; (require 'hg-multiple-cursor)
;; (require 'hg-java)
(require 'hg-move-dup)
(require 'hg-prog-mode)
(require 'hg-ruby)
;; (require 'hg-python)
;; (require 'hg-scala)
(require 'hg-shell-mode)

;; (require 'hg-sr-speedbar)
;; (require 'hg-vala-mode)
(require 'hg-web-mode)
(require 'hg-whitespace)
;; (require 'hg-whole-line-or-region)


(provide 'hg-configuration)
