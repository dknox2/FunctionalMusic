#lang racket

(require racket/include)
(require "../lilypond-convert.rkt")
(require "../waveform-song.rkt")

(define song (random-song 32))

(define lilypond-code (convert-song song))

(define time (current-seconds))
(define title (string-append (number->string time) ".ly"))

(define output-port (open-output-file title))
(display lilypond-code output-port)
(close-output-port output-port)