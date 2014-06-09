
;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)

(setq package-archives '(
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ;("elpa" . "http://tromey.com/elpa/")
                         ;("melpa" . "http://melpa.milkbox.net/packages/")
                         ))


(package-initialize)



(provide 'hg-elpa-packages)
