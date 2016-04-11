;;; Funcion definition for 'num-search-forward'

(defun num-search-forward (NUM1 &optional NUM2 BASE)
  "Search for NUM1, or range [NUM1, NUM2], in base BASE (default 10)"
  (if BASE
    ; if BASE is defined
    (if NUM2
      ; if NUM2 is defined
      nil
      ; if NUM2 is not defined
      nil
      )
    ; if BASE is not defined
    (if NUM2
      ; if NUM2 is defined
      nil
      ; if NUM2 is not defined
      (if (re-search-forward (generate-regex-for-num NUM1) nil t)
        (if (re-search-backward (last-digit-for-num NUM1) nil t)
          (forward-char))))))

; used for generating regex for number
; ex.  567
;     +567  ==>  [^0-9]*+?0*567[^0-9]*
;
; ex. -567  ==>  [^0-9]*-0*567[^0-9]*
(defun generate-regex-for-num (NUMBER)
  "Generates regex for specified NUMBER"
  (let ((calc-number-radix 10))
    (if (string= (substring (number-to-string NUMBER) 0 1) "+")
    ; number starts with "+"
    (concat "[^0-9]*+?0*" (substring (number-to-string NUMBER) 1) "[^0-9]+")
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat "[^0-9]*-0*" (substring (number-to-string NUMBER) 1) "[^0-9]+")
      ; number doesn't start with "-"
      (concat "[^0-9]*+?0*" (number-to-string NUMBER) "[^0-9]+")))))

; simple helper function that extracts last digit of number
(defun last-digit-for-num (NUMBER)
  "Find last digit of NUMBER"
  (substring (number-to-string NUMBER) -1))


; used for generating regex for number in number base BASE
(defun generate-regex-for-num-with-base (NUMBER BASE)
  "Generates regex for specified NUMBER in number base BASE"
  (let ((calc-number-radix BASE))
    (if (string= (substring (number-to-string NUMBER) 0 1) "+")
    ; number starts with "+"
    (concat "[^0-9]*+?0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) "[^0-9]+")
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat "[^0-9]*-0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) "[^0-9]+")
      ; number doesn't start with "-"
      (concat "[^0-9]*+?0*" (math-format-radix (string-to-number (number-to-string NUMBER))) "[^0-9]+")))))
