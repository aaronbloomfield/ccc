SLIDE_SETS: daily-announcements.html
.SUFFIXES: .qmd .html
.PHONY: slides

slides: $(SLIDE_SETS)
	@echo conversion done

.qmd.html:
	@/bin/cp -f ../slides/_quarto.yml .
	quarto render $< --to revealjs

doc:
	@cd .. && make -s

graph:
	gnuplot prices.graph
