(require 'hydra)
(global-set-key
 (kbd "C-M-o")
 (defhydra hydra-window  (:color red
                         :hint nil)
   "
  Split: _v_ert _x_:horz
 Delete: _o_nly  _da_ce  _dw_indow  _db_uffer  _df_rame
   Move: _s_wap
 Frames: _f_rame new  _df_ delete
   Misc: _m_ark _a_ce  _u_ndo  _r_edo"
   ("h" windmove-left)
   ("j" windmove-down)
   ("k" windmove-up)
   ("l" windmove-right)
   ("H" hydra-move-splitter-left)
   ("J" hydra-move-splitter-down)
   ("K" hydra-move-splitter-up)
   ("L" hydra-move-splitter-right)
   ("|" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right)))
   ("_" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down)))
   ("v" split-window-right)
   ("x" split-window-below)
   ;("t" transpose-frame "'")
   ;; winner-mode must be enabled
   ("u" winner-undo)
   ("r" winner-redo) ;;Fixme, not working?
   ("o" delete-other-windows :exit t)
   ("a" ace-window :exit t)
   ("f" new-frame :exit t)
   ("s" ace-swap-window)
   ("da" ace-delete-window)
   ("dw" delete-window)
   ("db" kill-this-buffer)
   ("df" delete-frame :exit t)
   ("q" nil)
   ;("i" ace-maximize-window "ace-one" :color blue)
   ;("b" ido-switch-buffer "buf")
   ("m" headlong-bookmark-jump)))

(global-set-key
 (kbd "<f2>")
 (defhydra hydra-vi (:pre (set-cursor-color "#40e0d0")
                    :post (progn
                            (set-cursor-color "#ffffff")
                            (message
                             "Thank you, come again.")))
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
  ("2" taotao-gs-window)
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

  ("g" keyboard-quit)

  ("q" nil "quit")))
(provide 'taotao-hydra)
