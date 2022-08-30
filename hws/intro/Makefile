doc:
	cd ../..; make
	source-highlight *.sh *.py *.java

tabs:
	@echo '<div class="tab">' > tabs.tmp
	@grep tabcontent index.html | grep \<div | sed s/\"/\ /g | \
		awk '{print "<button class=\"tablinks\" onclick=\"openTab(event,'\''"$$3"'\'')\">"$$3"</button>"}' | \
		sed s/">t"/">"/g | sed s/"_"/" "/2 | sed s/">Overview"/" id='defaultOpen'>Overview"/g >> tabs.tmp
	@echo "</div>" >> tabs.tmp
	@l=`grep -n "<hr />" index.html | cut -f 1 -d :` && l=$$((l-1)) && head -$$l index.html > index-tabs.html
	@cat tabs.tmp >> index-tabs.html
	@l=`grep -n "<hr />" index.html | cut -f 1 -d :` && l=$$((l+1)) && tail -n +$$l index.html >> index-tabs.html
	@sed -i s/' class="tabcontenttmp"'/' class="tabcontent"'/g index-tabs.html
	@sed -i s_"</body>"_"<script>document.getElementById('defaultOpen').click();</script></body>"_g index-tabs.html
	@/bin/rm -f tabs.tmp
