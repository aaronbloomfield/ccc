main:
	@/bin/cp -f ../../logos/et?-coin-symbol.svg .
	@dot -Tsvg -O ethetc.dot
	@/bin/mv -f ethetc.dot.svg ethetc.dot.1.svg
	@../../embedsvg.py ethetc.dot.1.svg > outtmp.svg
	@/bin/mv -f outtmp.svg ethetc.dot.1.svg
	@/bin/rm -f et?-coin-symbol.svg
