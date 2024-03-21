;;; init-java.el --- Support for Java and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'lsp-java)
(add-hook 'java-mode-hook #'lsp)


(provide 'init-java)
;;; init-javascript.el ends here
