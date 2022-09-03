main:
	dot -Tsvg -O oracles.dot
	/bin/mv -f oracles.dot.svg oracles.dot.1.svg
	../../embedsvg.py oracles.dot.5.svg > outtmp.svg
	/bin/mv -f outtmp.svg oracles.dot.5.svg
