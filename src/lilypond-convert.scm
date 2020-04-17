(load "measure.scm")
(load "scale.scm")
(load "song-builder.scm")

(define test-scale (scale "c" major))
(define test-chord (chord "c" test-scale triad))

(define test-time-signature (time-signature 4 4))

(define test-measure (random-measure-in-chord test-time-signature test-chord))

(define (map-time-signature song)
  (string-append "\\relative c'' {\n" "\\time " (number->string (caar song)) "/" (number->string (cadar song)) "\n"))

(define map-clef "\\clef treble")

(define (map-note note)
  (string-append (car note) (number->string (denominator (cadr note))) " "))

(define (map-measure measure)
  (let loop
    ([current-note (car measure)]
     [remaining-notes (cdr measure)]
     [output ""])
    (if (null? remaining-notes)
        (string-append output (map-note current-note))
        (loop (car remaining-notes) (cdr remaining-notes) (string-append output (map-note current-note))))))

(define (convert-song song output-port)
  (begin
    (display (map-time-signature song) output-port)
    (display map-clef output-port)
    (display #\newline output-port)
    (display (map-measure (cadr song)) output-port)
    (display #\newline output-port)
    (display "}" output-port)))

(define output-port (open-output-file "song.ly"))
(convert-song test-measure output-port)
(close-output-port output-port)
