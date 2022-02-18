;; Default, cloumn and line number, no TAB
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(line-number-mode t)
 '(setq tab-width t)
 '(show-trailing-whitespace t))

;; Hack for Mac
(when (eq system-type 'darwin) ;; mac specific settings
;;  ;;(setq mac-option-modifier 'alt)
;;  ;;(setq mac-command-modifier 'meta)
  (setq ns-right-alternate-modifier 'none)
  (global-set-key [delete] 'delete-char) ;; sets fn-delete to be right-delete
  ;; https://stackoverflow.com/questions/3376863/unable-to-type-braces-and-square-braces-in-emacs

  ;; https://superuser.com/questions/710358/emacs-key-for-home-end
  (global-set-key [home] 'beginning-of-line)
  (global-set-key [end] 'end-of-line)

  (custom-set-faces
   '(default ((t (:height 135 :family "Menlo"))))
   )
;;(set-frame-font "Inconsolata 14" nil t)
;;(set-default-font "Inconsolata 14" nil t)

  (setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)
  )

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only)
			)
	       )
	     )
	    )
	  )

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
                (c-set-style "linux-tabs-only")
		)
              (when (and filename
                         (string-match-p (expand-file-name "/epics/modules/asyn")
                                       filename))
                (setq indent-tabs-mode nil)
                (setq tab-width 4)
                (setq c-basic-offset 4)
                (setq show-trailing-whitespace t)
                )
              (when (and filename
                         (string-match "devMotorAsyn.c"
                                       filename))
                (setq indent-tabs-mode nil)
                (setq tab-width 4)
                (setq c-basic-offset 4)
                (setq show-trailing-whitespace t)
                )
              (when (and filename
                         (string-match-p (expand-file-name "/epics/base/")
                                       filename))
                (setq indent-tabs-mode nil)
                (setq tab-width 4)
                (setq c-basic-offset 4)
                (setq show-trailing-whitespace t)
                )
              )
	    )
	  )

(add-hook 'java-mode-hook (lambda ()
    (setq tab-width 4)
    (setq indent-tabs-mode nil)))
(add-hook 'c++-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Tweaks for motorRecord.cc
              (when (and filename
                         (string-match "motorRecord.cc"
                                       filename))
                (setq indent-tabs-mode nil)
                (setq tab-width 4)
                (setq c-basic-offset 4)
                (setq show-trailing-whitespace t)
                )
              )
            )
          )

(add-hook 'java-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            )
          )
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
	     (let ((filename (buffer-file-name)))
	       ;; Enable kernel mode for the appropriate files
	       (when (and filename
			  (string-match (expand-file-name "/projects/git")
					filename))
		 (setq indent-tabs-mode t)
		 (setq tab-width 8)
		 (setq show-trailing-whitespace t)
		 (c-set-style "linux-tabs-only")
		 )
	       )
	     )
	  )
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
