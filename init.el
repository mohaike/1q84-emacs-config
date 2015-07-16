;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 忽略警告的设定，调试emacs的时候必须注释掉!!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (eval-after-load "warnings" 
;;     '(setq display-warning-minimum-level :error))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 不需要在线安装包的简化初始化设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/taotao-origin-init")
(require 'inside-init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 需要在线安装包的插件设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/taotao-plugin-settings")
(require 'taotao-monokai)

(require 'taotao-hl-line-and-select-color)

(require 'taotao-autopair)

(require 'taotao-browse-kill-ring)

(require 'taotao-anzu)

(require 'taotao-highlight-symbol)

(require 'taotao-youdao-dictionary)

(require 'taotao-auto-complete)

(require 'taotao-nxml-fold)

(require 'taotao-reveal-in-finder)      ;Mac在平台文件在Finder中打开的设定

(require 'taotao-dash-at-point)

(require 'taotao-lua)

(require 'taotao-hydra)

(require 'taotao-gtags-ggtags)

(require 'taotao-git-emacs)

(require 'taotao-irony-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 测试的时候用的
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/taotao-lalaboratory")
(require 'taotao-mini-init)
