;;; company-jedi-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (company-jedi--setup company-jedi) "company-jedi"
;;;;;;  "company-jedi.el" (21854 49531 758965 528000))
;;; Generated autoloads from company-jedi.el

(autoload 'company-jedi "company-jedi" "\
`company-mode' completion back-end for Python JEDI.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(autoload 'company-jedi--setup "company-jedi" "\


\(fn)" nil nil)

(setq jedi:setup-function #'company-jedi--setup)

;;;***

;;;### (autoloads nil nil ("company-jedi-pkg.el") (21854 49531 844305
;;;;;;  420000))

;;;***

(provide 'company-jedi-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; company-jedi-autoloads.el ends here
