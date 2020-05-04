#|
Constants representing the chromatic scale
|#
(define chromatic-scale (list "a" "a#" "b" "c" "c#" "d" "d#" "e" "f" "f#" "g" "g#"))

#|
Scale definitions in chromatic scale degrees
|#
(define major (list 1 3 5 6 8 10 12))
(define minor (list 1 3 4 6 8 9 11))

#|
Chord definitions in major scale degrees
|#
(define triad (list 1 3 5))

(define 1-5-6-4 (list 1 5 6 4))

#|
Finds the index of an element in a given list.
|#
(define (index-of element to-search)
  (let loop ([index 0]
             [current-list to-search])
    (if (equal? element (car current-list))
        index
        (loop (+ index 1) (cdr current-list)))))

#|
Gives the musical interval between two notes on the given scale.
|#
(define (scale-degree from to scale)
  (let ([start (index-of from scale)]
        [end (index-of to scale)])
    (+ (modulo (- end start) (length scale)) 1)))

#|
Filters notes in the scale according to the given degrees.
This can be used to construct new scales, chords, etc.
|#
(define (filter-notes root scale degrees)
  (filter (lambda (to)
            (list? (member (scale-degree root to scale) degrees)))
          scale))

(define (reorder-for-root scale root)
  (let loop ([current (car scale)]
             [to-process (cdr scale)]
             [reordered '()])
    (if (equal? current root)
        (append (list current) to-process reordered)
        (loop
         (car to-process)
         (cdr to-process)
         (append reordered (list current))))))

#|
Constructs a scale, starting at the given root, for the degrees.
Note this implementation is scale agnostic, any scale degrees can be given.
|#
(define (scale root degrees)
  (reorder-for-root
   (filter-notes root chromatic-scale degrees)
   root))

#|
Constructs a chord with the given root on the given scale for the degrees.
|#
(define (chord root scale degrees)
  (reorder-for-root
   (filter-notes root scale degrees)
   root))

#|
Gives the chord progression for a given scale and type of progression.
|#
(define (chord-progression scale progression)
  (let loop ([to-parse progression]
             [chords '()])
    (if (null? to-parse)
        chords
        (let ([root (list-ref scale (- (car to-parse) 1))])
          (loop
           (cdr to-parse)
           (append chords (list (chord root scale triad))))))))
    
    