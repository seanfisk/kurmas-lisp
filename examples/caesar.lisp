#!/usr/bin/env clisp

;; Implementation of a Caesar cipher in Common Lisp.

(defun caesar (text key)
  "Encode TEXT with a Caesar cipher using offset KEY."
  (map 'string
       #'(lambda (char)
           ;; Ignore non-alpha characters.
           (if (alpha-char-p char)
               ;; Set the offset based on `A' or `a', depending on the
               ;; case of CHAR.
               (let ((offset
                      (if (upper-case-p char)
                          (char-code #\A)
                        (char-code #\a))))
                 ;; Perform the cipher.
                 (code-char
                  (+ (mod (+ (- (char-code char) offset) key)
                          26) offset)))
             char))
       text))

(format t "Original text: ~A~%" (car *ARGS*))
(format t " Encoded text: ~A~%" (caesar (car *ARGS*) 3))
