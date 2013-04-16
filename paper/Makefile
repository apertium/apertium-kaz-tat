all:
	xelatex -papersize a4 paper.tex
	bibtex paper
	cat paper.bbl | sed 's/citename/astroncite/g' > paper.bbl.tmp
	mv paper.bbl.tmp paper.bbl
	xelatex -papersize a4 paper.tex
	xelatex -papersize a4 paper.tex

clean:
	rm -rf paper.aux paper.bbl paper.blg paper.log paper.pdf
