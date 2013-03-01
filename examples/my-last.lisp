#!/usr/bin/env clisp

(defun my-last (list)
  "Return the last cons cell of LIST. Should behave similar to
`last'."
  (if (cdr list)
      (my-last (cdr list))
    list))

(print (my-last '(a b c d)))
