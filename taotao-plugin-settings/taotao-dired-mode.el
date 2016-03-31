;; dired-mode 绑定高亮
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (hl-line-mode t)))

;; dired 显示时间, 文件大小优化
;; (setq dired-listing-switches "-Al --si --time-style long-iso")

(defun taotao-copy-dired-file-path ()
  "Copy dired current file path to `kill-ring'."
  (interactive)
  (setq t-dired-file-path (dired-get-filename))
  (kill-new t-dired-file-path)
  (message "Dired file path copied: 「%s」" t-dired-file-path))

(progn
  (require 'dired)
  (define-key dired-mode-map (kbd "z") 'taotao-copy-dired-file-path))

(provide 'taotao-dired-mode)
