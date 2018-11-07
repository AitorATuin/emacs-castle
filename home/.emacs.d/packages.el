;; Define what packages do we use using quelpa and use-package
(defmacro use-package-github (provides repo code)
  `(use-package ,provides
     :ensure t
     :quelpa (,provides :fetcher github :repo ,repo)
     ,@code))

;; popup-el
(use-package popup
  :ensure t
  :quelpa (popup :fetcher github :repo "auto-complete/popup-el")
  :config
  (defun describe-function-in-popup () ;; help popup
    (interactive)
    (let* ((thing (symbol-at-point))
           (description (save-window-excursion
                          (describe-function thing)
                          (switch-to-buffer "*Help*")
                          (buffer-string))))
      (popup-tip description
		 :point (point)
		 :around t
		 :height 30
		 :scroll-bar t
		 :margin t)))
  (global-set-key (kbd "C-1") 'describe-function-in-popup))

;; company-mode
(use-package company
  :ensure t
  :quelpa ((company :fetcher github :repo "company-mode/company-mode"))
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(defun some-files (file-candidates)
  (filter #'file-exists-p file-candidates))

(defun some-file (file-candidates)
  (car (some-files file-candidates)))

;; python lsp configuration
(defun py-requirements-file (requirements-candidates)
  (some-files requirements-candidates))

(defun py-create-venv (path) nil)

(defun py-lsp-root-init (root)
  root)

;; elixir lsp configuration
(defun ex-lsp-root-init (root)
  root)

;; lsp-mode package
(use-package lsp-mode
  :quelpa (lsp-mode :fetcher github :repo "emacs-lsp/lsp-mode")
  :after (lsp-ui projectile)
  :config
  (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  (lsp-define-stdio-client
   lsp-python "python"
   (lambda ()
     (let ((root (funcall #'projectile-project-root)))
       (cond ((eq root nil) (py-lsp-root-init pwd))
	     (t (py-lsp-root-init root)))))
   '("pyls" "--log-file" "/home/atuin/.local/log/pyls.log"))
  (lsp-define-stdio-client
   lsp-elixir "elixir"
   (lambda ()
     (let ((root (funcall #'projectile-project-root)))
       (cond ((eq root nil) (ex-lsp-root-init pwd))
	     (t (ex-lsp-root-init root)))))
   '("/home/atuin/.local/opt/elixir-ls/language_server.sh"))
  (add-hook 'python-mode-hook
  	    (lambda ()
  	      (lsp-python-enable)
	      (flycheck-mode)))
  (add-hook 'elixir-mode-hook
	    (lambda ()
	      (lsp-elixir-enable)
	      (flyckeck-mode))))

;; epl
(use-package epl
  :quelpa (epl :fetcher github :repo "cask/epl"))

;; pkg-info
(use-package pkg-info
  :quelpa (pkg-info :fetcher github :repo "lunaryorn/pkg-info.el")
  :after (epl))

;; telephone-line
(use-package telephone-line
  :quelpa (telephone-line :fetcher github :repo "dbordak/telephone-line")
  :config
  (telephone-line-mode 1))

;; projectile
(use-package projectile
  :after (pkg-info)
  :quelpa (projectile :fetcher github :repo "bbatsov/projectile"))

(use-package markdown-mode
  :quelpa (markdown-mode :fetcher github :repo "jrblevin/markdown-mode"))
;; :commands (markdown-mode gfm-mode)   
;; :mode (("README\\.md\\'" . gfm-mode)
;;        ("\\.md\\'" . markdown-mode)
;; ("\\.markdown\\'" . markdown-mode))
;; :init (setq markdown-command "multimarkdown"))

;; dash-functional
(use-package dash-functional
  :quelpa (dash-functional :fetcher github :repo "magnars/dash.el")
  :after (dash))

;; flycheck
(use-package flycheck
  :quelpa (flycheck :fetcher github :repo "flycheck/flycheck")
  :after (dash-functional))

;; lsp-ui
(use-package lsp-ui
  :quelpa (lsp-ui :fetcher github :repo "emacs-lsp/lsp-ui")
  ;; :after (flycheck)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;; s.el 
(use-package s
  :quelpa (s :fetcher github :repo "magnars/s.el"))

;; company-lsp - autocompletion for lsp
(use-package company-lsp
  :quelpa (company-lsp :fetcher github :repo "tigersoldier/company-lsp")
  :after (company-mode lsp-mode s yasnippet)
  :config
  (push 'company-lsp company-backends))

;; elixir-mode
(use-package elixir-mode
  :quelpa (elixir-mode :fetcher github :repo "elixir-editors/emacs-elixir")
  :after (pkg-info)
  :config
  (require 'elixir-mode)
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-mode)))

;; rebecca-theme
(use-package rebecca-theme
  :quelpa (rebecca-theme :fetcher github :repo "vic/rebecca-theme")
  :config
  (load-theme #'rebecca t))

(use-package goto-chg
  :quelpa (goto-chg :fetcher github :repo "emacs-evil/goto-chg"))

;; evil
(use-package evil
  :quelpa (evil :fetcher github :repo "emacs-evil/evil")
  :after (goto-chg)
  :config
  (evil-mode 1))
  ;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  ;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  ;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-top)
  ;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-bottom))

(use-package yasnippet
  :quelpa (yasnippet :fetcher github :repo "joaotavora/yasnippet")
  :config
  (yas-global-mode 1))

;; yasnippet-snippets
(use-package yasnippet-snippets
  :load-path "~/.emacs.d/packages/yasnippet-snippets"
  :config
  (yas-global-mode 1))

;; (use-package helm-core
;;   :quelpa (helm-core :fetcher github :repo "emacs-helm/helm"))

(use-package helm
  :quelpa (helm :fetcher github :repo "emacs-helm/helm")
  :config
  (setq default-frame-alist '((vertical-scroll-bars . nil)
                              (tool-bar-lines . 0)
                              (menu-bar-lines . 0)
                              (fullscreen . nil)))
  (blink-cursor-mode -1)
  (require 'helm-config)
  (helm-mode 1)
  (define-key global-map [remap find-file] 'helm-find-files)
  (define-key global-map [remap occur] 'helm-occur)
  (define-key global-map [remap list-buffers] 'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
  (define-key global-map [remap execute-extended-command] 'helm-M-x)
  (unless (boundp 'completion-in-region-function)
    (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
    (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point)))

(use-package faceup
  :quelpa (faceup :fetcher github :repo "Lindydancer/faceup"))

(use-package racket-mode
  :load-path "~/.emacs.d/packages/racket-mode"
  :after (faceup)
  :config
  (require 'racket-unicode-input-method)
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))
