;;----------------------------------------------------------------------------
;; ox-reveal
;;----------------------------------------------------------------------------
;; (require-package 'ox-reveal)

(setq org-reveal-root "./reveal.js")
(add-hook 'org-mode-hook (lambda () (load-library "ox-reveal")))

(provide 'init-ppt)
