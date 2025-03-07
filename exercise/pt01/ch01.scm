;;; Exercise 1.1 
;; => Skip

;;; Exercise 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 3)))))
   (* 3 (- 6 2) (- 2 7)))
;Value: -43/180

;;; Exercise 1.3
(define (square a)
  (* a a))

(define (square-sum a b)
  (+ (square a) (square b)))

(define (add-large-2 a b c)
  (cond ((and (<= a b) (<= a c))        ; when a is the smallest
     (square-sum b c))
    ((and (<= b a) (<= b c))            ; when b is the smallest
     (square-sum a c))
    (else                               ; when c is the smallest
     (square-sum a b))))

(= (add-large-2 3 4 5) (square-sum 4 5)) ; #t
(= (add-large-2 8 9 0) (square-sum 8 9)) ; #t
(= (add-large-2 3 2 7) (square-sum 3 7)) ; #t
(= (add-large-2 2 2 2) (square-sum 2 2)) ; #t

;;; Exercise 1.4
;; Explaination: 
;; Because, in this model, operators are also can be the target of substitution, the form `(if (> b 0) + -)` will be substituted to `+` or `-`, making a function invocation.

;;; Exercise 1.5
;; Explanation:
;; In applicative order, evaluation and substitution begin from the innermost form. Thus, for the form `(test 0 (p))`, the interpreter will try to evaluate the call to `p` first, resulting in an infinite loop. In contrast, in normal order, the interpreter attempts to substitute the call of `test` first, expanding the given expression to `(if (= 0 0) 0 (p))`. Since the condition is true, the result of the evaluation will be 0.



;;; Edwin Variables: ***
;;; indent-tabs-mode: #f ***
;;; tab-width: 4 ***
;;; End: ***
