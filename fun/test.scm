
(define check/test-example
  '(define-test equal-test "동등 테스트"
     (is eq? 'a 'a)
     (is = 1 1)
     (is equal? "a" "a")
     (is eq? 'a 'b)))

(define check/*test-registry* '())

(define (check/add-test! description proc)
  (set! check/*test-registry*
        (cons (cons description proc)
              check/*test-registry*)))

(define (check/report-success test-number)
  (format #t "  TEST ~a...SUCCESS~%" test-number))

(define (check/report-failure test-number
                        pred-form lhs-form rhs-form
                        lhs-value rhs-value)
  (format #t "  TEST ~a...FAILED: lhs(=~s) ~a rhs(=~s)~%"
          test-number lhs-value
          (if (symbol? pred-form)
              (format #f "not `~a'" pred-form)
              "does not fulfill condition with")
          rhs-value)
  (format #t "Failed form: ~s~%"
          (list pred-form lhs-form rhs-form)))

(define (check/process-is test-number
                    pred-form lhs-form rhs-form
                    pred-fn lhs-value rhs-value)
  (if (pred-fn lhs-value rhs-value)
      (begin (check/report-success test-number)
             #t)
      (begin (check/report-failure test-number
                                   pred-form lhs-form rhs-form
                                   lhs-value rhs-value)
             #f)))

(cond-expand
 (mit-scheme

  (define (check/apply-is-body test-number env is pred-form lhs-form rhs-form)
    (let ((pred-eval (make-syntactic-closure env '() pred-form))
          (lhs-eval (make-syntactic-closure env '() lhs-form))
          (rhs-eval (make-syntactic-closure env '() rhs-form)))
      `(check/process-is ,test-number
                         ',pred-form ',lhs-form ',rhs-form
                         ,pred-eval ,lhs-eval ,rhs-eval)))

  (define (check/expand-is-form test-number env is-form)
    (let ((args (cons test-number (cons env is-form))))
      (apply check/apply-is-body args)))

  (define-syntax check/expand-is-body-test-sc
    (sc-macro-transformer
     (lambda (exp env)
       (check/apply-is-body 3 env 'is 'equal? '(+ 1 2) 4))))
  
  ))


