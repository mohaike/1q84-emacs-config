(add-hook 'js-mode-hook
          (lambda ()
            (hs-minor-mode t)))

(add-to-list 'auto-mode-alist '("\\.jsfl\\'" . javascript-mode))

(provide 'taotao-js-mode)
