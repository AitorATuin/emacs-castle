;;; init.el --- user-init-file                    -*- lexical-binding: t -*-
;;; Startup
;; Disable mouse early
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; Don't use package.el at all, we manage packages
(setq package-archives nil)
(setq package-enable-at-startup nil)
;; (package-initialize)
			 
;;; Load the org config now!
(require 'org)
(org-babel-load-file
 (expand-file-name "atuin.org"
                   user-emacs-directory))
