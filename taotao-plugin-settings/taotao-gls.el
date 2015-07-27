;; OSX平台修复emacs的Bug【ls does not support --dired; see `dired-use-ls-dired' for more details.】
;; 先【brew install coreutils】安装【coreutils】
;; 更多可以看这里【http://emacsredux.com/blog/2015/05/09/emacs-on-os-x/】
(setq insert-directory-program (executable-find "gls"))

(provide 'taotao-gls)
