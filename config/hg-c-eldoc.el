;; eldoc mode displays the expected function arguments 
;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
(unless (package-installed-p 'c-eldoc)
  (package-refresh-contents) (package-install 'c-eldoc))

(require 'c-eldoc)
(load "c-eldoc")
(setq c-eldoc-includes "`pkg-config gtk+-2.0 libcurl libxml2 confuse --cflags` `xml2-config --cflags` -I./ -I../ ")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode) 


(provide 'hg-c-eldoc)
