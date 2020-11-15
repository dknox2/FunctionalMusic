# FunctionalMusic

FunctionalMusic is a library used for programmatically creating sheet music as a data structure and formatting said sheet music to be used with the open source [Lilypond music engraving program.](http://lilypond.org/).

The original goal of the project was to experiment with expressing music using pure functions, and Scheme's functional paradigm and unique lack of separation between code and data proved to be a useful tool to implement this. The project is also an ongoing experiment in applying procedural generation techniques towards generating music with varying degrees of complexity.

The project was originally written using an implementation of [Simply Scheme](https://people.eecs.berkeley.edu/~bh/ss-toc2.html), but is now fully compatible with the Racket language. However, there are still likely artifacts in the codebase from the barebones Scheme implementation that can be updated to use Racket best practices.

Currently the library is packaged with an implementation of a simplified version of a waveform collapse function to generate measures of sheet music of varying lengths, scales, chord progressions, and time signatures. The current implementation is quite simple, but the hope is the underlying code allows for easy implementation of other algorithms and techniques for creating the sheet music.

## Usage

See the ```src/example``` directory for usage. To format the Lilypond code to a PDF of human-readable sheet music, the [Lilypond program](http://lilypond.org) is required.

## Roadmap

Plans for future development involve more complex sheet music output, including multiple parts, motifs, and implementation of bass clef generation alongside the existing output for a solo instrument on the treble clef, as well as including additional techniques for generating the music.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
