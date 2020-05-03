(load "measure.scm")
(load "scale.scm")
(load "song-builder.scm")

(define test-scale (scale "c" major))
(define test-chord (chord "c" test-scale triad))

(define test-time-signature (time-signature 4 4))

;;(define test-measure (random-measure-in-chord test-time-signature test-chord))

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

(define (map-all-measures measures)
  (let loop
    ([current-measure (car measures)]
     [remaining-measures (cdr measures)]
     [output ""])
    (if (null? remaining-measures)
        (string-append output (map-measure current-measure))
        (loop (car remaining-measures) (cdr remaining-measures) (string-append output (map-measure current-measure))))))

(define (convert-song song output-port)
  (begin
    (display (map-time-signature song) output-port)
    (display map-clef output-port)
    (display #\newline output-port)
    (display (map-all-measures (cdr song)) output-port)
    (display #\newline output-port)
    (display "}" output-port)))

(define (song-from-note-options time-signature note-options scale)
  (let loop ([measures (list time-signature)])
    (if (eq? (length measures) 16)
        measures
        (begin
          (let ([measure (measure-of-note-options time-signature note-options scale)])
            (display measure)
            (display #\newline)
            (loop (append measures (list measure))))))))

(define sample-song (song-from-note-options (time-signature 4 4) note-options (scale "c" major)))
        

(define output-port (open-output-file  "song.ly"))
(convert-song sample-song output-port)
(close-output-port output-port)
