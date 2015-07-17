(defun taotao-screenshot ()                                                                     
  "Take a screenshot into a unique-named file in the current buffer file                    
directory and insert a link to this file."                                                  
  (interactive)                                                                             
  (setq filename                                                                            
        (concat (make-temp-name "./") ".png"))                                              
  (setq fullfilename                                                                        
                 (concat (file-name-directory (buffer-file-name)) "images/blog/" filename)) 
  (if (file-accessible-directory-p (concat (file-name-directory                             
                                            (buffer-file-name)) "images/blog/"))            
      nil                                                                                   
    (make-directory "images/blog/" t))                                                      
  (call-process-shell-command "screencapture" nil nil nil nil "-i" (concat                  
                                                            "\"" fullfilename "\"" ))       
  (insert (concat "[[./images/blog/" filename "]]"))                                        
  (org-display-inline-images)                                                               
)                                                                                           

(provide 'taotao-org-mode)
