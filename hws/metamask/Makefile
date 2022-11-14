doc:
	touch index.md
	cd ../..; make -s
	source-highlight -d metamask.py
	source-highlight -s cpp IAuctioneer2.sol
	../maketabs.py
	/bin/cp -f ../tokens/IERC165.sol .
	/bin/cp -f ../auction/IAuctioneer.sol .
	solc --abi ../tokens/IERC721Metadata.sol | tail -1 > IERC721Metadata.abi
	solc --abi IAuctioneer2.sol | head -8 | tail -1 > IAuctioneer2.abi
