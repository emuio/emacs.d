;;; Package --- userconfig
;;; Commentary:

;;; Code:

;;----------------------------------------------------------------------------
;; %ƥ������ ��ɾ��һ�����ţ�����
;;----------------------------------------------------------------------------
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))
;; end [] match

(global-set-key [C-backspace] 'delete-pair)

;;----------------------------------------------------------------------------
;; ��M-0Ϊ�л�h/cpp����
;;----------------------------------------------------------------------------
(global-set-key "\260" 'ff-find-other-file)


;;----------------------------------------------------------------------------
;; ֧������б�����ʾ
;;----------------------------------------------------------------------------
(set-frame-font "Source Code Pro-12")
(set-fontset-font "fontset-default" (quote gb18030) (quote ("STHeiti" . "unicode-bmp")))
;;(set-language-environment 'Chinese-GB)

;;(set-keyboard-coding-system 'euc-cn)
;;(set-clipboard-coding-system 'euc-cn)
;;(set-terminal-coding-system 'euc-cn)
;;(set-buffer-file-coding-system 'euc-cn)
;;(set-selection-coding-system 'euc-cn)
;;(prefer-coding-system 'euc-cn)
;;(setq default-process-coding-system 'euc-cn)
;;(setq-default pathname-coding-system 'euc-cn)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; unicad.el �� Emacs �Զ�ʶ���ļ�����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'unicad)
(setq file-name-coding-system 'utf-8)
(setq-default coding-system-history '("utf-8" "gb2312" "latin-2" "latin-1" "gbk"))

;;----------------------------------------------------------------------------
;; cscope
;;----------------------------------------------------------------------------
(require 'xcscope)
;;(cscope-setup)
;;�ر��Զ��������ݿ⣬�ӿ�����ٶ�
;;(setq cscope-do-not-update-database t)

;;----------------------------------------------------------------------------
;; evil
;;----------------------------------------------------------------------------
(require 'evil)
(evil-mode 0)

;;----------------------------------------------------------------------------
;; Ĭ����ʾ�к�
;;----------------------------------------------------------------------------
(global-linum-mode 1)
(autoload 'thumbs "thumbs" "Preview images in a directory." t)

;;----------------------------------------------------------------------------
;; org mode
;;----------------------------------------------------------------------------
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/capture.org"))
(define-key global-map "\C-ci" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
         "* TODO %?  %t \n %i")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")))

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;----------------------------------------------------------------------------
;; tab to space
;;----------------------------------------------------------------------------
;;(setq  indent-tabs-mode nil)
;;(set-default 'tab-width 4)
;;(setq tab-width 4)
;;(loop for x downfrom 40 to 1 do
;;      (setq tab-stop-list (cons (* x (default-value tab-width)) tab-stop-list)))



;;----------------------------------------------------------------------------
;; mew -- mail
;;----------------------------------------------------------------------------
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;;----------------------------------------------------------------------------
;; emms
;;----------------------------------------------------------------------------
;;(add-to-list 'load-path "~/elisp/emms/")
;;(require 'emms-setup)
;;(emms-standard)
;;(emms-default-players)

;;----------------------------------------------------------------------------
;; ������ǰ��
;;----------------------------------------------------------------------------
(global-hl-line-mode 1)


;;----------------------------------------------------------------------------
;; w3m
;;----------------------------------------------------------------------------
;; ����w3m��ҳ
(setq w3m-home-page "http://www.baidu.com")

;; Ĭ����ʾͼƬ
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

;; ʹ��cookies
(setq w3m-use-cookies t)

;;�趨w3m���еĲ������ֱ�Ϊʹ��cookie��ʹ�ÿ��
(setq w3m-command-arguments '("-cookie" "-F"))

;; ʹ��w3m��ΪĬ�������
(setq browse-url-browser-function 'w3m-browse-url)
(setq w3m-view-this-url-new-session-in-background t)


;;��ʾͼ��
(setq w3m-show-graphic-icons-in-header-line t)
(setq w3m-show-graphic-icons-in-mode-line t)

;;C-c C-p �򿪣��������
(setq w3m-view-this-url-new-session-in-background t)


(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)
(defun remove-w3m-output-garbages ()
"ȥ��w3m���������."
(interactive)
(let ((buffer-read-only))
(setf (point) (point-min))
(while (re-search-forward "[\200-\240]" nil t)
(replace-match " "))
(set-buffer-multibyte t))
(set-buffer-modified-p nil))

(provide 'init-local)
