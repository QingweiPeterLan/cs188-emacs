
; (defun num-search-forward (NUM1 &optional NUM2 BASE)
;   "Search forward for NUM1, or range [NUM, NUM2], in base BASE (default 10)"
;   )

(defun multiply-by-seven (number)
	"Multiply NUMBER by seven."
	(interactive "nEnter the number to multiply by seven: ")
	(message "The result is: %d" (* 7 number)))
