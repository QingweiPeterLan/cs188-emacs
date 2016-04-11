;;; Tests for 'num-search-forward'

(require 'calc-bin)

; =================================================

; regex generation tests
(ert-deftest regex-gen-test1 ()
    (should (string= (generate-regex-for-num 55) "[^0-9]*+?0*55[^0-9]+")))
(ert-deftest regex-gen-test2 ()
    (should (string= (generate-regex-for-num -55) "[^0-9]*-0*55[^0-9]+")))
(ert-deftest regex-gen-test3 ()
    (should (string= (generate-regex-for-num +55) "[^0-9]*+?0*55[^0-9]+")))
(ert-deftest regex-gen-test4 ()
    (should (string= (generate-regex-for-num -055) "[^0-9]*-0*55[^0-9]+")))
(ert-deftest regex-gen-test5 ()
    (should (string= (generate-regex-for-num +055) "[^0-9]*+?0*55[^0-9]+")))
(ert-deftest regex-gen-test6 ()
    (should (string= (generate-regex-for-num 57) "[^0-9]*+?0*57[^0-9]+")))

(ert-deftest regex-gen-test-base1 ()
    (should (string= (generate-regex-for-num-with-base 255 16) "[^0-9]*+?0*FF[^0-9]+")))

; =================================================

; tests for num-search-forward
(ert-deftest num-search-forward-test-1-1 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward 57)
        (should (= (point) 8))))

(ert-deftest num-search-forward-test-1-2 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward +57)
        (should (= (point) 8))))

(ert-deftest num-search-forward-test-1-3 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward +000057)
        (should (= (point) 8))))

(ert-deftest num-search-forward-test-1-4 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward 000000057)
        (should (= (point) 8))))

(ert-deftest num-search-forward-test-1-5 ()
    (with-temp-buffer
        (insert "Hello57 world!575")
        (beginning-of-buffer)
        (num-search-forward -57)
        (should (= (point) 1))))

; =================================================

(ert-deftest num-search-forward-test-2-1 ()
    (with-temp-buffer
        (insert "Hello+00057 world!575")
        (beginning-of-buffer)
        (num-search-forward -57)
        (should (= (point) 1))))

(ert-deftest num-search-forward-test-2-2 ()
    (with-temp-buffer
        (insert "Hello+00057 world!575")
        (beginning-of-buffer)
        (num-search-forward 57)
        (should (= (point) 12))))

(ert-deftest num-search-forward-test-2-3 ()
    (with-temp-buffer
        (insert "Hello-000000057 world!575")
        (beginning-of-buffer)
        (num-search-forward -57)
        (should (= (point) 16))))

(ert-deftest num-search-forward-test-2-4 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (num-search-forward 57)
        (should (= (point) 12))))

(ert-deftest num-search-forward-test-2-5 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 7)
        (num-search-forward 57)
        (should (= (point) 12))))

(ert-deftest num-search-forward-test-2-6 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 15)
        (num-search-forward 57)
        (should (= (point) 15))))

(ert-deftest num-search-forward-test-2-7 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 11)
        (num-search-forward 57)
        (should (= (point) 11))))

(ert-deftest num-search-forward-test-2-8 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 10)
        (num-search-forward 57)
        (should (= (point) 12))))

; =================================================

(ert-deftest num-search-forward-test-3-1 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 10)
        (num-search-forward 575)
        (should (= (point) 10))))

(ert-deftest num-search-forward-test-3-2 ()
    (with-temp-buffer
        (insert "Hello000057 world!575\n")
        (beginning-of-buffer)
        (goto-char 10)
        (num-search-forward 575)
        (should (= (point) 22))))
