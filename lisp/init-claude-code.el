;;; init-claude-code.el --- Claude Code CLI integration -*- lexical-binding: t -*-
;;; Commentary:

;; Configuration for integrating Claude Code CLI into Emacs using the
;; open source claude-code.el package by Steven Molitor.

;;; Code:

;; Ensure required packages are available
(maybe-require-package 'transient)
(maybe-require-package 'eat)

;; Load claude-code from submodule
(load-file (expand-file-name "site-lisp/claude-code-repo/claude-code.el" user-emacs-directory))

;; Enable claude-code mode globally
(claude-code-mode 1)

;; Set up key bindings
;; Using C-c c as the prefix key for Claude Code commands
(global-set-key (kbd "C-c c") claude-code-command-map)

;; Additional customizations
(setq claude-code-program "claude")  ; Ensure we're using the right executable
(setq claude-code-startup-delay 0.2) ; Small delay for better terminal setup

;; Configure window display for Claude buffers
(add-to-list 'display-buffer-alist
             '("^\\*claude"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 70)
               (window-parameters . ((no-delete-other-windows . t)))))

;; Optional: Add hook to run when Claude starts
(add-hook 'claude-code-start-hook
          (lambda ()
            (message "Claude Code session started")))

(defun my-claude-notify (title message)
  "Display a macOS notification with sound."
  (call-process "osascript" nil nil nil
                "-e" (format "display notification \"%s\" with title \"%s\" sound name \"Glass\""
                             message title)))

(setq claude-code-notification-function #'my-claude-notify)


(provide 'init-claude-code)
;;; init-claude-code.el ends here
