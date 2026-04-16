SLIDE_SETS: introduction.html overview.html encryption.html mining.html solidity.html
.SUFFIXES: .qmd .html
.PHONY: slides all clean

ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

slides: $(SLIDE_SETS)
	@echo conversion done

.qmd.html:
	quarto render $< --to revealjs
	@$(SED) s/", maximum-scale=1.0, user-scalable=no, minimal-ui"// $@
	@/bin/rm -rf $@.todel

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
	sed -i .bak s/"a href"/"a target='_blank' href"/g sigcse2025.html
	/bin/rm -rf sigcse2025.html.bak

accessibility:
	$(SED) s/", maximum-scale=1.0, user-scalable=no, minimal-ui"// *.html
	/bin/rm -rf *.todel
