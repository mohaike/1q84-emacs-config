(defun my-xhtml-extras () 
   (make-local-variable 'outline-regexp) 
   (setq outline-regexp "\\s *<\\([h][1-6]\\|html\\|body\\|head\\)\\b") 
   (make-local-variable 'outline-level) 
   (setq outline-level 'my-xhtml-outline-level) 
   (outline-minor-mode 1) 
   (hs-minor-mode 1))
(defun my-xhtml-outline-level () 
   (save-excursion (re-search-forward html-outline-level)) 
   (let ((tag (buffer-substring (match-beginning 1) (match-end 1)))) 
     (if (eq (length tag) 2) 
         (- (aref tag 1) ?0) 
       0))) 

;; xml文件的代码折叠
(add-to-list 'hs-special-modes-alist
              '(nxml-mode 
                "<!--\\|<[^/>]>\\|<[^/][^>]*[^/]>" 
                "" 
                "<!--" ;; won't work on its own; uses syntax table 
                (lambda (arg) (my-nxml-forward-element)) 
                nil)) 
(defun my-nxml-forward-element () 
   (let ((nxml-sexp-element-flag)) 
     (setq nxml-sexp-element-flag (not (looking-at "<!--"))) 
     (unless (looking-at outline-regexp) 
       (condition-case nil 
           (nxml-forward-balanced-item 1) 
         (error nil))))) 
(require 'fold-dwim)

;; 设置一打开就是xml时候就可以实现折叠代码
(setq testBufferFileName (buffer-file-name))
(setq notTestBufferFileName (not testBufferFileName))

;; 假如testBufferFileName不为空的话
(if testBufferFileName
    (progn                              ;
    (setq testBufferFileNameVersion (file-name-sans-versions (buffer-file-name)))
    (setq notTestBufferFileNameVersion (not testBufferFileNameVersion)))

    (setq testBufferFileNameVersion ""))

(when (string-match "\\.\\(xml\\|x?html\\|php[34]?\\)$"
                        testBufferFileNameVersion)
      (my-xhtml-extras))

(provide 'taotao-nxml-fold)
