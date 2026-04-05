(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; UI cleanup
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq ring-bell-function
      (lambda ()
        (invert-face 'mode-line)
        (run-with-timer 0.1 nil #'invert-face 'mode-line)))

;; Load custom lisp
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'suckless-theme)

;; Apply theme
(suckless-apply-theme)

;; Enable emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))

;; Fonts
(set-face-attribute 'default nil
                    :family "xos4 Terminus"
                    :height 157
                    :weight 'bold)

(add-to-list 'default-frame-alist
            '(font . "xos4 Terminus-14:weight=bold"))
