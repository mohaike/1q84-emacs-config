;; 原来的是下面这个和系统重名了，虽然做了处理，不过显然不是很好用，所以用下面的别名彻底替换
;; 这个要在highlight-symbol.el里面改
;; (defalias 'highlight-symbol-at-point 'highlight-symbol) ==> (defalias 'taotao-highlight-symbol-at-point 'highlight-symbol)
;; 之后再编译下，就可以使用了
;;
;; 还需要在highlight-symbol-autoloads.el里面修改，因为上面的似乎不大管用
;; (defalias 'highlight-symbol-at-point 'highlight-symbol) ==> (defalias 'taotao-highlight-symbol-at-point 'highlight-symbol)
;;
;; 这些快捷键拿给【hl-anything】那边使用了
;; (global-set-key (kbd "M-]") 'highlight-symbol-next)
;; (global-set-key (kbd "M-[") 'highlight-symbol-prev)

(global-set-key (kbd "M-|") 'taotao-highlight-symbol-at-point)
(global-set-key (kbd "M-N") 'highlight-symbol-next)
(global-set-key (kbd "M-P") 'highlight-symbol-prev)
(global-set-key (kbd "M-r") 'highlight-symbol-query-replace)

(provide 'taotao-highlight-symbol)
