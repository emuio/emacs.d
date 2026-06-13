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
        ;; Use a separate prefix from claude-code's C-c c.
        (global-set-key (kbd "C-c d") codex-command-map)
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
