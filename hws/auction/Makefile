doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	/bin/rm -f Auctioneer.sol.html
	source-highlight -d auction.py
	../maketabs.py

sync:
	/bin/cp -f ../tokens/IERC165.sol ../tokens/IERC721.sol ../tokens/IERC721Metadata.sol .
