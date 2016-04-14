;;; Tests for 'num-search-forward'

(require 'calc-bin)


; -------------------------------------------------------------------
; not implemented parts: range search & range search with BASE

(ert-deftest range-search-fail ()
    "Range search is not implemented."
    :expected-result :failed
    (with-temp-buffer
        (insert "Hello 55 World!")
        (beginning-of-buffer)
        (should (= (num-search-forward 10 100) 9))))

(ert-deftest range-search-base-fail ()
    "Range search with BASE is not implemented."
    :expected-result :failed
    (with-temp-buffer
        (insert "Hello FF World!")
        (beginning-of-buffer)
        (should (= (num-search-forward 200 300 16) 9))))


; -------------------------------------------------------------------
; tests that should report errors

(ert-deftest num-search-forward-test-range-fail ()
    (with-temp-buffer
        (insert "NOTHING HERE")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should-error (num-search-forward 100 10))))

(ert-deftest num-search-forward-test-base-fail-1 ()
    (with-temp-buffer
        (insert "NOTHING HERE")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should-error (num-search-forward 100 nil 1))))

(ert-deftest num-search-forward-test-base-fail-2 ()
    (with-temp-buffer
        (insert "NOTHING HERE")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should-error (num-search-forward 100 nil 17))))


; -------------------------------------------------------------------
; normal tests

(ert-deftest num-search-forward-test-empty ()
    (with-temp-buffer
        (insert "")
        (beginning-of-buffer)
        (should-error (num-search-forward 57)) ; should error for empty
    ))

(ert-deftest num-search-forward-test-normal ()
    (with-temp-buffer
        (insert "57H579E\n457L-57L\n+57E W0057E+0057R-0057R")
        (should-error (num-search-forward 57)) ; search fails
        (beginning-of-buffer)
        (should (= (point) 1)) ; sanity check
        (should (= (num-search-forward +0057) 3)) ; check search start of line
        (should (= (num-search-forward 57) 21)); skip leading and trailing (579 & 457)
        (should (= (num-search-forward 57) 28)) ; with plus sign
        (should (= (num-search-forward 57) 34)); with leading zeros
        (beginning-of-buffer)
        (should (= (point) 1)) ; sanity check
        (should (= (num-search-forward -00000057) 16)) ; negative number search
        (should (= (num-search-forward -57) 40)) ; negative number with leading zeroes
    ))

(ert-deftest num-search-forward-test-base-1 ()
    (with-temp-buffer
        (insert "FFHFFF!FFl\n+FF.+000FF.-FF.-000FF.")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should (= (num-search-forward 255 nil 16) 3)) ; check search start of line
        (should (= (num-search-forward 255 nil 16) 10)) ; skip leading and trailing (FFF)
        (should (= (num-search-forward 255 nil 16) 15)) ; check leading plus
        (should (= (num-search-forward 255 nil 16) 22)) ; check leading zeros
        (should (= (num-search-forward -255 nil 16) 26)) ; negative number search
        (should (= (num-search-forward -255 nil 16) 33)) ; negative number with leading zeros
    ))

; same test as above with case insensitive search
(ert-deftest num-search-forward-test-base-2 ()
    (with-temp-buffer
        (insert "ffHfff!ffl\n+ff.+000ff.-ff.-000ff.")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should (= (num-search-forward 255 nil 16) 3)) ; check search start of line
        (should (= (num-search-forward 255 nil 16) 10)) ; skip leading and trailing (FFF)
        (should (= (num-search-forward 255 nil 16) 15)) ; check leading plus
        (should (= (num-search-forward 255 nil 16) 22)) ; check leading zeros
        (should (= (num-search-forward -255 nil 16) 26)) ; negative number search
        (should (= (num-search-forward -255 nil 16) 33)) ; negative number with leading zeros
    ))

; same test as above with case insensitive search (mixture)
(ert-deftest num-search-forward-test-base-3 ()
    (with-temp-buffer
        (insert "fFHfff!ffl\n+Ff.+000Ff.-fF.-000Ff.")
        (beginning-of-buffer)
        (should (= (point) 1))
        (should (= (num-search-forward 255 nil 16) 3)) ; check search start of line
        (should (= (num-search-forward 255 nil 16) 10)) ; skip leading and trailing (FFF)
        (should (= (num-search-forward 255 nil 16) 15)) ; check leading plus
        (should (= (num-search-forward 255 nil 16) 22)) ; check leading zeros
        (should (= (num-search-forward -255 nil 16) 26)) ; negative number search
        (should (= (num-search-forward -255 nil 16) 33)) ; negative number with leading zeros
    ))
