;;; scala-utils.el --- Support for wrapping simple Scala expression in curly braces

;; Copyright (c) 2018 Josef Vlach

;; Homepage: https://github.com/VlachJosef/scala-utils
;; Package-Version:  0.1

;;; Commentary:
;;
;;  TODO
;;
;;; Code:

(require 'smartparens)
(require 'scala-mode)

(defun scala--utils:yield ()
  (let ((is-for-in-parenthesis)
        (go-back (point))
        (white-spaces))
    (save-excursion
      (move-beginning-of-line nil)
      (re-search-forward "\\([ \t]+\\)")
      (setq white-spaces (match-string 1)))
    (sp-backward-sexp)
    (sp-backward-up-sexp)
    (if (sp--looking-at "(for {")
        (progn
          (sp-forward-sexp)
          (backward-char)
          (newline)
          (insert white-spaces)
          (insert "}")
          (goto-char go-back)
          (forward-char 7)
          (insert "{")
          (newline)
          (insert white-spaces)
          (newline)
          (insert "  ")
          (insert white-spaces)
          (previous-line)
          (insert "  ")
          )
      (goto-char go-back)
      (forward-char 6)
      (insert " {")
      (newline-and-indent)
      (scala--utils:manually))))

(defun scala--utils:manually ()
  (re-search-backward ")\\|def \\|val \\| yield ")
  (forward-char)
  (sp-backward-sexp)
  (back-to-indentation)
  (setq column (current-column))
  (goto-char equal-point)
  (while (progn
           (forward-line)
           (move-to-column column)
           (looking-at "[[:space:]]")))
  (re-search-backward "[[:punct:]\\|[:word:]]")
  (forward-char)
  (newline-and-indent)
  (insert "}")
  (backward-char)
  (indent-according-to-mode)
  (goto-char equal-point)
  (forward-line)
  (move-beginning-of-line nil)
  (insert "\n")
  (previous-line)
  (indent-according-to-mode))

(defun scala--utils:wrap-in-braces ()
  (let ((equal-point)
        (column)
        (is-for-in-parenthesis))
    (re-search-backward "=$\\|⇒$\\| yield ")
    (setq equal-point (point))
    (pcase (match-string 0)
      (" yield " (scala--utils:yield))
      (_ (progn
           (forward-char)
           (insert " {")
           (scala--utils:manually))))))

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
