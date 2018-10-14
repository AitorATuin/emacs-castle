;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages
   (quote
    (evil goto-chg yasnippet-snippets yasnippet lsp-ui lsp-mode chess helm-ebdb org-edna)))
 '(tls-checktrust t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono derivative Powerline" :foundry "DAMA" :slant normal :weight normal :height 98 :width normal)))))

;; Some default custom configuration
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(transient-mark-mode 1):
(setq inhibit-splash-screen t)

;; Uncomment this to debug use-package loading packages
;; (setq use-package-verbose 'debug)

;; Uncomment this to use edebug
;; (setq debug-on-error t)
;; (setq debug-on-quit t)

;; use-package
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/packages/use-package")
  (require 'use-package))

;; quelpa
;; Load quelpa using use-package
;; quelmap repository is cloned manually
(use-package quelpa
  :load-path "~/.emacs.d/packages/quelpa"
  :config
  (setq quelpa-checkout-melpa-p nil)) ; don't use melpa!

;; quelpa-use-package
;; Load now quelpa-use-package using quelpa
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
(require 'quelpa-use-package)
(setq use-package-ensure-function 'quelpa)

;; Load my own use-package definitions
(load-file "~/.emacs.d/packages.el")
