(global-set-key (kbd "C-c 0") 'youdao-dictionary-search-at-point) 
(global-set-key (kbd "C-c C-0") 'youdao-dictionary-search-at-point+) 

(progn
  (require 'eww)
  (define-key eww-mode-map (kbd "M-g") 'youdao-dictionary-search-at-point+))

(provide 'taotao-youdao-dictionary)
