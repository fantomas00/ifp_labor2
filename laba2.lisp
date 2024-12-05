(defun contains-not (x lst)
    (if (null lst)
        t
        (if (eq x (car lst))
            nil
            (contains-not x (cdr lst)))))

(defun list-set-difference (s1 s2 s3)
    (let ((el (car s1)))
        (when el
            (if (and (contains-not el s2) (contains-not el s3))
                (cons el (list-set-difference (cdr s1) s2 s3))
                (list-set-difference (cdr s1) s2 s3)))))

(defun remove-thirds-and-reverse (lst &optional (i 1))
    (let ((should-drop (eq (mod i 3) 0)))
        (cond
            ((null lst) nil)
            ((null (cdr lst)) (when (not should-drop) lst))
            (t (if should-drop
                (remove-thirds-and-reverse (cdr lst) (1+ i))
                (append
                    (remove-thirds-and-reverse (cdr lst) (1+ i))
                    (cons (car lst) nil)))))))

(defun check-list-set-difference (name s1 s2 s3 &key expected)
    (format t "~:[FAILED~;passed~]... ~a~%"
            (equal (list-set-difference s1 s2 s3) expected)
            name))

(defun check-remove-thirds-and-reverse (name lst &key expected)
    (format t "~:[FAILED~;passed~]... ~a~%"
            (equal (remove-thirds-and-reverse lst) expected)
            name))

(defun test-list-set-difference ()
    (check-list-set-difference "Regular input" '(1 2 3 4) '(4 5 6) '(2 5 7) :expected '(1 3))
    (check-list-set-difference "All empty" '() '() '() :expected '())
    (check-list-set-difference "Empty subtrahends" '(5 6 7 8) '() '() :expected '(5 6 7 8))
    (check-list-set-difference "All unique" '(9 0 4 5) '(1 2) '(3) :expected '(9 0 4 5))
    (check-list-set-difference "Full subtraction" '(1 2 3 4) '(1 2) '(3 4) :expected '()))

(defun test-remove-thirds-and-reverse ()
    (check-remove-thirds-and-reverse "list from instr" '(a b c d e f g) :expected '(G E D B A))
    (check-remove-thirds-and-reverse "List without threes" '(1 2) :expected '(2 1))
    (check-remove-thirds-and-reverse "List with last element removed" '(1 2 3 4 5 6) :expected '(5 4 2 1))
    (check-remove-thirds-and-reverse "List with last element not removed" '(1 2 3 4 5 6 7) :expected '(7 5 4 2 1)))

(test-list-set-difference)
(test-remove-thirds-and-reverse)
