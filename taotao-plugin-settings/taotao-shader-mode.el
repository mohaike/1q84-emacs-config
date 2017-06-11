(add-hook 'shader-mode
          (lambda ()
            (hs-minor-mode t)))

(add-to-list 'auto-mode-alist '("\\.shader\\'" . shader-mode))

(provide 'taotao-shader-mode)
