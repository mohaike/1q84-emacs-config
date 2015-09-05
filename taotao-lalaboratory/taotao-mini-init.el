;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 火柴人证书设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-clear-profile ()
  (interactive)
  ;; 证书文件路径
  (find-file "~/Documents/Project/SM/StickMan/proj.ios_mac/StickMan.xcodeproj/project.pbxproj")
  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 签名

  (save-buffer)
  (kill-this-buffer)
  )

(provide 'taotao-mini-init)
