# tenure-dossier-latex

McGill requires two tenure dossier packages, both as a set of individual sections/files, and as a collated version.

This code (for makefile and for python) is to take a LaTeX source file for my tenure dossier, compile it, chop it up into the separate files, incorporate my separately-compiled CV, zip up the packages, inspect to make sure the page boundaries are correct, and publish them on a web site for sharing.

This is easy using LaTeX because the following was defined in my dossier source:

\newif\ifexternaldossier

which allows for conditional content.
