(load "scale.scm")

(define (time-signature num-of-beats note-value)
  (list num-of-beats note-value))

;; note;
;; (length pitch)
(define (note pitch length)
  (list pitch length))

(define (normalize-to-time-signature note-length time-signature)
  (

;; measure:
;; (note note note note)
;; where sum of notes = enough beats to complete measure
(define (valid-measure? measure time-signature)
  (eq? (car time-signature) (/ (apply + (map (lambda (length) (expt length (/ (cadr time-signature) length))) (map cadr measure))) (cadr time-signature))))

;; song:
;; 'SONG time-signature measures
(define (song time-signature)
  (list 'SONG time-signature))

(define test-measure
  (list
   (note 'C 4)
   (note 'D 4)
   (note 'F 4)))

(valid-measure? test-measure (list 3 4))