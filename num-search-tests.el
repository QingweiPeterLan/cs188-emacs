;;; Tests for 'num-search-forward'

(require 'calc-bin)

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
        (should-error (num-search-forward -57))))

; =================================================

(ert-deftest num-search-forward-test-2-1 ()
    (with-temp-buffer
        (insert "Hello+00057 world!575")
        (beginning-of-buffer)
        (should-error (num-search-forward -57))))

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
        (should-error (num-search-forward 57))))

(ert-deftest num-search-forward-test-2-7 ()
    (with-temp-buffer
        (insert "Hello000057 world!575")
        (beginning-of-buffer)
        (goto-char 11)
        (should-error (num-search-forward 57))))

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
        (should-error (num-search-forward 575))))

(ert-deftest num-search-forward-test-3-2 ()
    (with-temp-buffer
        (insert "Hello000057 world!575\n")
        (beginning-of-buffer)
        (goto-char 10)
        (num-search-forward 575)
        (should (= (point) 22))))

; =================================================

(ert-deftest num-search-forward-test-base-1-1 ()
    (with-temp-buffer
        (insert "HelloFFF world!FFl.")
        (beginning-of-buffer)
        (num-search-forward 255 nil 16)
        (should (= (point) 18))))

(ert-deftest num-search-forward-test-base-1-2 ()
    (with-temp-buffer
        (insert "FFHelloFFF world!FFl.")
        (beginning-of-buffer)
        (num-search-forward 255 nil 16)
        (should (= (point) 3))))

(ert-deftest num-search-forward-test-base-1-3 ()
    (with-temp-buffer
        (insert "FFFHelloFFF world!FFl.")
        (beginning-of-buffer)
        (num-search-forward 255 nil 16)
        (should (= (point) 21))))

(ert-deftest num-search-forward-test-base-1-4 ()
    (with-temp-buffer
        (insert "FFHelloFFF world!FFl.")
        (beginning-of-buffer)
        (goto-char 2)
        (num-search-forward 255 nil 16)
        (should (= (point) 20))))

; =================================================

(ert-deftest num-search-forward-test-multi-line-1 ()
    (with-temp-buffer
        (insert "FFFHelloFF\nFFworldFFl.")
        (beginning-of-buffer)
        (num-search-forward 255 nil 16)
        (should (= (point) 11))))

(ert-deftest num-search-forward-test-multi-line-2 ()
    (with-temp-buffer
        (insert "FFFHelloFFF\nFFworldFFl.")
        (beginning-of-buffer)
        (num-search-forward 255 nil 16)
        (should (= (point) 15))))
