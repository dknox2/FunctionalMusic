(load "scale.scm")
(load "measure.scm")

(define (random-element list)
  (list-ref list (random (length list))))

(define (random-note notes note-length)
  (note (random-element notes) note-length))

#|
Construct a random measure using notes in the given chord with the given time signature
|#
(define (random-measure-in-chord time-signature chord)
  (let loop ([notes '()])
    (if (valid-measure? time-signature notes)
        (measure time-signature notes)
        (loop (append notes (list (random-note chord quarter-note))))))) ;; TODO we are only using quarter notes here

(define test-scale (scale 'C major))
(define test-chord (chord 'C test-scale triad))

(define test-time-signature (time-signature 4 4))

(random-measure-in-chord test-time-signature test-chord)