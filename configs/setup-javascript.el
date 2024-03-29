(use-package js2-mode
  :ensure t
  :init
  (setq js-indent-level 2)
  (setq js-basic-indent 2)
  (setq-default js2-basic-indent 2
                js2-basic-offset 2
                js-switch-indent-offset 2
                js2-auto-indent-p t
                js2-cleanup-whitespace t
                js2-enter-indents-newline t
                js2-indent-on-enter-key t
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))
  (add-hook 'js2-mode-hook
            '(lambda ()
               (electric-pair-mode)))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

(provide 'setup-javascript)
