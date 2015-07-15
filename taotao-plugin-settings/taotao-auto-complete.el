(require 'auto-complete-config)
(ac-config-default)

(define-key ac-mode-map (kbd "M-?") 'auto-complete)
(global-set-key (kbd "M-`") 'auto-complete-mode) ;auto-complete-mode开关
(setq ac-auto-show-menu 10)             ;设置自动提示界面的显示时间

(provide 'taotao-auto-complete)
