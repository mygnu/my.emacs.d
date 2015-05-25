;;; hg-move-dup.el --- 
;; 
;; Filename: hg-move-dup.el
;; Description: 
;; Author: harry
;; Created: Mon May 25 21:30:46 2015 (+1000)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: 
;;     Update #: 0
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(unless (package-installed-p 'move-dup)
  (package-refresh-contents) (package-install 'move-dup))

(move-dup-mode t)
;; move duplicate stuff
(eval-after-load 'move-dup
  '(progn
     (global-set-key (kbd "M-<up>") 'md/move-lines-up)
     (global-set-key (kbd "M-<down>") 'md/move-lines-down)
     (global-set-key (kbd "C-S-<up>") 'md/duplicate-up)
     (global-set-key (kbd "C-S-<down>") 'md/duplicate-down)))

(provide 'hg-move-dup)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hg-move-dup.el ends here
