(setq ag-highlight-search t)
(setq grep-highlight-matches t)

(progn
  (require 'eww)
  (define-key eww-mode-map (kbd "M-g") 'youdao-dictionary-search-at-point+))
 ; page down key

(provide 'taotao-mini-init)
