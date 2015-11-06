(setq ag-highlight-search t)

(defun taotao-ag-kill-buffers ()
  "Kill all `ag-mode' buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (when (eq (buffer-local-value 'major-mode buffer) 'ag-mode)
      (delete-windows-on buffer)
      (kill-buffer buffer))))

(defun taotao-ag-kill-other-buffers ()
  "Kill all `ag-mode' buffers other than the current buffer."
  (interactive)
  (let ((current-buffer (current-buffer)))
    (dolist (buffer (buffer-list))
      (when (and
             (eq (buffer-local-value 'major-mode buffer) 'ag-mode)
             (not (eq buffer current-buffer)))
        (delete-windows-on buffer)
        (kill-buffer buffer)))))

(progn
  (require 'ag)
  (define-key ag-mode-map (kbd "x") '(lambda () (interactive) 
                                     (let (kill-buffer-query-functions) (kill-buffer-and-window)))))

(provide 'taotao-ag-mode)
