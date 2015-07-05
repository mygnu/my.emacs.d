
;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
 (add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
;;            '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)


(provide 'hg-elpa-packages)
