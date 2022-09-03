svg:
	/bin/cp -f ../../logos/btc-coin-symbol.svg .
	dot -Tsvg -O blocks.dot
	/bin/mv -f blocks.dot.svg blocks.dot.1.svg
	../../embedsvg.py blocks.dot.1.svg > out.svg
	/bin/mv out.svg blocks.dot.1.svg
	/bin/rm -rf btc-coin-symbol.svg

png:
	dot -Tpng -O blocks.dot
	/bin/mv -f blocks.dot.png blocks.dot.1.png
