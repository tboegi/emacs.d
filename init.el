;; Default, cloumn and line number, no TAB
(custom-set-variables
 '(column-number-mode t)
 '(line-number-mode t)
 '(setq tab-width 2)
 '(indent-tabs-mode nil)
 '(default-style "gnu")
)

;; Hack for Mac
(when (eq system-type 'darwin) ;; mac specific settings
;;  ;;(setq mac-option-modifier 'alt)
;;  ;;(setq mac-command-modifier 'meta)
  (global-set-key [delete] 'delete-char) ;; sets fn-delete to be right-delete
)

;; Backspace is backspace and not help on BSD
(when (eq system-type 'berkeley-unix)
  (global-set-key [?\C-h] 'delete-backward-char)
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
            (setq show-trailing-whitespace t)
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
                         (string-match-p (expand-file-name "/epics/modules/asyn")
                                       filename))
                (setq indent-tabs-mode nil)
                (setq tab-width 4)
                (setq c-basic-offset 4)
                (setq show-trailing-whitespace t)
                )
              )
	    )
	  )

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
(put 'upcase-region 'disabled nil)
