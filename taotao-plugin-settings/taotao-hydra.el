(require 'hydra)

(defhydra hydra-buffer-menu (:color pink
                             :hint nil)
  "
^Highlight^             ^Unhighlight^           ^Find^
^^^^^^^^-----------------------------------------------------------------
_g_: global             _ug_: uhl-global        _n_: find-next-thing
_l_: local              _ul_: uhl-local         _p_: find-prev-thing
"
  ("g" hl-highlight-thingatpt-global)
  ("l" hl-highlight-thingatpt-local)
  ("ug" hl-unhighlight-all-global)
  ("ul" hl-unhighlight-all-local)
  ("n" hl-find-next-thing)
  ("p" hl-find-prev-thing)
  ("hp" hl-paren-mode "hl-paren-mode")
  ("q" nil "quit" :color blue))
(global-set-key (kbd "M-\\") 'hydra-buffer-menu/body)

(global-set-key
 (kbd "C-M-o")
 (defhydra hydra-window  (:color red)
   "1q84-org"

  ("l" forward-char)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)

  ("s" show-all)

  ("n" outline-next-visible-heading)
  ("p" outline-previous-visible-heading)
  ("f" org-forward-heading-same-level)
  ("b" org-backward-heading-same-level)
  ("td" org-todo)


   ("q" nil)
   ("m" headlong-bookmark-jump)))


(global-set-key
 (kbd "<f2>")
 (defhydra hydra-vi (:color red)

  "vi"
  ("l" forward-char)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)

  ("/" undo)

  ("," previous-multiframe-window)
  ("." next-multiframe-window)
  ("0" winner-redo)
  ("9" winner-undo)

  ("x" kill-this-buffer)
  ("u" revert-buffer)

  ("1" taotao-window)
  ("2" taotao-stick-man-window)
  ;; ("3" taotao-gs-window)
  ("3" taotao-ctr2-window)

  ("`" mark-sexp)
  ("v" set-mark-command)
  ("e" xah-open-in-external-app)
  ("o" reveal-in-finder)
  ("cfp" xah-copy-file-path)
  ("cbn" taotao-copy-buffer-name-to-clipboard)
  ("co" clone-and-open-file)
  ("ff" find-name-dired)                ;find file in dired

  ("-" shift-left-tab)
  ("=" shift-right-tab)

  ("_" shift-left)
  ("+" shift-right)

  ("}" move-region-down)
  ("{" move-region-up)

  ("]" scroll-up-line)
  ("[" scroll-down-line)

  ("z" taotao-mark-line)

  ;; ("tg" keyboard-quit)

  ("tl" hl-line-mode)

  ;; ("ms" magit-status)

  ("dtw" delete-trailing-whitespace)
  ("dw" delete-window)

  ("wm" whitespace-mode)

  ("ts" taotao-screenshot)

  ("tb" loop-alpha)                     ;设置屏幕透明，装逼利器

  ("q" nil "quit")))

(global-set-key
 (kbd "<f1>")
 (defhydra hydra-1q84 ()
  "1●84"
  ("1" taotao-window)
  ("u" revert-buffer)
  ("h" global-hl-line-mode)
  ("j" javascript-mode)

  ;; ("ts" taotao-stick-man-profile)
  ;; ("tcs" taotao-stick-man-clear-profile)

  ;; ("oldtm" taotao-msm-profile)             ;怪兽

  ("a" ag-files)                        ;非win平台，这个是需要安装ag，还要继续安装emacs对应的ag.el
  ("xa" taotao-ag-kill-buffers)         ;同上
  ("xoa" taotao-ag-kill-other-buffers)  ;同上

  ("tg" taotao-gtags-update)            ;运行脚本~/.emacs.d/taotao-origin-init/taotao-update-gtags/taotao-gtags-command
  ("xg" ggtags-kill-buffers)            ;干掉关掉很麻烦的ggtags-navigation-mode

  ("mf" toggle-frame-maximized)         ;最大化窗口

  ("," previous-multiframe-window)
  ("." next-multiframe-window)
  ("=" winner-redo)
  ("-" winner-undo)
  ("dw" delete-window)

  ("/" undo)

  (")" copy-word-forward)
  ("(" copy-word-backward)
  ("cc" taotao-copy-current-word)
  ("cl" taotao-copy-end-of-line)

  ("sc" stickman-ui-change)
  ("sr" stickman-reflash-flafile)
  ("skt" stickman-clear-ui-tmp)         ;清除火柴人Flash文件下ui下的tmp文件夹，以及命名为tmp的文件

  ("tu" taotao-uppercase-current-letter)

  ("tf" taotao-formula)
  ("tm" taotao-zh-parentheses)

  ("fp" xah-copy-file-path)             ;get path
  ("fn" taotao-copy-buffer-name-to-clipboard) ;get name
  ("co" clone-and-open-file)

  ;; ("0" taotao-uppercase-current-letter) ;0是测试键

  ("q" nil "quit")))

(provide 'taotao-hydra)
