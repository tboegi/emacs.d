;; Default, cloumn and line number, no TAB
(custom-set-variables
 '(column-number-mode t)
 '(line-number-mode t)
 '(setq tab-width 2)
 '(indent-tabs-mode nil)
)

;; Hack for Mac
(when (eq system-type 'darwin) ;; mac specific settings
;;  ;;(setq mac-option-modifier 'alt)
;;  ;;(setq mac-command-modifier 'meta)
  (global-set-key [delete] 'delete-char) ;; sets fn-delete to be right-delete
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
