;;; Funcion definition for 'num-search-forward'

(defun num-search-forward (NUM1 &optional NUM2 BASE)
  "Search for NUM1, or range [NUM1, NUM2], in base BASE (default 10)"
  (search-forward (number-to-string NUM1))
  )

(defun multiply-by-seven (number)
	"Multiply NUMBER by seven."
	(interactive "nEnter the number to multiply by seven: ")
	(message "The result is: %d" (* 7 number)))
