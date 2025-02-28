SLIDE_SETS: introduction.html overview.html encryption.html mining.html solidity.html
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

sigcse2025:
	/bin/cp -a title-slide-sigcse2025.html title-slide.html
	quarto render --profile sigcse2025 sigcse2025.qmd --to revealjs
	git checkout title-slide.html
