;;;; test.lisp
;;;;
;;;; This file is part of the cl-closure-template library, released under Lisp-LGPL.
;;;; See file COPYING for details.
;;;;
;;;; Author: Moskvitin Andrey <archimag@gmail.com>

(defpackage #:closure-template.test
  (:use #:cl #:iter #:lift)
  (:import-from #:closure-template.parser #:parse-expression #:parse-template #:parse-single-template)
  (:export #:run-closure-template-tests))

(in-package #:closure-template.test)


(deftestsuite closure-template-test () ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expression parser tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftestsuite expression-parser-test (closure-template-test) ())

(addtest (expression-parser-test)
  expression-1
  (ensure-same '(:variable "var")
               (parse-expression " $var ")))

(addtest (expression-parser-test)
  expression-2
  (ensure-same '(+ (:variable "x") (:variable "y"))
               (parse-expression " $x + $y ")))

(addtest (expression-parser-test)
  expression-3
  (ensure-same '(:min (:variable "x") (:variable "y"))
               (parse-expression "min($x, $y)")))

(addtest (expression-parser-test)
  expression-4
  (ensure-same '(:min (:variable "x") (:max 5 (:variable "y")))
               (parse-expression "min($x, max(5, $y))")))


(addtest (expression-parser-test)
  expression-5
  (ensure-same "Hello world"
               (parse-expression "'Hello world'")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expression parser tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftestsuite template-parser-test (closure-template-test) ())

(addtest (template-parser-test)
  hello-name-template
  (ensure-same '(CLOSURE-TEMPLATE.PARSER:TEMPLATE ("helloName") "Hello "
                 (CLOSURE-TEMPLATE.PARSER:PRINT-TAG (:VARIABLE "name")))
               (parse-single-template "{template helloName}Hello {$name}{/template}")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Run all tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun run-closure-template-tests (&optional (test 'closure-template-test))
  "Run all closure-template tests"
  (run-tests :suite test :report-pathname nil))








