(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))

(add-to-list 'magic-mode-alist
                `(,(lambda ()
                     (and (string= (file-name-extension buffer-file-name) "h")
                          (re-search-forward "@\\<interface\\>"
					     magic-mode-regexp-match-limit t)))
                  . objc-mode))

(require 'find-file) ;; for the "cc-other-file-alist" variable

;; 这个是在系统的cc-other-file-alist的基础上新增设定
(add-to-list 'cc-other-file-alist
  	       '("\\.mm\\'"   (".h")))

;; 这个的话是在系统的cc-other-file-alist列表的额基础上增加字段
;; 具体可查看系统的cc-other-file-alist
(nconc (cadr (assoc "\\.h\\'" cc-other-file-alist)) '(".mm"))


(defadvice ff-get-file-name (around ff-get-file-name-framework
				    (search-dirs
				     fname-stub
				     &optional suffix-list))
  "Search for Mac framework headers as well as POSIX headers."
   (or
    (if (string-match "\\(.*?\\)/\\(.*\\)" fname-stub)
	(let* ((framework (match-string 1 fname-stub))
	       (header (match-string 2 fname-stub))
	       (fname-stub (concat framework ".framework/Headers/" header)))
	  ad-do-it))
      ad-do-it))
(ad-enable-advice 'ff-get-file-name 'around 'ff-get-file-name-framework)
(ad-activate 'ff-get-file-name)

(setq cc-search-directories '("." "../include" "/usr/include" "/usr/local/include/*"
			      "/System/Library/Frameworks" "/Library/Frameworks"))

(provide 'taotao-obj-mode)
