(load "measure.scm")
(load "scale.scm")
(load "song-builder.scm")

(define test-scale (scale "c" major))
(define test-chord (chord "c" test-scale triad))

(define test-time-signature (time-signature 4 4))

;;(define test-measure (random-measure-in-chord test-time-signature test-chord))

(define (normalize-pitch pitch)
  (if (> (string-length pitch) 1)
      (if (eq? #\# (string-ref pitch 1))
          (string-append (string (string-ref pitch 0)) "is'")
          (string-append (string (string-ref pitch 0)) "es'"))
      (string-append pitch "'")))

(define (map-time-signature song)
  (string-append "\\absolute {\n" "\\time " (number->string (caadr song)) "/" (number->string (cadadr song)) "\n"))

(define (map-key-signature song)
  (string-append "\\key " (caar song) " \\" (cadar song) "\n"))

(define map-clef "\\clef treble")

(define (map-note note)
  (string-append (normalize-pitch (car note)) (number->string (denominator (cadr note))) " "))

(define (map-measure measure)
  (let loop
    ([current-note (car measure)]
     [remaining-notes (cdr measure)]
     [output ""])
    (if (null? remaining-notes)
        (string-append output (map-note current-note) "\n")
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
    (display (map-key-signature song) output-port)
    (display map-clef output-port)
    (display #\newline output-port)
    (display (map-all-measures (cddr song)) output-port)
    (display #\newline output-port)
    (display "}" output-port)))

(define sample-song (song-from-note-options (time-signature 3 4) (key-signature "g" "major") note-options (scale "g" major) 32))
        
(define output-port (open-output-file  "song.ly"))
(convert-song sample-song output-port)
(close-output-port output-port)
