;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gtags
;; 这个需要安装GNU GLOBAL，针对Mac平台
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons "/usr/local/share/gtags" load-path));gtags.el load-path
(autoload 'gtags-mode "gtags" "" t);gtags-mode is true
(setq c-mode-hook
      '(lambda ()
     (gtags-mode 1)));get into gtags-mode whenever you get into c-mode


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ggtags key-bind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f9>") 'ggtags-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; (setq gtags-auto-update t)

(defun ggtags-kill-buffers ()
  "Kill all `ggtags-mode' buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (when (eq (buffer-local-value 'major-mode buffer) 'ggtags-global-mode)
      (delete-windows-on buffer)
      (kill-buffer buffer))))

;; 额，虽然下面的函数有点看不懂，不过功能是和上面的是一样的
(defun taotao-ggtags-navigation-mode-abort ()
  "Abort navigation and return to where the search was started."
  (interactive)
  (ggtags-navigation-mode -1)
  (ggtags-navigation-mode-cleanup nil 0)
  ;; Run after (ggtags-navigation-mode -1) or
  ;; ggtags-global-start-marker might not have been saved.
  (when (and ggtags-global-start-marker
             (not (markerp ggtags-global-start-marker)))
    (setq ggtags-global-start-marker nil)))

(progn
  (require 'ggtags)
  (define-key ggtags-global-mode-map (kbd "x") '(lambda ()
                                                  (interactive)
                                                  (taotao-ggtags-navigation-mode-abort))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 更新ggtags
;; 以下的宏【taotao-run-eshell-command-gtags】是可以直接当成函数运行的，默认的宏是不能当成函数运行的
;; (shell "10086")                         ;创建或者有的话切换到一个名为10086的shell，shell支持只有字符串
;; 运行脚本【~/.emacs.d/taotao-origin-init/taotao-update-gtags/taotao-gtags-command.sh】
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-gtags-update ()
  "Run gtags in eshell"
  (interactive)

  (setq current-buffer-name (buffer-name))
  (eshell 65535)                        ;创建或者有的话切换到一个名为*eshell*<65535>的eshell，eshell的参数只能是数字
  (end-of-buffer)
  (taotao-run-eshell-command-gtags)     ;输入需要运行的指令，并运行
  (switch-to-buffer current-buffer-name)
  (message "Execute taotao-gtags-update end"))  

(fset 'taotao-run-eshell-command-gtags
      (lambda (&optional arg)
        "Keyboard macro. run eshell command"
        (interactive "p")
        (kmacro-exec-ring-item
         (quote
          ([?.
            ? 
            ?~ ?/ ?. ?e ?m ?a ?c ?s ?. ?d ?/
            ?t ?a ?o ?t ?a ?o ?- ?o ?r ?i ?g ?i ?n ?- ?i ?n ?i ?t ?/
            ?t ?a ?o ?t ?a ?o ?- ?u ?p ?d ?a ?t ?e ?- ?g ?t ?a ?g ?s ?/
            ?t ?a ?o ?t ?a ?o ?- ?g ?t ?a ?g ?s ?- ?c ?o ?m ?m ?a ?n ?d ?. ?s ?h
            return]
           0 "%d"))
         arg)))

(provide 'taotao-gtags-ggtags)
