;;----------------------------------------------------------------------------
;; %匹配括号 ，删除一对括号，键绑定
;;----------------------------------------------------------------------------

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
;; end

;;(global-set-key "%" 'match-paren) ;;暂不开启
(global-set-key [C-backspace] 'delete-pair)

;;----------------------------------------------------------------------------
;; 绑定M-0为切换h/cpp方法
;;----------------------------------------------------------------------------
(global-set-key (kbd "M-0") 'ff-find-other-file)

;;; dos2unix and clean whitespace
(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match ""))
  (whitespace-cleanup))

;; force revert buffer
(global-set-key
 (kbd "<f5>")
 (lambda (&optional force-reverting)
   "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
   (interactive "P")
   (if (or force-reverting (not (buffer-modified-p)))
       (revert-buffer :ignore-auto :noconfirm)
     (error "The buffer has been modified"))))


(defun delete-empty-lines ()
  "Delete all empty lines in the current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (beginning-of-line)
      (if (or (looking-at "^[ \t]*$")
              (string-match "png" (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
              (string-match "jpg" (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
          (delete-line)
        (forward-line 1)))))

(defun delete-image-filenames ()
  "Delete all occurrences of filenames ending with '.jpg' or '.png' in the current buffer."
  (interactive)
  (goto-char (point-min))
  (let ((case-fold-search t)) ; 忽略大小写
    (while (re-search-forward "\$\\w\\|\\s_\$\$jpg\\|png\$\\'" nil t)
      (beginning-of-match 1)
      (delete-region (point) (match-end 0)))))

(provide 'init-custom-function)
