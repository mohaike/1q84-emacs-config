(defun taotao-toggle-frame-maximized ()
  "Toggle maximization state of the selected frame.
Maximize the selected frame or un-maximize if it is already maximized.
Respect window manager screen decorations.
If the frame is in fullscreen mode, don't change its mode,
just toggle the temporary frame parameter `maximized',
so the frame will go to the right maximization state
after disabling fullscreen mode.

Note that with some window managers you may have to set
`frame-resize-pixelwise' to non-nil in order to make a frame
appear truly maximized.

See also `toggle-frame-fullscreen'."
  (interactive)
  (if (memq (frame-parameter nil 'fullscreen) '(fullscreen fullboth))
      (modify-frame-parameters
       nil
       `((maximized
	  . ,(unless (eq (frame-parameter nil 'maximized) 'maximized)
	       'maximized))))
    (modify-frame-parameters
     nil
     `((fullscreen
	. ,(unless (eq (frame-parameter nil 'fullscreen) 'maximized)
	     'maximized))))))

(provide 'taotao-mini-init)
