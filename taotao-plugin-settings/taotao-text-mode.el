(defun set-clipboard-contents-from-string (str)
    "Copy the value of string STR into the clipboard."
    (let ((x-select-enable-clipboard t))
      (x-select-text str)))

(defun taotao-what-line ()
  "Print the current line number (in the buffer) of point."
  (interactive)
  (save-restriction
    (widen)
    (save-excursion
      (beginning-of-line)
      (message "%d"
               (1+ (count-lines 1 (point)))))))

(defun taotao-copy-current-line-and-open ()
  (interactive)

  (set-clipboard-contents-from-string (taotao-what-line))
  (xah-open-in-external-app))

(global-set-key (kbd "s-e") 'taotao-copy-current-line-and-open)

(provide 'taotao-text-mode)
