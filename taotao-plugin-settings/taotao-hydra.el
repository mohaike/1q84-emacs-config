(require 'hydra)

(defhydra hydra-buffer-menu (:color pink
                                    :hint nil)
  "
^|^-------------------------------------+-----------------------------------+---------------------------------+----------------------------+------------------------------^|^
^|^ ^text^                                ^|^ ^highlight^                         ^|^ ^view^                            ^|^ ^search^                     ^|^ ^file^                         ^|^
^|^-------------------------------------+-----------------------------------+---------------------------------+----------------------------+------------------------------^|^
^|^ _cc_: taotao-copy-current-word        ^|^ _hm_: hl-highlight-mode             ^|^ _0_: winner-redo                  ^|^ _a_: ag-files                ^|^ _fp_: xah-copy-file-path       ^|^
^|^ _cl_: taotao-copy-end-of-line         ^|^ _hg_: hl-highlight-thingatpt-global ^|^ _9_: winner-undo                  ^|^ _ka_: ag-kill-buffers        ^|^ _fn_: copy-buffer-name         ^|^
^|^ _tf_: taotao-formula                  ^|^ _hl_: hl-highlight-thingatpt-local  ^|^ _1_: taotao-window                ^|^ _koa_: ag-kill-other-buffers ^|^ _fco_: clone-and-open-file     ^|^
^|^ _tm_: taotao-zh-parentheses           ^|^ _ug_: hl-unhighlight-all-global     ^|^ _2_: taotao-islashero-window      ^|^ _kg_: ggtags-kill-buffers    ^|^ _fe_: xah-open-in-external-app ^|^
^|^ _tu_: taotao-uppercase-current-letter ^|^ _ul_: hl-unhighlight-all-local      ^|^ _3_: taotao-stick-man-window      ^|^                            ^|^ _fo_: reveal-in-finder         ^|^
^|^ _/_: undo                             ^|^ _n_: hl-find-next-thing             ^|^ _4_: taotao-nax-runner-window     ^|^                            ^|^ _ff_: find-name-dired          ^|^
^|^ _cf_: copy-word-forward               ^|^ _p_: hl-find-prev-thing             ^|^ _<_: previous-multiframe-window   ^|^                            ^|^                              ^|^
^|^ _cb_: copy-word-backward              ^|^ _hp_: hl-paren-mode                 ^|^ _>_: next-multiframe-window       ^|^                            ^|^                              ^|^
^|^ _ms_: mark-sexp                       ^|^ _,_: highlight-symbol-prev          ^|^ _]_: scroll-up-line               ^|^                            ^|^                              ^|^
^|^ _v_: set-mark-command                 ^|^ _._: highlight-symbol-next          ^|^ _[_: scroll-down-line             ^|^                            ^|^                              ^|^
^|^ _}_: move-region-down                 ^|^ _tl_: hl-line-mode                  ^|^ _wm_: whitespace-mode             ^|^                            ^|^                              ^|^
^|^ _{_: move-region-up                   ^|^                                   ^|^ _dtw_: delete-trailing-whitespace ^|^                            ^|^                              ^|^
^|^ _z_: taotao-mark-line                 ^|^                                   ^|^ _br_: revert-buffer               ^|^                            ^|^                              ^|^
^|^ _-_: shift-left-tab                   ^|^                                   ^|^ _kb_: kill-this-buffer            ^|^                            ^|^                              ^|^
^|^ _=_: shift-right-tab                  ^|^                                   ^|^ _j_: javascript-mode              ^|^                            ^|^                              ^|^
^|^ ___: shift-left                       ^|^                                   ^|^ _ts_: taotao-screenshot           ^|^                            ^|^                              ^|^
^|^ _+_: shift-right                      ^|^                                   ^|^                                 ^|^                            ^|^                              ^|^
"

  ("cc" taotao-copy-current-word)
  ("cl" taotao-copy-end-of-line)
  ("tf" taotao-formula)
  ("tm" taotao-zh-parentheses)
  ("tu" taotao-uppercase-current-letter)
  ("/" undo)
  ("cf" copy-word-forward)
  ("cb" copy-word-backward)
  ("ms" mark-sexp)
  ("v" set-mark-command)
  ("}" move-region-down)
  ("{" move-region-up)
  ("z" taotao-mark-line)
  ("-" shift-left-tab)
  ("=" shift-right-tab)
  ("_" shift-left)
  ("+" shift-right)

  ("hm" hl-highlight-mode)
  ("hg" hl-highlight-thingatpt-global)
  ("hl" hl-highlight-thingatpt-local)
  ("ug" hl-unhighlight-all-global)
  ("ul" hl-unhighlight-all-local)
  ("n" hl-find-next-thing)
  ("p" hl-find-prev-thing)
  ("hp" hl-paren-mode)
  ("," highlight-symbol-prev)
  ("." highlight-symbol-next)
  ("tl" hl-line-mode)

  ("0" winner-redo)
  ("9" winner-undo)
  ("1" taotao-window)
  ("2" taotao-islashero-window)
  ("3" taotao-stick-man-window)
  ("4" taotao-nax-runner-window)
  ("<" previous-multiframe-window)
  (">" next-multiframe-window)
  ("]" scroll-up-line)
  ("[" scroll-down-line)
  ("wm" whitespace-mode)
  ("dtw" delete-trailing-whitespace)
  ("br" revert-buffer)
  ("kb" kill-this-buffer)
  ("j" javascript-mode)
  ("ts" taotao-screenshot)

  ("a" ag-files)
  ("ka" taotao-ag-kill-buffers)
  ("koa" taotao-ag-kill-other-buffers)
  ("kg" ggtags-kill-buffers)

  ("fp" xah-copy-file-path)
  ("fn" taotao-copy-buffer-name-to-clipboard)
  ("fco" clone-and-open-file)
  ("fe" xah-open-in-external-app)
  ("fo" reveal-in-finder)
  ("ff" find-name-dired)

  ("q" nil "quit" :color blue))

(global-set-key (kbd "<f1>") 'hydra-buffer-menu/body)

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

(provide 'taotao-hydra)
