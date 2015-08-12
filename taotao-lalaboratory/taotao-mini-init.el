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

(provide 'taotao-mini-init)
