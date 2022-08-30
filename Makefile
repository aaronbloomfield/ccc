.SUFFIXES: .md .html

markdown:
	@find . | grep -e "\.md$$" | grep -v reveal.js | grep -v node_modules | sed s/.md$$/.html/g | awk '{print "make -s "$$1}' | bash
	@/bin/cp -f readme.html index.html

.md.html:
	pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \
		pandoc --standalone -V "pagetitle:$$(head -1 $<)" -f markdown -c $$pathprefix"markdown.css" -H tabs.js --columns=9999 -t html5 -o $@ $<
	@echo wrote $@

markdownold:
	@echo Converting markdown files to html format...
	@chmod 755 utils/convert-markdown-to-html
	@utils/convert-markdown-to-html
	@echo done!

clean:
	/bin/rm -rf *~ */*~ */*/*~ */*/*/*~
