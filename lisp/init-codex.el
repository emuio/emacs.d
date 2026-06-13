;;; init-codex.el --- Codex CLI integration -*- lexical-binding: t -*-
;;; Commentary:

;; Configuration for integrating the official Codex CLI into Emacs using the
;; local codex.el submodule in site-lisp/codex.el.

;;; Code:

;; Optional UI helpers used by codex.el.  vterm is the default backend;
;; transient powers `codex-menu'.
(maybe-require-package 'vterm)
(maybe-require-package 'transient)

(let ((codex-file (expand-file-name "site-lisp/codex.el/codex.el"
                                    user-emacs-directory)))
  (if (file-readable-p codex-file)
      (progn
        (require 'codex)
        (require 'mwheel)
        ;; Use a separate prefix from claude-code's C-c c.
        (global-set-key (kbd "C-c d") codex-command-map)
        (defun emuio/codex--sgr-wheel-sequence (button col row)
          "Return an SGR mouse wheel sequence for BUTTON at COL and ROW.
COL and ROW are zero-based Emacs coordinates; terminal mouse protocols use
one-based coordinates."
          (format "\e[<%d;%d;%dM"
                  button
                  (1+ (max 0 (or col 0)))
                  (1+ (max 0 (or row 0)))))

        (defun emuio/codex--event-col-row (event)
          "Return zero-based terminal coordinates for mouse EVENT."
          (let ((cell (posn-col-row (event-start event))))
            (cons (or (car-safe cell) 0)
                  (or (cdr-safe cell) 0))))

        (defun emuio/codex-vterm-send-wheel (event button)
          "Forward mouse wheel EVENT as terminal mouse BUTTON in Codex vterm."
          (if (and (derived-mode-p 'vterm-mode)
                   (bound-and-true-p codex--tmux-target-session))
              (let* ((cell (emuio/codex--event-col-row event))
                     (sequence (emuio/codex--sgr-wheel-sequence
                                button (car cell) (cdr cell))))
                (vterm-send-string sequence))
            (mwheel-scroll event)))

        (defun emuio/codex-vterm-wheel-up (event)
          "Forward wheel-up EVENT to the Codex tmux session."
          (interactive "e")
          (emuio/codex-vterm-send-wheel event 64))

        (defun emuio/codex-vterm-wheel-down (event)
          "Forward wheel-down EVENT to the Codex tmux session."
          (interactive "e")
          (emuio/codex-vterm-send-wheel event 65))

        (defvar emuio/codex-vterm-wheel-mode-map
          (let ((map (make-sparse-keymap)))
            (define-key map [mouse-4] #'emuio/codex-vterm-wheel-up)
            (define-key map [mouse-5] #'emuio/codex-vterm-wheel-down)
            (define-key map [wheel-up] #'emuio/codex-vterm-wheel-up)
            (define-key map [wheel-down] #'emuio/codex-vterm-wheel-down)
            map)
          "Keymap for forwarding Codex vterm wheel events to tmux.")

        (define-minor-mode emuio/codex-vterm-wheel-mode
          "Forward mouse wheel events from Codex vterm buffers to tmux."
          :lighter nil
          :keymap emuio/codex-vterm-wheel-mode-map)

        (defun emuio/codex-vterm-enable-wheel-mode ()
          "Enable tmux mouse wheel forwarding in the current Codex vterm buffer."
          (when (and (derived-mode-p 'vterm-mode)
                     (fboundp 'codex--buffer-tmux-session))
            (when-let ((session (codex--buffer-tmux-session (current-buffer))))
              (setq-local codex--tmux-target-session session)
              (emuio/codex-vterm-wheel-mode 1))))

        (with-eval-after-load 'vterm
          (define-key vterm-mode-map [mouse-4] #'emuio/codex-vterm-wheel-up)
          (define-key vterm-mode-map [mouse-5] #'emuio/codex-vterm-wheel-down)
          (define-key vterm-mode-map [wheel-up] #'emuio/codex-vterm-wheel-up)
          (define-key vterm-mode-map [wheel-down] #'emuio/codex-vterm-wheel-down)
          (add-hook 'vterm-mode-hook #'emuio/codex-vterm-enable-wheel-mode)
          (dolist (buffer (buffer-list))
            (with-current-buffer buffer
              (emuio/codex-vterm-enable-wheel-mode))))
        ;; Keep defaults explicit for easier local development and updates.
        (setq codex-program "codex"
              codex-backend 'vterm
              codex-use-tmux t
              codex-display-full-frame t
              codex-vterm-max-scrollback 5000)
        (add-hook 'codex-start-hook
                  (lambda ()
                    (message "Codex session started"))))
    (message "codex.el submodule not found at %s; skipping codex setup" codex-file)))

(provide 'init-codex)
;;; init-codex.el ends here
