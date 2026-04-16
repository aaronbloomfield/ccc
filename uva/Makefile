SLIDE_SETS: daily-announcements.html
.SUFFIXES: .qmd .html
.PHONY: slides

ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

slides: $(SLIDE_SETS)
	@echo conversion done

.qmd.html:
	@/bin/cp -f ../slides/_quarto.yml .
	quarto render $< --to revealjs
	@$(SED) s/", maximum-scale=1.0, user-scalable=no, minimal-ui"// $@
	@/bin/rm -rf $@.todel

doc:
	@cd .. && make -s

graph:
	gnuplot prices.graph
