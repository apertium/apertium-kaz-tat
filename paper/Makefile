all:
	xelatex -papersize a4 paper.tex
	bibtex paper
	xelatex -papersize a4 paper.tex
	xelatex -papersize a4 paper.tex

clean:
	rm -rf tt-ba.aux tt-ba.bbl tt-ba.blg tt-ba.log tt-ba.pdf
