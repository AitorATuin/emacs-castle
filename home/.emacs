;; Initialize
;; Disable elpa
(setq package-archives nil)
(package-initialize)

;; use-package
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/packages/use-package")
  (require 'use-package))

;; Bootstrap quelpa
; (package-initialize)
;; (if (require 'quelpa nil t)
;;     (quelpa-self-upgrade)
;;   (with-temp-buffer
;;     (insert-file-contents "~/.emacs.d/packages/quelpa/bootstrap.el")
;;     (eval-buffer)))

;; quelpa
;; Load quelpa using use-package
;; quelpa repository is cloned manually
(use-package quelpa
  :load-path "~/.emacs.d/packages/quelpa"
  :init
  (setq quelpa-update-melpa-p nil)
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
