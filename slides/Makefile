SLIDE_SETS: introduction.html overview.html
.SUFFIXES: .qmd .html
.PHONY: slides all clean

slides: $(SLIDE_SETS)
	@echo conversion done

.qmd.html:
	quarto render $< --to revealjs

clean:
	/bin/rm -rf *~ */*~ */*/*~ */*/*/*~ reductions.tmp.*

all:
	touch *.qmd
	make $(SLIDE_SETS)

graphtest:
	pdflatex graph.tex > /dev/null
	pdf2svg graph.pdf graph.html
