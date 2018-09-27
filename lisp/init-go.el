(require-package 'go-mode)
(unless (version< emacs-version "24.3")
  (require-package 'company-go))

;;autocomplete
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-go))
            (company-mode)))

(setenv "GOPATH" "~/go")

;; Call Gofmt before saving
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; Godef jump key binding
(define-key go-mode-map (kbd "M-.") 'godef-jump)

(provide 'init-go)
