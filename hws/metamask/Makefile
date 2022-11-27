doc:
	touch index.md
	cd ../..; make -s
	source-highlight -d metamask.py
	../maketabs.py
	/bin/cp -f ../tokens/IERC165.sol .
	/bin/cp -f ../auction/IAuctioneer.sol .
	solc --abi ../tokens/INFTManager.sol | tail -1 > INFTManager-full.abi
	solc --abi ../auction/IAuctioneer.sol | head -4 | tail -1 > IAuctioneer-full.abi
	python3 -c "import json; print([x for x in json.load(open('INFTManager-full.abi')) if x['name'] in ['mintWithURI','approve','tokenURI']])" > INFTManager.abi
	python3 -c "import json; print([x for x in json.load(open('IAuctioneer-full.abi')) if x['name'] in ['startAuction','placeBid','closeAuction','nftmanager','auctions','num_auctions']])" > IAuctioneer.abi
