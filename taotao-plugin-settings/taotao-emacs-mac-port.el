;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OSX使用emacs-mac-port平台设定 alt为meta
;; emacs-mac-port里面的黏贴设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (equal system-type 'darwin)
  (setq mac-option-modifier 'meta) ;; Bind meta to ALT
  (setq mac-command-modifier 'super) ;; Bind apple/command to  super if you want
  (setq mac-function-modifier 'hyper) ;; Bind function key to hyper if you want 
  )

(global-set-key (kbd "s-v") 'yank)
(provide 'taotao-emacs-mac-port)
