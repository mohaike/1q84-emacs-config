;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 火柴人证书设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-stick-man-profile ()
  (interactive)
  ;; 证书文件路径
  (find-file "~/Documents/Project/SM/StickMan/proj.ios_mac/StickMan.xcodeproj/project.pbxproj")
  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"4b860736-43e0-4bbe-a2de-da186188b59d\";")  ;; 签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"4b860736-43e0-4bbe-a2de-da186188b59d\";")  ;; 签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"4b860736-43e0-4bbe-a2de-da186188b59d\";")  ;; 签名

  ;; (re-search-forward "PROVISIONING_PROFILE")
  ;; (forward-char 3)
  ;; (delete-line)
  ;; (insert-before-markers "\"4b860736-43e0-4bbe-a2de-da186188b59d\";")  ;; 签名

  ;; (re-search-forward "PROVISIONING_PROFILE")
  ;; (forward-char 3)
  ;; (delete-line)
  ;; (insert-before-markers "\"4b860736-43e0-4bbe-a2de-da186188b59d\";")  ;; 签名


  (save-buffer)
  (kill-this-buffer)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 火柴人证书擦除
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-stick-man-clear-profile ()
  (interactive)
  ;; 证书文件路径
  (find-file "~/Documents/Project/SM/StickMan/proj.ios_mac/StickMan.xcodeproj/project.pbxproj")
  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 清空签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 清空签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 清空签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 清空签名

  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 3)
  (delete-line)
  (insert-before-markers "\"\";")  ;; 清空签名

  (save-buffer)
  (kill-this-buffer)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 怪兽证书设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-msm-profile ()
  (interactive)
  ;; 证书文件路径
  (find-file "~/Documents/Project/GS/mysingingmonsters_client/MSMYodo2/game/iPhone/HydraGame/HydraGame.xcodeproj/project.pbxproj")
  (re-search-forward "PRODUCT_NAME")
  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 4)
  (delete-sexp)
  (insert-before-markers "c1486c56-c8d1-4b2b-b8ad-e969629768b4")  ;; 签名

  (re-search-forward "PRODUCT_NAME")
  (re-search-forward "PROVISIONING_PROFILE")
  (forward-char 4)
  (delete-sexp)
  (insert-before-markers "c1486c56-c8d1-4b2b-b8ad-e969629768b4")  ;; 签名

  (save-buffer)
  (kill-this-buffer)
  )

(provide 'taotao-xcode-projcet-code)
