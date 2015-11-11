;; 具体的可以参考 http://www.emacswiki.org/emacs/AbbrevMode
;; 现在的设定是在minibuffer里面的话【`】作为呼出简写扩展的快捷键
;; 不过如果在别的buffer的话，由于我安装了【auto-complete】
;; 似乎只要在刚刚快速的输入好简写之后再按下【TAB】,或者按照它的提示
;; 直接按下【RET】就会直接把短语扩展好，【TAB】需要刚刚输入好的时候按下才有效果
;; 而【TAB】的话有时候会呼出【auto-complete】的弹出框，这是由于这时候的【TAB】是绑定成
;; 【auto-complete】了，弹出框里面的短语一个是后面带【a】的就是扩展，没有的就是短语本身
;; 
;; 这个时候不会实现原有的设定【在abbrev之后输入任意的标点符号或者空格或者TAB就会将短语扩展】
;; 的设定，只有通过它的对应的快捷键【C-x '】才能呼出
;; 这个就避免了我哪一天想直接很多次用到短语本身，却每次都要输入【C-q】才能加空格或者别的什么
;; 只需要完整的输入短语本身就可以了，之后需要输入【TAB】的话就按下【C-q TAB】
;;
;; 在题外话一句，如果想在输入好了的短语呼出扩展可以
;; 1. 用【auto-complete】
;; 2. 用【expand-abbrev】也就是经常的【C-x '】
;;
;; 不过如果添加了
;; (setq-default abbrev-mode t)
;; 或者
 ;; (setq default-abbrev-mode t)
;; 的话，那肯定走的都是abbrev-mode的原有的设定，而【TAB】有时候会走【auto-complete】的短语补全设定
;; 

(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "/Users/1q84/.emacs.d/taotao-abbrev-defs/abbrev_defs")    ;; definitions from...

(define-key minibuffer-local-map (kbd "`") 'expand-abbrev)

(provide 'taotao-abbrev-mode)
