(setq user-full-name "Ming Li")
(setq user-mail-address "liming.dl@gmail.com")

(setq package-list '(solarized-theme flutter dart-mode helm helm-ag json-mode magit))

(setenv "PATH" (concat "/usr/local/bin:/usr/local/go/bin:/usr/bin:/bin" (getenv "PATH")))

;; add MELPA package server
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)



(unless package-archive-contents
  (package-refresh-contents))


; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


(setq tab-width 2
      indent-tabs-mode nil)

(add-to-list 'load-path (expand-file-name "configs" user-emacs-directory))

;; if not yet installed, install package use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq user-full-name "Ming Li"
      user-mail-address "liming.dl@gmail.com")

(setq make-backup-files nil)
(load-theme 'solarized-dark t)

;; load org package and our emacs-config.org file
(require 'org)
(add-hook 'org-mode-hook 'turn-on-flyspell 'append)
(setq org-agenda-files (quote ("~/Dropbox/notes")))
(global-set-key "\C-ca" 'org-agenda)

(use-package helm
             :diminish helm-mode
             :init
             (progn
               (require 'helm-config)
               (setq helm-candidate-number-limit 100)
               ;; From https://gist.github.com/antifuchs/9238468
               (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
                     helm-input-idle-delay 0.01  ; this actually updates things
                     ; reeeelatively quickly.
                     helm-yas-display-key-on-candidate t
                     helm-quick-update t
                     helm-M-x-requires-pattern nil
                     helm-ff-skip-boring-files t)
               (helm-mode))
             :bind (("C-c h" . helm-mini)
                    ("C-h a" . helm-apropos)
                    ("C-x C-f" . helm-find-files)
                    ("C-x C-b" . helm-buffers-list)
                    ("C-x b" . helm-buffers-list)
                    ("M-y" . helm-show-kill-ring)
                    ("M-x" . helm-M-x)
                    ("C-x c o" . helm-occur)
                    ("C-x c b" . my/helm-do-grep-notes)
                    ("C-c f" . helm-do-grep-ag)
                    ("C-x c SPC" . helm-all-mark-rings)))
(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") #'helm-select-action)
(define-key helm-map (kbd "C-<tab>") #'helm-select-action)
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

(use-package helm-ag
             :ensure helm-ag
             :bind ("C-c p g" . helm-projectile-ag)
             :commands (helm-ag helm-projectile-ag)
             :init (setq helm-ag-insert-at-point 'symbol
                         helm-ag-command-option "--path-to-ignore ~/.agignore"))

(use-package projectile
             :ensure t
             :bind (("C-c p s" . projectile-switch-open-project)
                    ("C-c p p" . projectile-switch-project))
             :config
             (projectile-global-mode)
             (setq projectile-enable-caching t))

(use-package helm-projectile
             :ensure t
             :bind ("C-c p f" . helm-projectile-find-file)
             :config
             (helm-projectile-on))

(use-package go-mode
             :ensure t
             :init
             (progn
               (setq gofmt-command "goimports")
               (add-hook 'before-save-hook 'gofmt-before-save)
               (bind-key [remap find-tag] #'godef-jump))
             :config
             (add-hook 'go-mode-hook 'electric-pair-mode))

(use-package go-eldoc
             :ensure t
             :defer
             :init
             (add-hook 'go-mode-hook 'go-eldoc-setup))

;; Typescript IDE
(use-package typescript-mode
             :ensure t
             :config
             (setq
               typescript-indent-level 2
               typescript-auto-indent-flag 0))

(defvar my/notes-directory "~/Dropbox/notes")
(defun my/helm-do-grep-notes ()
  "Search my notes."
  (interactive)
  (helm-do-grep-1 (list my/notes-directory)))


;; global keys
(global-set-key (kbd "C-]") 'personal/goto-paren)
(global-set-key (kbd "M-<SPC>") 'set-mark-command)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(use-package exec-path-from-shell
             :if (memq window-system '(mac ns))
             :ensure t
             :config
             (exec-path-from-shell-initialize))

(setenv "PATH"
        (concat
          "/usr/local/Cellar/the_silver_searcher/0.31.0/bin" ":"
          "/usr/local/bin" ":"
          (getenv "PATH")
          )
        )

;; global configuration
(setq tab-width 2
      indent-tabs-mode nil)
(tool-bar-mode -1)
(global-linum-mode 1)
(set-default-font "Inconsolata-12")
(global-auto-revert-mode)
(setq-default indent-tabs-mode nil)
(setq magic-git-executable "git")

(require 'setup-javascript)
(require 'setup-c)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-missing-semi-warning nil)
 '(org-agenda-files (quote ("~/Dropbox/Notes/work.org")))
 '(package-selected-packages
   (quote
    (flutter csharp-mode dotnet nodejs-repl prettier-js js2-refactor js-comint company-tern tern markdown-mode web-mode exec-path-from-shell go-eldoc go-mode go typescript-mode helm-projectile projectile json-mode lua-mode helm-ag use-package solarized-theme magit helm)))
 '(package-selected-packagesx
   (quote
    (helm-projectile projectile json-mode lua-mode helm-ag use-package solarized-theme magit helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

