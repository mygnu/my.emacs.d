
;; DEFUN.el
;;; Code:

(defun split-window-right-and-move-there-dammit ()
  (interactive)
  (split-window-right)
  (windmove-right))

(defun toggle-window-split ()
  "toggle window split between vertical and horizontal"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1 b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun hg-reset-ui (&optional frame)
  (interactive)
  (if frame
      (select-frame frame))
  (delete-other-windows)
  (if (window-system)
      (cond
       ((= 1050 (display-pixel-height)); 22" display
        (set-frame-size (selected-frame) 172 71)
        (set-frame-position (selected-frame) 0 -1050))
       ((= 1080 (display-pixel-height)); 24" display
        (set-frame-size (selected-frame) 172 76)
        (set-frame-position (selected-frame) 0 -1080))
       (t ; laptop runs 1440x900
        (set-frame-size (selected-frame) 163 53)
        (set-frame-position (selected-frame) 0 0))))
  (split-window-right))

(defun hg-full-ui (&optional frame)
  (interactive)
  (if frame
      (select-frame frame))
  (delete-other-windows)
  (if (window-system)
      (cond
       ((= 1050 (display-pixel-height)); 22" display
        (set-frame-size (selected-frame) 172 71)
        (set-frame-position (selected-frame) 0 -1050))
       ((= 1080 (display-pixel-height)); 24" display
        (set-frame-size (selected-frame) 172 76)
        (set-frame-position (selected-frame) 0 -1080))
       (t ; laptop runs 1440x900
        (set-frame-size (selected-frame) 163 53)
        (set-frame-position (selected-frame) 0 0)))))



(fset 'hg-eshell-visor-on
      [f9 ?\C-x ?1 ?\C-x ?m])
(fset 'hg-eshell-visor-off
      [?\C-c ?u ?\C-c ?y f9 ?\C-c ?y M-f9])

;; assumes using reset-ui based layout
(defun hg-toggle-eshell-visor ()
  (interactive)
  (if (string= "*eshell*" (buffer-name))
      (execute-kbd-macro (symbol-function 'hg-eshell-visor-off))
    (execute-kbd-macro (symbol-function 'hg-eshell-visor-on))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hg-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))



(defun hg-view-url ()
  "Open a new buffer containing the contents of URL."
  (interactive)
  (let* ((default (thing-at-point-url-at-point))
         (url (read-from-minibuffer "URL: " default)))
    (switch-to-buffer (url-retrieve-synchronously url))
    (rename-buffer url t)
    ;; TODO: switch to nxml/nxhtml mode
    (cond ((search-forward "<?xml" nil t) (xml-mode))
          ((search-forward "<html" nil t) (html-mode)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    enable spell chec on                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hg-turn-spell-checking-on ()
  "Turn flyspell-mode on."
  (flyspell-mode 1))

;; (defun hg-toggle-fullscreen (&optional f)
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                          '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                          '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
;; (hg-toggle-fullscreen)



;; Kill other buffers

(defun hg-kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))



;; Switch buffer between frames
(defun hg-switch-buffers-between-frames ()
  "switch-buffers-between-frames switches the buffers between the two last frames"
  (interactive)
  (let ((this-frame-buffer nil)
        (other-frame-buffer nil))
    (setq this-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (other-frame 1)
    (setq other-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (switch-to-buffer this-frame-buffer)
    (other-frame 1)
    (switch-to-buffer other-frame-buffer)))

;; switch to previous buffer
(defun hg-switch-between-two-buffers ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


;; transposing buffer between two windows
(defun hg-transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg)))
      (other-window 1))))



;;; Defuns for working with files

;; http://github.com/magnars/.emacs.d/blob/master/defuns/file-defuns.el
;;;###autoload
(defun hg-rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

;; http://github.com/magnars/.emacs.d/blob/master/defuns/file-defuns.el
;;;###autoload

(defun hg-delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))


;; byte compile lisp files after save
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(add-hook 'after-save-hook 'byte-compile-current-buffer)
 

(provide 'hg-defun)
;;; hg-dufun.el ends here
