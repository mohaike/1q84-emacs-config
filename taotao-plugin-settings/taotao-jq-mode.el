(setenv "PATH" (concat (getenv "PATH") ":" "~/.emacs.d/taotao-local-plugin/bin"))
(add-to-list 'exec-path "~/.emacs.d/taotao-local-plugin/bin")


(defun taotao-json-format ()
  (interactive)
  (let (beg end)
    (if (use-region-p)
        (setq beg (region-beginning)
              end (region-end))
      (setq beg (point-min)
            end (point-max)))
    (if (executable-find "jq")
        (call-process-region beg end "jq" t t nil ".")
      (call-process-region beg end "python" t t nil "-mjson.tool"))))


(provide 'taotao-jq-mode)
