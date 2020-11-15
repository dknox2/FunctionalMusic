#lang racket

(provide convert-song)

(define (convert-pitch pitch)
  (if (> (string-length pitch) 1)
      (if (eq? #\# (string-ref pitch 1))
          (string-append (string (string-ref pitch 0)) "is'")
          (string-append (string (string-ref pitch 0)) "es'"))
      (string-append pitch "'")))

(define (convert-time-signature song)
  (string-append "\\absolute {\n" "\\time " (number->string (caadr song)) "/" (number->string (cadadr song)) "\n"))

(define (convert-key-signature song)
  (string-append "\\key " (caar song) " \\" (cadar song) "\n"))

(define convert-clef "\\clef treble")

(define (convert-note note)
  (string-append (convert-pitch (car note)) (number->string (denominator (cadr note))) " "))

(define (convert-measure measure)
  (let loop
    ([current-note (car measure)]
     [remaining-notes (cdr measure)]
     [output "\t"])
    (if (null? remaining-notes)
        (string-append output (convert-note current-note) "\n")
        (loop (car remaining-notes) (cdr remaining-notes) (string-append output (convert-note current-note))))))

(define (convert-all-measures measures)
  (let loop
    ([current-measure (car measures)]
     [remaining-measures (cdr measures)]
     [output ""])
    (if (null? remaining-measures)
        (string-append output (convert-measure current-measure))
        (loop (car remaining-measures) (cdr remaining-measures) (string-append output (convert-measure current-measure))))))

(define (convert-song song)
  (string-append
   (convert-time-signature song)
   (convert-key-signature song)
   convert-clef
   "\n"
   (convert-all-measures (cddr song))
   "}"))