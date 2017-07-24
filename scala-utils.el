;;; scala-utils.el --- Support for wrapping simple Scala expression in curly braces

;; Copyright (c) 2017 Josef Vlach

;; Homepage: https://github.com/VlachJosef/scala-utils
;; Package-Version:  0.1

;;; Commentary:
;;
;;  TODO
;;
;;; Code:

(require 'smartparens)
(require 'scala-mode)

(defun scala--utils:wrap-in-braces ()
  (let ((equal-point)
        (column))
    (re-search-backward "=$\\|⇒$")
    (setq equal-point (point))
    (forward-char)
    (insert " {")
    (re-search-backward ")\\|def \\|val ")
    (forward-char)
    (sp-backward-sexp)
    (back-to-indentation)
    (setq column (current-column))
    (goto-char equal-point)
    (while (progn
             (next-line)
             (move-to-column column)
             (looking-at "[[:space:]]")))
    (re-search-backward "[[:punct:]\\|[:word:]]")
    (forward-char)
    (newline-and-indent)
    (insert "}")
    (backward-char)
    (indent-according-to-mode)
    (goto-char equal-point)
    (next-line)
    (move-beginning-of-line nil)
    (insert "\n")
    (previous-line)
    (indent-according-to-mode)
    ))

(defun scala-utils:wrap-in-braces ()
  (interactive)

  (when (string-match " = " (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
      (progn
        (back-to-indentation)
        (re-search-forward " = " (line-end-position))
        (newline-and-indent)))
  (scala--utils:wrap-in-braces))

(provide 'scala-utils)
;;; scala-utils.el ends here
