; function definitions for 'num-search-forward' & helper functions

; funcion definition for 'num-search-forward'
(defun num-search-forward (NUM1 &optional NUM2 BASE)
  "Search for NUM1, or range [NUM1, NUM2], in base BASE (default 10)"
  (if BASE
    ; if BASE is defined
    (if NUM2
      ; if NUM2 is defined
      nil
      ; if NUM2 is not defined
      (if (re-search-forward (generate-start-regex-for-num-with-base NUM1 BASE) (line-end-position) t)
        (backward-char)
        (if (re-search-forward (generate-regex-for-num-with-base NUM1 BASE) nil t)
          (backward-char))))
    ; if BASE is not defined
    (if NUM2
      ; if NUM2 is defined
      nil
      ; if NUM2 is not defined
      (if (re-search-forward (generate-start-regex-for-num NUM1) (line-end-position) t)
        (backward-char)
        (if (re-search-forward (generate-regex-for-num NUM1) nil t)
          (backward-char))))))


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
    (concat "[^0-9]*+?0*" (substring (number-to-string NUMBER) 1) "[^0-9]")
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat "[^0-9]*-0*" (substring (number-to-string NUMBER) 1) "[^0-9]")
      ; number doesn't start with "-"
      (concat "[^0-9]*+?0*" (number-to-string NUMBER) "[^0-9]")))))

(defun generate-start-regex-for-num (NUMBER)
  "Generates regex for specified NUMBER"
  (let ((calc-number-radix 10))
    (if (string= (substring (number-to-string NUMBER) 0 1) "+")
    ; number starts with "+"
    (concat "^+?0*" (substring (number-to-string NUMBER) 1) "[^0-9]")
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat "^-0*" (substring (number-to-string NUMBER) 1) "[^0-9]")
      ; number doesn't start with "-"
      (concat "^+?0*" (number-to-string NUMBER) "[^0-9]")))))

; used for generating regex for number in number base BASE
(defun generate-regex-for-num-with-base (NUMBER BASE)
  "Generates regex for specified NUMBER in number base BASE"
  (let ((calc-number-radix BASE))
    (if (string= (substring (number-to-string NUMBER) 0 1) "+")
    ; number starts with "+"
    (concat (inverse-character-set-for-base BASE) "++?0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) (inverse-character-set-for-base BASE))
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat (inverse-character-set-for-base BASE) "+-0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) (inverse-character-set-for-base BASE))
      ; number doesn't start with "-"
      (concat (inverse-character-set-for-base BASE) "++?0*" (math-format-radix (string-to-number (number-to-string NUMBER))) (inverse-character-set-for-base BASE))))))

(defun generate-start-regex-for-num-with-base (NUMBER BASE)
  "Generates regex for specified NUMBER in number base BASE"
  (let ((calc-number-radix BASE))
    (if (string= (substring (number-to-string NUMBER) 0 1) "+")
    ; number starts with "+"
    (concat "^+?0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) (inverse-character-set-for-base BASE))
    ; number doesn't start with "+"
    (if (string= (substring (number-to-string NUMBER) 0 1) "-")
      ; number starts with "-"
      (concat "^-0*" (math-format-radix (string-to-number (substring (number-to-string NUMBER) 1))) (inverse-character-set-for-base BASE))
      ; number doesn't start with "-"
      (concat "^+?0*" (math-format-radix (string-to-number (number-to-string NUMBER))) (inverse-character-set-for-base BASE))))))


; returns the inversed character set for a number base in regex format
; e.g. for base 16: "[^0-9A-Fa-f]"
(defun inverse-character-set-for-base (BASE)
  "Generates the character set for number base BASE in regex format"
  (pcase BASE
    (`2 "[^0-1]")
    (`3 "[^0-2]")
    (`4 "[^0-3]")
    (`5 "[^0-4]")
    (`6 "[^0-5]")
    (`7 "[^0-6]")
    (`8 "[^0-7]")
    (`9 "[^0-8]")
    (`10 "[^0-9]")
    (`11 "[^0-9Aa]")
    (`12 "[^0-9A-Ba-b]")
    (`13 "[^0-9A-Ca-c]")
    (`14 "[^0-9A-Da-d]")
    (`15 "[^0-9A-Ea-e]")
    (`16 "[^0-9A-Fa-f]")))
