doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	/bin/rm -f Auctioneer.sol.html
	source-highlight -d auction.py
	../maketabs.py
