.SUFFIXES: .md .html
LICENSE = <p>Released under a CC BY-SA <img src='slides/images/cc-by-sa-icon.svg' /></p>
ifeq ($(shell uname),Darwin)
	SED=sed -i .todel
else
	SED=sed -i
endif

markdown:
	@find . | grep -e "\.md$$" | grep -v reveal.js | grep -v node_modules | sed s/.md$$/.html/g | awk '{print "make -s "$$1}' | bash
	@/bin/cp -f readme.html index.html

.md.html:
	pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \
		pandoc --template `git rev-parse --show-toplevel`/pandoc-template.html --standalone --metadata lang="en" -V "pagetitle:$$(head -1 $<)" -H tabs.js -f markdown -c $$pathprefix"markdown.css" --columns=9999 -t html5 -o $@ $<
	@echo wrote $@
	$(SED) s_"<pre>"_"<pre class='widget' tabindex='0'>"_g $@
	/bin/rm -f $@.todel
	#$(SED) s_"</body>"_"$(LICENSE)</body>"_g $@
	#pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \

touchall:
	find . | grep "\.md$$" | awk '{print "touch "$$1}' | bash

markdownold:
	@echo Converting markdown files to html format...
	@chmod 755 utils/convert-markdown-to-html
	@utils/convert-markdown-to-html
	@echo done!

clean:
	/bin/rm -rf *~ */*~ */*/*~ */*/*/*~

all-source-highlight:
	cd slides/code/ && make source && cd ..
	cd hws/ethprivate/ && make source && cd ..
	cd hws/auction/ && make source && cd ..
	cd hws/daoweb3/ && make source && cd ..
	cd hws/intro/ && make source && cd ..
	cd hws/btcscript/ && make source && cd ..
	cd hws/arbitrage/ && make source && cd ..
	cd hws/btcparser/ && make source && cd ..
	cd hws/metamask/ && make source && cd ..
	cd hws/gradebook/ && make source && cd ..
	cd hws/dex/ && make source && cd ..
	cd hws/tokens/ && make source && cd ..
	cd hws/dappintro/ && make source && cd ..
	custom-source-highlight.sh hws/Debug.sol
	
