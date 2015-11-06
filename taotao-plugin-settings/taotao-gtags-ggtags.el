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
;; ggtags
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

(provide 'taotao-gtags-ggtags)
