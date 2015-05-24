
;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


(provide 'hg-elpa-packages)
