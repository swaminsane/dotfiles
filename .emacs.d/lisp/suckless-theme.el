;;; suckless-theme.el --- sync with colors.h

(defun suckless--read-colors ()
  (let ((file (expand-file-name "~/.config/theme/colors.h"))
        (colors (make-hash-table :test 'equal)))

    (when (file-exists-p file)
      (with-temp-buffer
        (insert-file-contents file)
        (while (re-search-forward
                "#define[ \t]+\\(COL_[A-Z_]+\\)[ \t]+\"\\(#?[a-fA-F0-9]+\\)\""
                nil t)
          (puthash (match-string 1) (match-string 2) colors))))
    colors))

(defun suckless-apply-theme ()
  (interactive)
  (let* ((c (suckless--read-colors))
         (bg (gethash "COL_BG" c "#000000"))
         (fg (gethash "COL_FG" c "#ffffff"))
         (accent (gethash "COL_ACCENT" c "#888888"))
         (border (gethash "COL_BORDER" c "#444444"))
         (red (gethash "COL_RED" c))
         (green (gethash "COL_GREEN" c))
         (yellow (gethash "COL_YELLOW" c))
         (blue (gethash "COL_BLUE" c)))

    (custom-set-faces
     `(default ((t (:background ,bg :foreground ,fg))))
     `(cursor ((t (:background ,accent))))
     `(mode-line ((t (:background ,accent :foreground ,bg :box nil))))
     `(mode-line-inactive ((t (:background ,border :foreground ,fg :box nil))))
     `(region ((t (:background ,border))))
     `(minibuffer-prompt ((t (:foreground ,accent :weight bold))))
     `(font-lock-keyword-face ((t (:foreground ,red))))
     `(font-lock-function-name-face ((t (:foreground ,blue))))
     `(font-lock-string-face ((t (:foreground ,green))))
     `(font-lock-constant-face ((t (:foreground ,yellow))))
     `(vertical-border ((t (:foreground ,border))))
     `(hl-line ((t (:background ,border)))))))

(provide 'suckless-theme)
