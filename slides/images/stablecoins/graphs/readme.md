To update this graph:

- Download the latest data
	- DAI prices, in `dai-usd-max.csv`, from https://www.coingecko.com/en/coins/dai/historical_data
	- ETH prices, in `eth-usd-max.csv`, from https://www.coingecko.com/en/coins/ethereum/historical_data
- In `dai-eth.plot`, set the end date (the second value in the `xrange` variable) to the latest date in the data set
- If necessary, adjust the maximum ETH price (in the `y2range` variable)
- Run `make`
- Update the Coefficient of Variance value in the slides
