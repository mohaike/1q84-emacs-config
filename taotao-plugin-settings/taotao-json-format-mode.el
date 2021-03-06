(setenv "PATH" (concat (getenv "PATH") ":" "~/.emacs.d/taotao-local-plugin/json/mac"))
(add-to-list 'exec-path "~/.emacs.d/taotao-local-plugin/json/mac")

(defun taotao-json-format ()
  (interactive)
  (let (beg end)
    (if (use-region-p)
        (setq beg (region-beginning)
              end (region-end))
      (setq beg (point-min)
            end (point-max)))
    (if (executable-find "jq-osx-amd64")
        (call-process-region beg end "jq-osx-amd64" t t nil ".")
      (call-process-region beg end "python" t t nil "-mjson.tool"))))

(provide 'taotao-json-format-mode)
