(require 'hydra)
;; (global-set-key
;;  (kbd "C-M-o")
;;  (defhydra hydra-window  (:color red
;;                                  ;; :hint nil
;;                                  )
;;    "
;;   Split: _v_ert _x_:horz
;;  Delete: _o_nly  _da_ce  _dw_indow  _db_uffer  _df_rame
;;    Move: _s_wap
;;  Frames: _f_rame new  _df_ delete
;;    Misc: _m_ark _a_ce  _u_ndo  _r_edo

;; "
;;    ;; ("h" windmove-left)
;;    ;; ("j" windmove-down)
;;    ;; ("k" windmove-up)
;;    ;; ("l" windmove-right)
;;   ("l" forward-char)
;;   ("h" backward-char)
;;   ("j" next-line)
;;   ("k" previous-line)


;;    ("H" hydra-move-splitter-left)
;;    ("J" hydra-move-splitter-down)
;;    ("K" hydra-move-splitter-up)
;;    ("L" hydra-move-splitter-right)
;;    ("|" (lambda ()
;;           (interactive)
;;           (split-window-right)
;;           (windmove-right)))
;;    ("_" (lambda ()
;;           (interactive)
;;           (split-window-below)
;;           (windmove-down)))
;;    ("v" split-window-right)
;;    ("x" split-window-below)
;;    ;("t" transpose-frame "'")
;;    ;; winner-mode must be enabled
;;    ("u" winner-undo)
;;    ("r" winner-redo) ;;Fixme, not working?
;;    ("o" delete-other-windows :exit t)
;;    ("a" ace-window :exit t)
;;    ("f" new-frame :exit t)
;;    ("s" ace-swap-window)
;;    ("da" ace-delete-window)
;;    ("dw" delete-window)
;;    ("db" kill-this-buffer)
;;    ("df" delete-frame :exit t)
;;    ("q" nil)
;;    ;("i" ace-maximize-window "ace-one" :color blue)
;;    ;("b" ido-switch-buffer "buf")
;;    ("m" headlong-bookmark-jump)))

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
  ("3" taotao-gs-window)
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

  ("tg" keyboard-quit)

  ("tl" hl-line-mode)

  ;; ("ms" magit-status)

  ("dtw" delete-trailing-whitespace)
  ("dw" delete-window)

  ("wm" whitespace-mode)

  ("ts" taotao-screenshot)

  ("q" nil "quit")))

(global-set-key
 (kbd "<f1>")
 (defhydra hydra-1q84 ()
  "1●84"
  ("1" lua-mode)
  ("u" revert-buffer)
  ("h" global-hl-line-mode)
  ("j" js-mode)

  ("ts" taotao-stick-man-profile)
  ("tcs" taotao-stick-man-clear-profile)

  ("tm" taotao-msm-profile)

  ("ta" ag-files)             ;非win平台这个是需要安装ag，还要继续安装ag.el
  ("mf" toggle-frame-maximized)         ;最大化窗口

  ("," previous-multiframe-window)
  ("." next-multiframe-window)
  ("0" winner-redo)
  ("9" winner-undo)
  ("dw" delete-window)

  (")" copy-word-forward)
  ("(" copy-word-backward)
  ("cc" taotao-copy-current-word)
  ("cl" taotao-copy-end-of-line)

  ("q" nil "quit")))

(provide 'taotao-hydra)
