(load "scale.scm")

;; Declare note length constants
(define eighth-note 1/8)
(define quarter-note 1/4)
(define half-note 1/2)
(define whole-note 1)

(define (time-signature num-of-beats note-value)
  (list num-of-beats note-value))

;; note;
;; (pitch length)
(define (note pitch length)
  (list pitch length))

(define (normalize-to-time-signature note-length time-signature)
  (expt note-length (/ (cadr time-signature) note-length)))

(define (valid-measure? time-signature notes)
  (equal?
   (/ (car time-signature) (cadr time-signature))
   (apply + (map cadr notes))))

;; measure:
;; ((time signature) (notes))
;; where sum of notes = enough beats to complete measure
(define (measure time-signature notes)
  (list time-signature notes))

;; song:
;; 'SONG time-signature measures
(define (song time-signature)
  (list 'SONG time-signature))