(setq ag-highlight-search t)

(progn
  (require 'ag)
  (define-key ag-mode-map (kbd "x") '(lambda () (interactive) 
                                     (let (kill-buffer-query-functions) (kill-buffer-and-window)))))

(provide 'taotao-ag-mode)
