(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(font-lock-mode t t (font-lock))
 '(indent-tabs-mode nil)
 '(line-number-mode t)
 '(paren-mode (quote sexp) nil (paren))
 '(query-user-mail-address nil)
 '(send-mail-function nil)
 '(tab-width 2)
 '(user-mail-address "tboegi@web.de"))


(when (eq system-type 'darwin) ;; mac specific settings
;;  ;;(setq mac-option-modifier 'alt)
;;  ;;(setq mac-command-modifier 'meta)
  (global-set-key [delete] 'delete-char) ;; sets fn-delete to be right-delete
)

;;;****************************************
;;;* Set the appropriate variables to fit *
;;;* the C-Guidelines of XXXXXXXX         *
;;;****************************************
(require 'cc-mode)
(require 'cc-styles)

(defun c-lineup-arglist-1 (langelem)
  (1- (c-lineup-arglist langelem)))


;;; Since searching stops when the first match is found, we prepend
;;; the new list. This gives a chance to change it at any time.
(setq c-style-alist
      (append '(("fri"
                 (c-basic-offset . 2)
                 (c-comment-only-line-offset . 0)
                 (c-offsets-alist
                  .
                  ((inline-open        . 0)
                   (topmost-intro      . 0) ; ???
                   (statement          . 0) ; c-lineup-runin-statements)
                   (statement-cont     . +) ; c-lineup-math)
                   (case-label         . +)
                   (substatement-open  . 0)
                   (block-open         . 0)
                   (arglist-close      . c-lineup-arglist-1)
                   ))))
              c-style-alist))

(add-hook 'awk-mode-hook
          '(lambda ()
             (setq fill-column 70)
             (setq tab-width 2)
             (setq c-block-comments-indent-p 4)
             (c-set-style "fri")))

(add-hook 'c-mode-hook
          '(lambda ()
             (setq fill-column 70)
             (setq c-block-comments-indent-p 4)
             (c-set-style "fri")
             (setq tab-width 2)
             (setq indent-tabs-mode t)
					 ))

(add-hook 'c++-mode-hook
          '(lambda ()
             (setq fill-column 70)
             (setq tab-width 2)
             (setq c-block-comments-indent-p 4)
             (c-set-style "fri")))

(add-hook 'html-mode-hook
          '(lambda ()
             (setq fill-column 99999)))

(add-hook 'java-mode-hook
          '(lambda ()
             (setq fill-column 70)
             (setq tab-width 8)
             (setq c-block-comments-indent-p 4)
             (c-set-style "fri")))


(add-hook 'perl-mode-hook
          '(lambda ()
             (setq fill-column 70)
             (setq tab-width 2)
             (setq indent-tabs-mode t)
             (setq c-block-comments-indent-p 2)
             ))

(add-hook 'sh-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode t)
             (setq sh-indentation 2)
             (setq sh-basic-offset 2)
             (setq sh-indent-for-then 2)
             (setq sh-indent-for-case-alt '+)
             (sh-handle-prev-case-alt-end '+)
             (setq sh-indent-for-case-label '+)
             (c-set-style "fri")
             (setq fill-column 70)
             ))


(add-hook 'tcl-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode t)
             (setq sh-indentation 2)
             (setq sh-basic-offset 2)
             (c-set-style "fri")
             (setq fill-column 70)
             ))







(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
########################################################
# https://www.kernel.org/doc/Documentation/CodingStyle #
########################################################



(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

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
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (setq show-trailing-whitespace t)
                (c-set-style "linux-tabs-only")))))

#This will make emacs go better with the kernel coding style for C
#files below ~/src/linux-trees.

