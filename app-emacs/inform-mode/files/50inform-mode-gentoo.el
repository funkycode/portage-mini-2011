
;;; inform-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'inform-mode "inform-mode" "Inform editing mode." t)
(autoload 'inform-maybe-mode "inform-mode" "Inform/C header editing mode.")
(add-to-list 'auto-mode-alist '("\\.h\\'"   . inform-maybe-mode))
(add-to-list 'auto-mode-alist '("\\.inf\\'" . inform-mode))
