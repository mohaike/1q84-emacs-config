(setq ag-highlight-search t)
(setq grep-highlight-matches t)

(progn
  (require 'eww)
  (define-key eww-mode-map (kbd "M-g") 'youdao-dictionary-search-at-point+))
 ; page down key

;; (defun xx ()
;;   "print current word."
;;   (interactive)
;;   (message "%s" (thing-at-point 'word)))

(defun xx-t ()
  "Do incremental search forward for a symbol found near point.
Like ordinary incremental search except that the symbol found at point
is added to the search string initially as a regexp surrounded
by symbol boundary constructs \\_< and \\_>.
See the command `isearch-forward-symbol' for more information."
  (interactive)
  ;; (isearch-forward-symbol nil 1)
  (let ((bounds (find-tag-default-bounds)))
    (cond
     (bounds
      (when (< (car bounds) (point))
	(goto-char (car bounds)))
      ;; (isearch-yank-string
      ;;  (buffer-substring-no-properties (car bounds) (cdr bounds)))
      (message "current symbol is: %s"
       (buffer-substring-no-properties (car bounds) (cdr bounds))))
     (t
      (message "No symbol at point")
      (message "Copy the symbol!")))))

(defun taotao-mark-language (arg)
  (interactive "^p")
  ;; 证书文件路径
  (move-beginning-of-line arg)
  (kill-line)
  (yank)
  (save-buffer)
  (next-multiframe-window)
  (yank)
  (open-line 1)
  (next-line)
  (save-buffer)
  (previous-multiframe-window)

  (move-beginning-of-line arg)
  (insert-before-markers "【")  ;; 签名
  (move-end-of-line arg)
  (insert-before-markers "】")  ;; 签名
  (next-line)
  (save-buffer)
  (move-beginning-of-line arg))

(defun taotao-cp-language (arg)
  (interactive "^p")
  (move-beginning-of-line arg)
  (kill-line)
  (yank)
  (save-buffer)
  (move-beginning-of-line arg))

(defun taotao-xxx-language-key (arg)
  (interactive "^p")
  (move-end-of-line arg)
  (insert-before-markers "	==>")
  (yank)
  (move-end-of-line arg)
  (next-line)
  (move-beginning-of-line arg)
  (save-buffer)
  
)

(provide 'taotao-mini-init)
