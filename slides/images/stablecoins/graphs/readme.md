To update the "SAI/DAI price versus ETH price" graph:

- Download the latest data (go to coingecko.com, then on each page use the 'export as' link at the bottom; as of Nov 2022, it always downloads the max range regardless of what the web page shows)
	- DAI prices, in `dai-usd-max.csv`, from [https://www.coingecko.com/en/coins/dai/historical_data](https://www.coingecko.com/en/coins/dai/historical_data)
	- ETH prices, in `eth-usd-max.csv`, from [https://www.coingecko.com/en/coins/ethereum/historical_data](https://www.coingecko.com/en/coins/ethereum/historical_data)
	- As SAI is no longer used, that CSV does not have to be updated
- In `dai-eth.plot`, set the end date (the second value in the `xrange` variable on line 15) to the latest date in the data set
- If necessary, adjust the maximum ETH price (in the `y2range` variable)
- Run `make`
- Recompute and update the Coefficient of Variance value in the slides: `100*stdev()/average()`

To update the CV values:

- Ensure the data for the two cryptocurrencies listed above (DAI and ETH) are downloaded
- Download the data for five additional cryptocurrencies:
	- USDC prices, in `usdc-usd-max.csv`, from [https://www.coingecko.com/en/coins/usd-coin/historical_data](https://www.coingecko.com/en/coins/usd-coin/historical_data)
	- USDT prices, in `usdt-usd-max.csv`, from [https://www.coingecko.com/en/coins/tether/historical_data](https://www.coingecko.com/en/coins/tether/historical_data)
	- XPD prices, in `xpd-usd-max.csv`, from [https://www.coingecko.com/en/coins/petrodollar/historical_data](https://www.coingecko.com/en/coins/petrodollar/historical_data) (no longer available, apparently)
	- FEI prices, in `fei-usd-max.csv`, from [https://www.coingecko.com/en/coins/fei-usd/historical_data](https://www.coingecko.com/en/coins/fei-usd/historical_data)
	- LUNC / LUNAC prices, in `lunc-usd-max.csv`, from [https://www.coingecko.com/en/coins/terra-luna-classic/historical_data](https://www.coingecko.com/en/coins/terra-luna-classic/historical_data)
- Note that those last 5 are in the .gitignore so as not to increase the repo size significantly
- Run `./get-cv.py`
- Copy and paste the Markdown list output into the Conclusions section of stablecoins.html
- Manually enter the data for the first three (SAI, DAI, and ETH) to the appropriate slide
