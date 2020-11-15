#lang racket

(require "scale.rkt")
(require "measure.rkt")

(provide (all-defined-out))

(define (random-element list)
  (list-ref list (random (length list))))

(define (random-note notes note-length)
  (note (random-element notes) note-length))

; define some note patterns
(define two-sixteenths (list sixteenth-note sixteenth-note))

(define two-eighths (list eighth-note eighth-note))
(define two-sixteenths-eighth (append two-sixteenths (list eighth-note)))
(define eighth-two-sixteenths (cons eighth-note two-sixteenths))
(define four-sixteenths (append two-sixteenths two-sixteenths))

(define note-patterns (list
                      two-eighths
                      two-sixteenths-eighth
                      eighth-two-sixteenths
                      four-sixteenths
                      (list quarter-note)
                      (list half-note)
                      (list whole-note)))

#|
A barebones implementation of waveform collapse on a linear space to create measures of music
|#
(define (measure-of-note-patterns time-signature note-patterns chord)
  (let loop([notes '()])
    (cond
      [(measure-out-of-bounds? time-signature notes)
       (loop '())]
      [(measure-incomplete? time-signature notes)
       (let inner
         ([chosen-pattern (random-element note-patterns)]
          [built-notes '()])
         (if (null? chosen-pattern)
             (loop (append notes built-notes))
             (inner (cdr chosen-pattern) (append built-notes (list (note (random-element chord) (car chosen-pattern)))))))]
      [else
       notes])))

(define (key-signature key mode)
  (list key mode))

#|
Song format:
(key-signature time-signature (measures))
|#
(define (song-from-note-patterns time-signature key-signature note-patterns chords song-length)
  (let loop
    ([measures (list key-signature time-signature)]
     [chord-index 0])
    (if (eq? (length measures) song-length)
        measures
        (let ([measure (measure-of-note-patterns time-signature note-patterns (list-ref chords chord-index))])
          (loop (append measures (list measure)) (modulo (+ chord-index 1) (length chords)))))))

(define (random-song measure-length)
  (song-from-note-patterns (time-signature 3 4) (key-signature "b" "minor") note-patterns (chord-progression (scale "b" minor) 1-5-6-4) measure-length))