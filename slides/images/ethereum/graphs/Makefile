main:
	/bin/cp -f ../../logos/eth-coin-symbol.svg .
	dot -Tsvg -Kdot -O ethereum.dot
	/bin/mv -f ethereum.dot.svg ethereum.dot.1.svg
	../../embedsvg.py ethereum.dot.1.svg > out.svg
	/bin/mv out.svg ethereum.dot.1.svg
	/bin/rm -rf eth-coin-symbol.svg
