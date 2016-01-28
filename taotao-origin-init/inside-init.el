(message "\n::::::::::::::::::::::::::::::::::::::::INIT::::::::::::::::::::::::::::::::::::::::\n")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 整行选中
;; 水木社区里面看到的
;; 还写了复制和剪切的函数，如果当前有选中区域就和默认的复制/剪切一样，如果没有
;; 选中区域，就复制/剪切当前行，这三个函数都可以接收C-u number做为数字参数，
;; 传入数字几就操作几行。
;; 不过感觉很是诡异，所以我就不用了，注释掉了
;; 所以我改了一个自己的
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun yp-copy (&optional arg)
   "switch action by whether mark is active"
   (interactive "P")
   (if mark-active
       (kill-ring-save (region-beginning) (region-end))
     (let ((beg (progn (back-to-indentation) (point)))
           (end (line-end-position arg)))
       (copy-region-as-kill beg end)
       (message "Line string copied: 「%s」"
                (buffer-substring-no-properties beg end)))))

(defun taotao-copy (&optional arg)
   "switch action by whether mark is active"
   (interactive "P")
   (if mark-active
       (kill-ring-save (region-beginning) (region-end))
       (progn (taotao-mark-line arg)
	      (kill-ring-save (region-beginning) (region-end)))))

(defun yp-kill (&optional arg)
   "switch action by whether mark is active"
   (interactive "P")
   (if mark-active
       (kill-region (region-beginning) (region-end))
     (kill-whole-line arg)))

(defun yp-mark-line (&optional arg)
   (interactive "P")
   (if (region-active-p)
       (progn
         (goto-char (line-end-position 2)))
     (progn
       (back-to-indentation)
       (set-mark (point))
       (goto-char (line-end-position))))
   (setq arg (if arg (prefix-numeric-value arg)
               (if (< (mark) (point)) -1 1)))
   (if (and arg (> arg 1))
       (progn
         (goto-char (line-end-position arg)))))

(defun taotao-back-to-indentation ()
  "Move point to the first non-whitespace character on this line."
  (interactive "^")
  (beginning-of-line 1)
  ;; (skip-syntax-forward " " (line-end-position))
  ;; Move back over chars that have whitespace syntax but have the p flag.
  (backward-prefix-chars))

(defun taotao-mark-line (&optional arg)
   (interactive "P")
   (if (region-active-p)
       (progn
         (goto-char (line-end-position 2))
	 	 (taotao-back-to-indentation))
       (progn
	 (taotao-back-to-indentation)
	 (set-mark (point))
	 (goto-char (line-end-position 2))
	 	 (taotao-back-to-indentation)))
   (setq arg (if arg (prefix-numeric-value arg)
               (if (< (mark) (point)) -1 1)))
   (if (and arg (> arg 1))
       (progn
         (goto-char (line-end-position arg)))))

(global-set-key (kbd "M-w") 'taotao-copy)
(global-set-key (kbd "C-w") 'yp-kill)
(global-set-key (kbd "C-'") 'yp-mark-line)
(global-set-key (kbd "M-'") 'yp-copy)
(global-set-key (kbd "C-z") 'taotao-mark-line)
(global-set-key (kbd "s-z") 'taotao-mark-line)
(global-set-key (kbd "s-g") 'keyboard-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; taotao-copy-end-of-line是根据kill-ring-save以及line-end-position想到的
;; taotao-copy-current-word是根据李杀同学的xah-search-current-word改写的
;; 而李杀同学的xah-search-current-word又是根据我的建议改进的
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-copy-end-of-line (&optional arg) ;这个函数会把当前点到行末的字符串全部拷贝起来的
  (interactive "P")
  (kill-ring-save (point) (line-end-position))
  (message "String copied: 「%s」"
           (buffer-substring-no-properties (point) (line-end-position))))

(defun taotao-dwim-at-point ()
  "If there's an active selection, return that.
Otherwise, get the symbol at point, as a string."
  (cond ((use-region-p)
         (buffer-substring-no-properties (region-beginning) (region-end)))
        ((symbol-at-point)
         (substring-no-properties
          (symbol-name (symbol-at-point))))))

(defun taotao-copy-current-word ()      ;这个函数会拷贝全部黏在一起的字符串
  (interactive)
  (let ( ξsstr )
    (setq ξsstr (taotao-dwim-at-point))
    (setq mark-active nil)
    (kill-new ξsstr)
    (message "Current word copied: 「%s」" ξsstr)))

(global-set-key (kbd "M-s-x") 'taotao-copy-end-of-line)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 整行移动
;; 老代码(有点Bug，在更新emacs配置文件之后有时候会失灵)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun move-text-internal (arg)
;;   (cond
;;    ((and mark-active transient-mark-mode)
;;     (if (> (point) (mark))
;;         (exchange-point-and-mark))
;;     (let ((column (current-column))
;;           (text (delete-and-extract-region (point) (mark))))
;;       (forward-line arg)
;;       (move-to-column column t)
;;       (set-mark (point))
;;       (insert text)
;;       (exchange-point-and-mark)
;;       (setq deactivate-mark nil)))
;;    (t
;;     (let ((column (current-column)))
;;       (beginning-of-line)
;;       (when (or (> arg 0) (not (bobp)))
;;         (forward-line)
;;         (when (or (< arg 0) (not (eobp)))
;;           (transpose-lines arg))
;;         (forward-line -1))
;;       (move-to-column column t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun move-text-down (arg)
;;   "Move region (transient-mark-mode active) or current line
;;   arg lines down."
;;   (interactive "*p")
;;   (move-text-internal arg))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun move-text-up (arg)
;;   "Move region (transient-mark-mode active) or current line
;;   arg lines up."
;;   (interactive "*p")
;;   (move-text-internal (- arg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "s-_") 'move-text-up)
;; (global-set-key (kbd "s-+") 'move-text-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(global-set-key (kbd "s-_") 'move-region-up)
(global-set-key (kbd "s-+") 'move-region-down)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设定选中的行缩进
;; Shift the selected region right if distance is postive, left if
;; negative
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(defun shift-right-tab ()
  (interactive)
  (shift-region 4))

(defun shift-left-tab ()
  (interactive)
  (shift-region -4))

(global-set-key (kbd "s-{") 'shift-left)
(global-set-key (kbd "s-}") 'shift-right)
(global-set-key (kbd "s-[") 'shift-left-tab)
(global-set-key (kbd "s-]") 'shift-right-tab)

(global-set-key (kbd "C-_") 'shift-left)
(global-set-key (kbd "C-+") 'shift-right)
(global-set-key (kbd "C--") 'shift-left-tab)
(global-set-key (kbd "C-=") 'shift-right-tab)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 关于邪恶的Tab的解决
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; (setq indent-line-function 'insert-tab)

(setq c-default-style "ellemtel"
          c-basic-offset 4)

(add-hook 'c-mode-common-hook
              (lambda () (setq indent-tabs-mode t)))

(setq cua-auto-tabify-rectangles nil)
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; coding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 跳转到对应文件
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
;; 代码折叠
(global-set-key (kbd "<f6>") 'hs-toggle-hiding)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'ess-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'nxml-mode-hook         'hs-minor-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 位置跳转
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

(global-set-key (kbd "C-.") 'ska-point-to-register)
(global-set-key (kbd "C-,") 'ska-jump-to-register)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 类似Vim的某种效果
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c a") 'wy-go-to-char)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 匹配括号--王垠按%来对应匹配的括号
;; 匹配括号--王垠END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))

(global-set-key "%" 'match-paren)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; desktop
;; ido
;; ibuffer
;; 窗口跳转
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "desktop")
(desktop-load-default)
(desktop-read)

(require 'ido)
(ido-mode t)
(ido-everywhere t)
(put 'dired-do-rename 'ido 'find-file)
(put 'dired-do-copy 'ido 'find-file)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(when (fboundp 'winner-mode)
  (winner-mode)
  (windmove-default-keybindings))
(windmove-default-keybindings 'meta)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 基本设定
;; scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动
;; scroll-step 1 设置为每次翻滚一行，可以使页面更连续
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)                      ;取消工具栏

(scroll-bar-mode -1)                    ;取消滚动条

(delete-selection-mode t)               ;delete-selection-mode

(display-time-mode t)                   ;启用时间显示设置，在minibuffer上面的那个杠上

(setq inhibit-startup-message t)        ;关闭emacs启动时的画面

(setq gnus-inhibit-startup-message t)   ;关闭gnus启动时的画面

(setq initial-frame-alist '((width . 160) (height . 70))) ;设置启动时窗口的长宽，下面为160*70

;; (setq visible-bell t)                   ;关闭出错时的提示声
 (setq ring-bell-function 'ignore)      ;彻底不要提示，OSX 10.11有恶心的Bug

(setq track-eol t)                      ;当光标在行尾上下移动的时候，始终保持在行尾。

(setq org-startup-indented t)           ;org indent mode其实也就是org-mode的时候有缩进效果就是

(setq column-number-mode t)             ;显示列号,它显示在minibuffer上面那个杠上

(setq line-number-mode t)               ;显示行号,它显示在minibuffer上面那个杠上

(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000) ;防止页面滚动时跳动

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))) ;鼠标滚动平滑

(setq mouse-wheel-progressive-speed nil) ;鼠标滚动平滑

;; (setq default-directory "~/Documents/GS/mysingingmonsters_client/") ;设置打开文件的路径

;; 添加这个设定，是使用防止某些第三方库使用advice，不过emacs会发出警告，下面的设定是说接收这个重定义
(setq ad-redefinition-action 'accept)

(fset 'yes-or-no-p 'y-or-n-p)           ;改变Emacs要你回答yes的行为,按y或空格键表示yes，n表示no。

(global-set-key (kbd "C-S-s") 'dired-isearch-filenames-regexp) ;设置dire搜索快捷键

;; (global-set-key (kbd "M-L") 'global-linum-mode) ;global-linum-mode 开关
(global-set-key (kbd "M-L") 'downcase-word) ;global-linum-mode 开关

(global-set-key (kbd "C-(") 'winner-undo) ;窗口的后退
(global-set-key (kbd "C-)") 'winner-redo) ;窗口的前进

(global-set-key (kbd "C-c z") 'shell)   ;shell
;; (global-set-key (kbd "<f10>") 'rename-buffer) ;命名Buffer，多在开多个shell的时候使用

(global-set-key (kbd "s--") 'scroll-down-line) ;模拟鼠标滚轮向上滚动
(global-set-key (kbd "s-=") 'scroll-up-line)   ;模拟鼠标滚轮向下滚动

(global-set-key (kbd "C->") 'next-multiframe-window) ;窗口跳转上
(global-set-key (kbd "C-<") 'previous-multiframe-window) ;窗口跳转下

(global-set-key (kbd "M-K") 'backward-sexp)
(global-set-key (kbd "M-J") 'forward-sexp)

(global-set-key (kbd "M-s-f") 'find-name-dired)

(global-set-key (kbd "s-K") 'kill-buffer-and-window)

(global-set-key (kbd "<f8>") 'global-hl-line-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 时间设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface egoge-display-time
   '((((type x w32 mac))
      ;; #060525 is the background colour of my default face.
      (:foreground "#060525" :inherit bold))
     (((type tty))
      (:foreground "blue")))
   "Face used to display the time in the mode line.")

 ;; This causes the current time in the mode line to be displayed in
 ;; `egoge-display-time-face' to make it stand out visually.
 (setq display-time-string-forms
       '((propertize (concat " " 24-hours ":" minutes " ")
 		    'face 'egoge-display-time)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 据说会更加好用的注释
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not
   blank and we are not at the end of the line, then
   comment current line. Replaces default behaviour
   of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 中文编码设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setenv "LANG" "zh_CN.UTF-8")
(add-hook 'comint-output-filter-functions
            'comint-strip-ctrl-m)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 字体
;; (set-default-font "FreeMono-13")
;; (add-to-list 'default-frame-alist '(font . "FreeMono-13"))
;; -----------------------------------------------------------------------------
;; setting font for mac system
;; -----------------------------------------------------------------------------
;; Setting English Font
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil :font "Monaco 13")

;; 图形界面的时候启用配置中文字体
(if (display-graphic-p)
    ;; Chinese Font 配制中文字体
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        (font-spec :family "Kaiti SC" :size 16))))

(defun taotao-font-size (font-size)
  "Input an number and set the font size"
  (interactive "nEnter font size: ")
  (set-face-attribute 'default nil :font (concat "Monaco " (number-to-string font-size)))
  (if (display-graphic-p)
    ;; Chinese Font 配制中文字体
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        (font-spec :family "Kaiti SC" :size font-size)))))
;; Note: you can chang "Kaiti SC" to "Microsoft YaHei" or other fonts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设置中文字体等宽
;; 原文参见 http://coldnew.github.io/blog/2013/11/16_d2f3a.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar emacs-english-font "Monaco"
  "The font name of English.")

(defvar emacs-cjk-font "Kaiti SC"
  "The font name for CJK.")

(defvar emacs-font-size-pair '(15 . 18)
  "Default font size pair for (english . chinese)")

(defvar emacs-font-size-pair-list
  '(( 5 .  6) (10 . 12)
    (13 . 16) (15 . 18) (17 . 20)
    (19 . 22) (20 . 24) (21 . 26)
    (24 . 28) (26 . 32) (28 . 34)
    (30 . 36) (34 . 40) (36 . 44))
  "This list is used to store matching (englis . chinese) font-size.")

(defun font-exist-p (fontname)
  "Test if this font is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname)) nil t)))

(defun set-font (english chinese size-pair)
  "Setup emacs English and Chinese font on x window-system."

  (if (font-exist-p english)
      (set-frame-font (format "%s:pixelsize=%d" english (car size-pair)) t))

  (if (font-exist-p chinese)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset
                          (font-spec :family chinese :size (cdr size-pair))))))

(defun emacs-step-font-size (step)
  "Increase/Decrease emacs's font size."
  (let ((scale-steps emacs-font-size-pair-list))
    (if (< step 0) (setq scale-steps (reverse scale-steps)))
    (setq emacs-font-size-pair
          (or (cadr (member emacs-font-size-pair scale-steps))
              emacs-font-size-pair))
    (when emacs-font-size-pair
      (message "emacs font size set to %.1f" (car emacs-font-size-pair))
      (set-font emacs-english-font emacs-cjk-font emacs-font-size-pair))))


(defun increase-emacs-font-size ()
  "Decrease emacs's font-size acording emacs-font-size-pair-list."
  (interactive) (emacs-step-font-size 1))

(defun decrease-emacs-font-size ()
  "Increase emacs's font-size acording emacs-font-size-pair-list."
  (interactive) (emacs-step-font-size -1))

;; 最後，綁定到自己習慣的按鍵，就大功告成啦 :)

(global-set-key (kbd "C-*") 'increase-emacs-font-size)
(global-set-key (kbd "C-&") 'decrease-emacs-font-size)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Move to beginning of word before yanking word in isearch-mode.
;; Make C-s C-w and C-r C-w act like Vim's g* and g#, keeping Emacs'
;; C-s C-w [C-w] [C-w]... behaviour.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'thingatpt)

(defun my-isearch-yank-word-or-char-from-beginning ()
  "Move to beginning of word before yanking word in isearch-mode."
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string))
      (beginning-of-thing 'word))
  (isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning
			     'isearch-yank-word-or-char
			     isearch-mode-map))

(add-hook 'isearch-mode-hook
 (lambda ()
   "Activate my customized Isearch word yank command."
   (substitute-key-definition 'isearch-yank-word-or-char
			      'my-isearch-yank-word-or-char-from-beginning
			      isearch-mode-map)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copy Word
;; 无需选中可以拷贝单词
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-point (symbol &optional arg)
    "get the point"
    (funcall symbol arg)
    (point)
)

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
 "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
       (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)
      (message "Word copied: 「%s」" (buffer-substring-no-properties beg end))
      ))
)

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
    (lambda()
      (if (string= "shell-mode" major-mode)
        (progn (comint-next-prompt 25535) (yank))
      (progn (goto-char (mark)) (yank) )))))
   (if arg
       (if (= arg 1)
       nil
         (funcall pasteMe))
     (funcall pasteMe))
))

(defun copy-word-forward (&optional arg)
 "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'forward-word 'backward-word arg)
)

(defun copy-word-backward (&optional arg)
 "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
)

(global-set-key (kbd "s-)")         (quote copy-word-forward))
(global-set-key (kbd "s-(")         (quote copy-word-backward))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设定单词间移动光标设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun forward-word-to-beginning (&optional n)
  "Move point forward n words and place cursor at the beginning."
  (interactive "p")
  (let (myword)
    (setq myword
      (if (and transient-mark-mode mark-active)
        (buffer-substring-no-properties (region-beginning) (region-end))
        (thing-at-point 'symbol)))
    (if (not (eq myword nil))
      (forward-word n))
    (forward-word n)
    (backward-word n)))

(global-set-key (kbd "M-l") 'forward-word-to-beginning)      ;选中优先单词移动

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 扩大或者缩小窗口（上下）,Ctrl+{}
;; 左右的是Ctrl+,.(应该会体会到我的良苦用心吧，这个就是对应上面的)
;; 注释掉这个反正我几乎没怎么用，这个绑定还是给前面的跳转位置绑定好了
;; (global-set-key (kbd "C-}") 'enlarge-window) ;扩大窗口
;; (global-set-key (kbd "C-{") 'shrink-window)  ;缩小窗口
;; (global-set-key (kbd "C-.") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-,") 'shrink-window-horizontally)
;; 这个是设定ibuffer自动刷新的一个mode不过有个很尴尬的问题
;; 就是它会引起刚进window时候选不中的问题，所以就很鸡肋了
;; 这么来看手动g刷新也是很不错的方案
;; (add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode 1)             ;设定文本可以自动刷新，不过dired和Ibuffer依旧需要g来刷新
(add-hook 'dired-mode-hook 'auto-revert-mode)

(message "\n::::::::::::::::::::::::::::::::::::::::TINI::::::::::::::::::::::::::::::::::::::::\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 额
;; (defun newline-and-indent-relative ()
;;   "Insert a newline, then indent relative to the previous line."
;;   (interactive "*") (newline) (indent-relative))
;; (global-set-key (kbd "<backtab>") 'newline-and-indent-relative)
;; (global-set-key (kbd "<backtab>") 'indent-relative)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<backtab>") 'indent-relative-maybe)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 李杀同学关于解决搜索的方案
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-search-current-word ()
  "Call `isearch' on current word or text selection.
“word” here is A to Z, a to z, and hyphen 「-」 and underline 「_」, independent of syntax table.
URL `http://ergoemacs.org/emacs/modernization_isearch.html'
Version 2015-04-09"
  (interactive)
  (let ( ξp1 ξp2 )
    (if (use-region-p)
        (progn
          (setq ξp1 (region-beginning))
          (setq ξp2 (region-end)))
      (save-excursion
        (skip-chars-backward "-_A-Za-z0-9")
        (setq ξp1 (point))
        (right-char)
        (skip-chars-forward "-_A-Za-z0-9")
        (setq ξp2 (point))))
    (setq mark-active nil)
    (when (< ξp1 (point))
      (goto-char ξp1))
    (isearch-mode t)
    (isearch-yank-string (buffer-substring-no-properties ξp1 ξp2))))
(global-set-key (kbd "M-s ,") 'xah-search-current-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 李杀同学的dired里面用指定程序打开文件
;; 不得不说，太爱它啦~
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.

Version 2015-01-26
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'"
  (interactive)
  (let* (
         (ξfile-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (ξdo-it-p (if (<= (length ξfile-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))

    (when ξdo-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (fPath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))) ξfile-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (fPath) (shell-command (format "open \"%s\"" fPath)))  ξfile-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) ξfile-list))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 李杀同学的Open File in Desktop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-open-in-desktop ()
  "Show current file in desktop (OS's file manager)."
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. ⁖ with nautilus
    ) ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mac平台终端识别命令
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (memq window-system '(mac ns))
  (set-exec-path-from-shell-PATH))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org插入代码段
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook '(lambda ()
                            ;; turn on flyspell-mode by default
                            ;; (flyspell-mode 1)
                            ;; C-TAB for expanding
                            (local-set-key (kbd "C-<tab>")
                                           'yas/expand-from-trigger-key)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
                            ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 统计词语出现的次数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun word-count-analysis (start end)
      "Count how many times each word is used in the region.
    Punctuation is ignored."
      (interactive "r")
      (let (words)
	(save-excursion
	  (goto-char start)
	  (while (re-search-forward "\\w+" end t)
	    (let* ((word (intern (match-string 0)))
		   (cell (assq word words)))
	      (if cell
		  (setcdr cell (1+ (cdr cell)))
		(setq words (cons (cons word 1) words))))))
	(when (interactive-p)
	  (message "%S" words))
	words))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq org-export-html-style
;;  "<style type=\"text/css\">
;;     <!--/*--><![CDATA[/*><!--*/
;;       .src             { background-color: #F5FFF5; position: relative; overflow: visible; }
;;       .src:before      { position: absolute; top: -15px; background: #ffffff; padding: 1px; border: 1px solid #000000; font-size: small; }
;;       .src-sh:before   { content: 'sh'; }
;;       .src-bash:before { content: 'sh'; }
;;       .src-R:before    { content: 'R'; }
;;       .src-perl:before { content: 'Perl'; }
;;       .src-sql:before  { content: 'SQL'; }
;;       .example         { background-color: #FFF5F5; }
;;     /*]]>*/-->
;;  </style>")

(defun taotao-buffer-name ()
  (interactive)
  (setq tmp (buffer-name))
  (message tmp)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; frame尺寸设定
;; 根据系统原有的【toggle-frame-maximized】改的
;; 系统的那个函数在窗口是默认窗口大小的时候，变成最大
;; 在窗口最大的时候又变成默认窗口大小，现在的这个是直接变成最大的。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	  . ,(if t
	       'maximized))))
    (modify-frame-parameters
     nil
     `((fullscreen
	. ,(if t
	     'maximized))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; window分割策略
;; shell的window可见那么格式化后shell的window上面的window保持不变
;; 如果上面的window不存在的话就用【*scratch*】
;; shell的window不可见，那么不管shell的buffer是否存在，上面的window都使用【*scratch*】
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-judge-buffer-visiable (taotao-buffer-name) ;内部使用，判定一个window是否可视

  (let ((visible-buffers (mapcar #'(lambda (window) (buffer-name (window-buffer window))) (window-list))) window-of-buffer)
    (if (member taotao-buffer-name visible-buffers)
        t                               ;存在
      nil                               ;不存在，其实不写也可以
      )))

(defun taotao-window (&optional arg window)
  (interactive "P")

  (setq pos (point))
  (setq current-buffer-name (buffer-name))
  (setq shell-buffer-name "*shell*")
  (setq scratch-buffer-name "*scratch*")
  (setq shell-up-window scratch-buffer-name)
  (setq shell-up-window-set-to-be-scratch nil)

  (if (taotao-judge-buffer-visiable shell-buffer-name)
      (if (not (equal current-buffer-name shell-buffer-name))
          (switch-to-buffer-other-window shell-buffer-name))
    (progn
      (setq shell-up-window-set-to-be-scratch t)
      (if (get-buffer shell-buffer-name)
          (switch-to-buffer-other-window shell-buffer-name))))
  (shell)

  (if shell-up-window-set-to-be-scratch
      (setq shell-up-window scratch-buffer-name)

    (let ((other-window (windmove-find-other-window 'up arg window)))
      (cond ((null other-window)
             (setq shell-up-window scratch-buffer-name))
            ((and (window-minibuffer-p other-window)
                  (not (minibuffer-window-active-p other-window)))
             (error "Minibuffer is inactive"))

            (t
             (select-window other-window)
             (setq shell-up-window (buffer-name))))))

  (delete-other-windows)
  (taotao-toggle-frame-maximized)
  (split-window-right)
  (previous-multiframe-window)
  (split-window-right)
  (split-window-right)
  (delete-window)
  (previous-multiframe-window)
  (delete-window)
  (previous-multiframe-window)
  (split-window-below)

  (switch-to-buffer shell-up-window)    ;切到上面设定的shell上面的window

  (next-multiframe-window)

  (switch-to-buffer shell-buffer-name)  ;切到shell的buffer

  (previous-multiframe-window)
  (previous-multiframe-window)

  (switch-to-buffer current-buffer-name) ;最后切回最开始的Buffer
  (goto-char pos)                        ;并且光标移动到那个window所在的位置
  )


(defun taotao-gs-window ()
  (interactive)
  (dired "~/Documents/Project/GS/mysingingmonsters_client")
  (taotao-window)
  (dired "~/Documents/Project/GS/mysingingmonsters_client/MSMYodo2")
  )

(global-set-key (kbd "M-s-w") 'taotao-window)
(global-set-key (kbd "M-s-g") 'taotao-gs-window)


(defun taotao-stick-man-window ()
  (interactive)
  (dired "~/Documents/Project/SM")
  (taotao-window)
  (dired "~/Documents/Project/SM/StickMan/Classes/")
  )

(defun taotao-ctr2-window ()
  (interactive)
  (dired "~/Documents/Project/CTR/CTR2_ANDROID")
  (taotao-window)
  (dired "~/Documents/Project/CTR/CTR2_ANDROID/android/generated/full_free2play_yodo1/project/jni/classes/")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; copy file path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-copy-file-path (&optional φdir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
If `universal-argument' is called, copy only the dir path.
Version 2015-01-14
URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'"
  (interactive "P")
  (let ((fPath
         (if (equal major-mode 'dired-mode)
             default-directory
           (buffer-file-name))))
    (kill-new
     (if (equal φdir-path-only-p nil)
         fPath
       (file-name-directory fPath)))
    (message "File path copied: 「%s」" fPath)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 拷贝当前buffer的名字，下面的函数是根据它写的
;; (defun copy-file-name-to-clipboard ()
;;   "Copy the current buffer file name to the clipboard."
;;   (interactive)
;;   (let ((filename (if (equal major-mode 'dired-mode)
;;                       default-directory
;;                     (buffer-file-name))))
;;     (when filename
;;       (kill-new filename)
;;       (message "Copied buffer file name '%s' to the clipboard." filename))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-copy-buffer-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((buffername (buffer-name)))
    (when buffername
      (kill-new buffername)
      (message "Copied buffer name '%s' to the clipboard." buffername))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; save current file as another and keep it open
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clone-and-open-file (filename)
  "Clone the current buffer writing it into FILENAME and open it"
  (interactive "FClone to file: ")
  (save-restriction
    (widen)
    (write-region (point-min) (point-max) filename nil nil nil 'confirm))
  (find-file filename))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OSX平台终端拷贝剪切
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;; 用 progn 括起来的是一次执行多条语句
;; 这么设定是为了在图形界面下拷贝xcode里面的东西到emacs里面不会有【^M】(C+q, C+m可输出这个)，不过终端的话就没办法了，只能
;; 这么弄不然没法拷贝黏贴
(if (not (display-graphic-p))
    (progn (setq interprogram-cut-function 'paste-to-osx)
           (setq interprogram-paste-function 'copy-from-osx)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设置安装包来源
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.org/packages/")))
  (package-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 防止残废设定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'appt)
(setq appt-message-warning-time 0)      ; 0 minute time before warning
(setq diary-file "~/.emacs.d/taotao-origin-init/taotao-prevent-disable-setting/StandUp") ;diary file
(appt-activate)                         ;设定开机自动打开闹钟设定
(delete-other-windows)                  ;设定关闭日程表

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 加载hct-macro宏文件
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-file "~/.emacs.d/taotao-origin-init/taotao-macros/hct-macro.macs") ;加载hct-macro宏文件

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 全屏
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/taotao-origin-init/taotao-window")
;; (require 'taotao-fullscreen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mac平台设定emacs的默认shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq explicit-shell-file-name "/bin/bash")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defines tab spacing in sgml mode (includes XML mode)
;; source: http://www.emacswiki.org/emacs/IndentingHtml
;; 设置nxml-mode的默认缩进
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq nxml-child-indent 4
      nxml-outline-child-indent 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 相对kill-sexp的delete设定，这个sexp的设定也就是一个symbol的之间的操作
;; 比如说forward-sexp, backward-sexp之类的
;; 以及根据kill-line改写的delete-line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun delete-sexp (&optional arg)
  "Delete the sexp (balanced expression) following point.
With ARG, delete that many sexps after point.
Negative arg -N means delete N sexps before point.
This command assumes point is not in a string or comment."
  (interactive "p")
  (let ((opoint (point)))
    (forward-sexp (or arg 1))
    (delete-region opoint (point))))

(defun delete-line (&optional arg)
  (interactive "P")
  (delete-region (point)
	       ;; It is better to move point to the other end of the kill
	       ;; before killing.  That way, in a read-only buffer, point
	       ;; moves across the text that is copied to the kill ring.
	       ;; The choice has no effect on undo now that undo records
	       ;; the value of point from before the command was run.
	       (progn
		 (if arg
		     (forward-visible-line (prefix-numeric-value arg))
		   (if (eobp)
		       (signal 'end-of-buffer nil))
		   (let ((end
			  (save-excursion
			    (end-of-visible-line) (point))))
		     (if (or (save-excursion
			       ;; If trailing whitespace is visible,
			       ;; don't treat it as nothing.
			       (unless show-trailing-whitespace
				 (skip-chars-forward " \t" end))
			       (= (point) end))
			     (and kill-whole-line (bolp)))
			 (forward-visible-line 1)
		       (goto-char end))))
		 (point))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 依赖上面的自定义delete-sexp函数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/taotao-origin-init/taotao-xcode-projcet-code")
(require 'taotao-xcode-projcet-code)

(defun taotao-modeline ()
  (interactive)

  (face-remap-add-relative
   'mode-line '((:foreground "ivory" :background "DarkOrange2") mode-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 将当前光标的字母变成大写
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun taotao-uppercase-current-letter ()
  (interactive)
  (capitalize-region (point) (1+ (point))))


(provide 'inside-init)
