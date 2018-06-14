;;----------------------------------------------------------------------------
;; w3m
;;----------------------------------------------------------------------------
;; 设置w3m主页
(require-package 'w3m)
(setq w3m-home-page "http://www.bing.com")

;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

;; 使用cookies
(setq w3m-use-cookies t)

;;设定w3m运行的参数，分别为使用cookie和使用框架
(setq w3m-command-arguments '("-cookie" "-F"))

;; 使用w3m作为默认浏览器
(setq browse-url-browser-function 'w3m-browse-url)
(setq w3m-view-this-url-new-session-in-background t)


;;显示图标
(setq w3m-show-graphic-icons-in-header-line t)
(setq w3m-show-graphic-icons-in-mode-line t)

;;C-c C-p 打开，这个好用
(setq w3m-view-this-url-new-session-in-background t)

(setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)


(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)
(defun remove-w3m-output-garbages ()
  "去掉w3m输出的垃圾."
  (interactive)
  (let ((buffer-read-only))
    (setf (point) (point-min))
    (while (re-search-forward "[\200-\240]" nil t)
      (replace-match " "))
    (set-buffer-multibyte t))
  (set-buffer-modified-p nil))

(provide 'init-w3m)
