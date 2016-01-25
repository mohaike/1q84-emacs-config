;; dired-mode 绑定高亮
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (hl-line-mode t)))

;; dired 显示时间, 文件大小优化
(setq dired-listing-switches "-Al --si --time-style long-iso")

(provide 'taotao-dired-mode)
