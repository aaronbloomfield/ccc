.SUFFIXES: .md .html
LICENSE = <p>Released under a CC BY-SA <img src='slides/images/cc-by-sa-icon.svg' /></p>
ifeq ($(shell uname),Darwin)
	SED=sed -i bak
else
	SED=sed -i
endif

markdown:
	@find . | grep -e "\.md$$" | grep -v reveal.js | grep -v node_modules | sed s/.md$$/.html/g | awk '{print "make -s "$$1}' | bash
	@/bin/cp -f readme.html index.html

.md.html:
	pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \
		pandoc --standalone -V "pagetitle:$$(head -1 $<)" -H tabs.js -f markdown -c $$pathprefix"markdown.css" --columns=9999 -t html5 -o $@ $<
	@echo wrote $@
	#$(SED) s_"</body>"_"$(LICENSE)</body>"_g $@
	#pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \

markdownold:
	@echo Converting markdown files to html format...
	@chmod 755 utils/convert-markdown-to-html
	@utils/convert-markdown-to-html
	@echo done!

clean:
	/bin/rm -rf *~ */*~ */*/*~ */*/*/*~
