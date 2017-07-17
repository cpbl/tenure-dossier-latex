
pdfviewer = evince

TEX = pdflatex
pagePS = 4
pageTeaching = 20
all: ../tenure-cv.pdf int_ChristopherBarrington-Leigh_entire_dossier.pdf ext_ChristopherBarrington-Leigh_entire_dossier.pdf external/ext_ChristopherBarrington-Leigh_entire_dossier.pdf
# tenureDossier.pdf 04_int_ChristopherBarrington-Leigh_teaching.pdf  07_int_ChristopherBarrington-Leigh_appendix-1.pdf  06_int_ChristopherBarrington-Leigh_service.pdf

../tenure-cv.pdf: ../cv.tex
	cd ..;	make
tenureDossier-external.tex: tenureDossier.tex
	sed s/externaldossierfalse/externaldossiertrue/ < tenureDossier.tex > tenureDossier-external.tex

tenureDossier.pdf : tenureDossier.tex
	latexmk tenureDossier
	pdflatex tenureDossier
	pdflatex tenureDossier
	doIfLocalX.py ${pdfviewer} tenureDossier.pdf &

ext_ChristopherBarrington-Leigh_entire_dossier.pdf: tenureDossier-external.tex
	latexmk tenureDossier-external
	pdflatex tenureDossier-external
	pdflatex tenureDossier-external
	cp -a tenureDossier-external.pdf ext_ChristopherBarrington-Leigh_entire_dossier.pdf

int_ChristopherBarrington-Leigh_entire_dossier.pdf: tenureDossier.pdf
	cp -a tenureDossier.pdf int_ChristopherBarrington-Leigh_entire_dossier.pdf

external/ext_ChristopherBarrington-Leigh_entire_dossier.pdf: ext_ChristopherBarrington-Leigh_entire_dossier.pdf explodeTenureDossier.py
	#rm external/*pdf
	python explodeTenureDossier.py
	doIfLocalX.py ${pdfviewer} external/ext_ChristopherBarrington-Leigh_entire_dossier.pdf &
	doIfLocalX.py ${pdfviewer} internal/int_ChristopherBarrington-Leigh_entire_dossier.pdf &

internal/int_ChristopherBarrington-Leigh_entire_dossier.pdf: int_ChristopherBarrington-Leigh_entire_dossier.pdf explodeTenureDossier.py
	#rm internal/*pdf
	python explodeTenureDossier.py
	#doIfLocalX.py ${pdfviewer} internal/int_ChristopherBarrington-Leigh_entire_dossier.pdf &

publish:
	zip internal/internal-package_ChristopherBarrington-Leigh.zip internal/*pdf
	zip external/external-package_ChristopherBarrington-Leigh.zip external/*pdf
	#rsync -r internal sprawl.ihsp.mcgill.ca:web/squirrels/tf/
	#rsync -r external sprawl.ihsp.mcgill.ca:web/squirrels/tf/
	rsync -r internal apolloc:web/squirrels/tf/
	rsync -r external apolloc:web/squirrels/tf/
clean:
	latexmk -c
	rm -f tenureDossier*.ptc? tenureDossier*.plt? tenureDossier*.mtc tenureDossier*.ptc tenureDossier*.mtc? tenureDossier*.maf
