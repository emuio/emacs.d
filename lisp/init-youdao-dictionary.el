(require-package 'youdao-dictionary)
(setq url-automatic-caching t)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)
(provide 'init-youdao-dictionary)
