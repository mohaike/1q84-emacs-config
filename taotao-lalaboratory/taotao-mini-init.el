;; (setq debug-on-error t)

;; (require 'sublimity)
;; (require 'sublimity-scroll)

;; (require 'sublimity-map)

;; (require 'multiple-cursors)



(add-to-list 'custom-theme-load-path "~/.emacs.d/taotao-local-plugin/theme")
(load-theme 'dracula t)



(set-face-foreground 'modeline "white")
(set-face-background 'modeline "purple")
(set-face-background 'modeline-inactive "light blue")


(provide 'taotao-mini-init)
