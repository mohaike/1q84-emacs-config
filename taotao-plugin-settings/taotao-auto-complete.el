(require 'auto-complete-config)
(ac-config-default)

(define-key ac-mode-map (kbd "M-?") 'auto-complete)

;; 这个是当年【auto-complete-mode】实在是不好用才弄的, 不过现在它已经很好用了
;; 现在这个快捷键是【hl-highlight-mode】在用
;; (global-set-key (kbd "M-`") 'auto-complete-mode) ;auto-complete-mode开关
(setq ac-auto-show-menu 10)             ;设置自动提示界面的显示时间

(provide 'taotao-auto-complete)
