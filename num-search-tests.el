;;; Tests for 'num-search-forward'

; common tests
(ert-deftest addition-test1 ()
    (should-not (= (+ 1 2) 4)))
(ert-deftest addition-test2 ()
    (should (= (+ 1 2) 3)))
(ert-deftest division-test1 ()
    (should-error (/ 1 0)))

; testing point
(ert-deftest point-test1 ()
    (should (= (point) 1)))

; test point after insertion
(ert-deftest buffer-test1 ()
    (with-temp-buffer
        (insert "Hello world!575")
        (should (= (point) 16))))

; first test for num-search-forward
(ert-deftest buffer-test2 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward 57)
        (should (= (point) 8))))
