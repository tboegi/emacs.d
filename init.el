;; Switch coloring off
(global-font-lock-mode 0)

(custom-set-variables
 '(column-number-mode t)
 '(line-number-mode t))


(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match-p (expand-file-name "/projects/git")
                                       filename))
                (setq indent-tabs-mode t)
                (setq tab-width 8)
                (setq show-trailing-whitespace t)
                (c-set-style "linux-tabs-only")))))

(add-hook 'sh-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode t)
             (setq sh-indentation 2)
             (setq sh-basic-offset 2)
             (setq sh-indent-for-then 0)
             (setq sh-indent-for-case-label 0)
             (setq sh-indent-for-case-alt '+)
             (sh-handle-prev-case-alt-end 0)
             (c-set-style "linux-tabs-only")
             (setq fill-column 70)
             ))


(put 'narrow-to-region 'disabled nil)
