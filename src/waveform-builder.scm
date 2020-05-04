(load "lilypond-convert.scm")
(load "waveform-song.scm")

(define song (song-from-note-patterns (time-signature 3 4) (key-signature "b" "minor") note-patterns (chord-progression (scale "b" minor) 1-5-6-4) 32))

(define lilypond-code (convert-song song))

(define output-port (open-output-file  "song.ly"))
(display lilypond-code output-port)
(close-output-port output-port)
