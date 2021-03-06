#lang racket

(provide (all-defined-out))

;; Declare note length constants
(define sixteenth-note 1/16)
(define eighth-note 1/8)
(define quarter-note 1/4)
(define half-note 1/2)
(define whole-note 1)

;; time signature:
;; (num-of-beats note-value)
(define (time-signature num-of-beats note-value)
  (list num-of-beats note-value))

;; note:
;; (pitch length)
(define (note pitch length)
  (list pitch length))

(define (measure-length measure)
  (apply + (map cadr measure)))

(define (measure-out-of-bounds? time-signature measure)
  (<
   (/ (car time-signature) (cadr time-signature))
   (measure-length measure)))

(define (measure-incomplete? time-signature measure)
  (>
   (/ (car time-signature) (cadr time-signature))
   (measure-length measure)))

;; measure:
;; (notes)
;; where sum of notes = enough beats to complete measure according to song
(define (measure notes)
  (list notes))