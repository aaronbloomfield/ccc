doc:
	cd ../..; make
	source-highlight -s cpp -d *.sol
	/bin/rm -f Auctioneer.sol.html
	source-highlight -d auction.py
	../maketabs.py
