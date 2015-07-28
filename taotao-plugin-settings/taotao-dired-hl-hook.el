(add-hook 'dired-mode-hook
          (lambda ()
            (hl-line-mode t)))

(provide 'taotao-dired-hl-hook)
