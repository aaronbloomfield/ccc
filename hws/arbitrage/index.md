Arbitrage Trading
=================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

In this assignment you are going to create a Python program to perform [arbitrage trading](../../slides/applications.html#/arbitrage) on the blockchain.  Your trading will be between a number of different DEX instances from the [DEX](../dex/index.html) ([md](../dex/index.md)) assignment.

Regardless of what you named your token cryptocurrency, we are going to refer to it as 'TC' here (for Token Cryptocurrency).

Beyond general experience with programming Solidity (which you have at this point it the course), this assignment requires:

- That you completed the [DEX](../dex/index.html) ([md](../dex/index.md)) assignment as we will be using that.  If you didn't get yours working, contact us, and we will provide a few deployed DEXes for you.
- That you completed the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment as we will be using your TokenCC contract.
- Familiarity with the [arbitrage trading](../../slides/applications.html#/arbitrage) section of the lecture slides

In addition to your source code, you will submit an edited version of [arbitrage.py](arbitrage.py.html) ([src](arbitrage.py)).


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### DEX

You will need to deploy five (or so) instances of your DEX.  The intent is to have a difference in exchange rates between these, and your program below will take advantage of these differences.  Before you deploy them, however, read this section through.

There is a lot to do to get this all set up: you have to deploy a TokenCC contract, five (or so) DEXes, initialize all the DEXes via `createPool()`, and then perform some trades to create a difference in the exchange rates.  While this can all be done manually, we can automate that via a smart contract.  Consider the following method:

```
function setup(uint numdex, uint amt_eth, uint amt_tc) public payable {
    require (msg.value > numdex * amt_eth * 1 ether, "Must supply enough eth");
    // create and fund the DEXes
    for ( uint i = num_dexes; i < num_dexes+numdex; i++ ) {
        dexes[i] = payable(address(new DEX()));
        TokenCC(tokencc).approve(dexes[i],amt_tc * 10**TokenCC(tokencc).decimals());
        DEX(dexes[i]).createPool{value: amt_eth * 1 ether}(amt_tc * 10**TokenCC(tokencc).decimals(), 
                                 3, 1000, tokencc, etherpricer);
    }
    num_dexes += numdex;
}
```

This handles all the deployment of the DEXes.  As the addresses of the DEXes and the TokenCC contract are stored in public variables (a `dexes` mapping and a `tokencc` field, respectively), we can get their addresses after this function runs -- we'll need those when we write our arbitrage trading program.  Note that this function requires supplying ETH with the call -- if you are creating 5 DEXes with 10 ETH per DEX, then you have to supply it with 50 ETH plus gas fees (or just make it 51 ETH).

We also want to make a few exchanges on the DEXes to vary the exchange rates.  Consider:

```
function configureDEXes() public payable {
    require (msg.value > 10 ether, "Must supply enough eth");
    // excahnge with the DEXes
    uint balance = TokenCC(tokencc).balanceOf(address(this));
    bool success;
    (success,) = address(dexes[1]).call{value: 1 ether}("");
    require(success,"DEX exchange call 1 didn't succeed");
    (success,) = address(dexes[2]).call{value: 2 ether}("");
    require(success,"DEX exchange call 2 didn't succeed");
    (success,) = address(dexes[3]).call{value: 3 ether}("");
    require(success,"DEX exchange call 3 didn't succeed");
    (success,) = address(dexes[4]).call{value: 4 ether}("");
    require(success,"DEX exchange call 4 didn't succeed");
    // give the sender the TC obtained
    uint xferamt = TokenCC(tokencc).balanceOf(address(this)) - balance;
    TokenCC(tokencc).transfer(msg.sender,xferamt);
}
```

When supplied with 10 ETH (plus enough for gas fees, so we can just make it 11 ETH), this will make a few exchanges.  We can't put this code in the `setup()` function, above, as that would run over the gas limit.

We provide these functions, and a few others, in an [Arbitrage.sol](Arbitrage.sol.html) ([src](Arbitrage.sol)) file for you to use.  ***NOTE:*** Just using this blindly without understanding what it does will not be successful -- you need to understand the code that is being called.  You will not be submitting this file, so feel free to adapt it as desired.  Note that we create a constant EtherPriceOracle in that contract, as we need to pass in an EtherPriceOracle to the `createPool()` function to initialize the DEX.  However, we don't call any functions on the DEX that use the EtherPriceOracle, so using the constant one is fine here.

In addition to your TokenCC.sol and DEX.sol files (and any supporting files so they can compile), you will need the
[IEtherPriceOracle.sol](../dex/IEtherPriceOracle.sol.html) ([src](../dex/IEtherPriceOracle.sol)) and [EtherPriceOracleConstant.sol](../dex/EtherPriceOracleConstant.sol.html) ([src](../dex/EtherPriceOracleConstant.sol)) files.


### Web3.py

You will need to read the [introduction to web3.py](../../docs/web3py.html) ([md](../../docs/web3py.md)).  While you do not need to have all of that memorized, you do need to understand it all!  The intent is that you will use that page as a reference while you write this assignment.


### Market Theory

#### When to make an trade

Your program will need to compute it's *holdings*, which is the dollar amount of all the ETH and TC that it has.  You can assume some fixed price for ETH (say, $100) and for TC (say, $1) for initial testing -- but that means that your DEXes should have about 100 times as much TC as ETH.  

You will first need to obtain the various information (prices, $x$/$y$/$k$ values at each DEX, etc.).  Then you will need to make a *profitable trade*.  A profitable trade is defined here as a trade where the overall value of *holdings*, in USD, increases.  You must account for gas fees when determining this!  The formula to determine if you will make a profit is whether:

> $ethAmountAfter \ast ethPrice + tcAmountAfter \ast tcPrice > ethAmountBefore \ast ethPrice + tcAmountBefore \ast tcPrice - gasFees$

Note: there are other reasonable ways to determine "profit".  In particular, if one believes that the price of the currency will grow, then the total amount of that currency (not the total USD value) would be another metric.  For our purposes, we will just use the USD value of the holdings.

We are going to call this a *single trade*.  This is when you make one transaction at a single DEX to increase your holdings.

<!--

However, it could be that making *two* trades at once is profitable, whereas making one would not -- you must consider this possibility as well.  For example, imagine that ETH is worth $100, TC is worth $1, and you have 10 ETH and no TC, for a holdings of $1000.  We'll assume a constant exchange rate, even though our DEXes use $x \ast y = k$ to compute the exchange rate.  If a DEX 1 has a 1:100 ETH:TC exchange rate, then making that trade would not increase the holdings -- you would get $10 \ast 100 = 1,000$ TC for your 100 ETH, still worth $1000, but but the gas fees would lower that amount slightly, causing a loss of holdings.  However, if another DEX could trade that TC back for *more* ETH -- say it had a 1:50 ETH:TC exchange rate -- then you could trade that 1,000 TC for 20 ETH, making a profit.  Thus, you  must consider making two trades to make a profit as well.  We are going to call this a *double trade*.

You can assume the number of DEXes involved, $d$, is relatively small, so you can compute $d^2$ different combinations.  We will not be testing it with more than, say, half a dozen DEXes.

-->

For each DEX, and for each of the two directions (ETH -> TC and TC -> ETH), find the (DEX,currency,amount) combination that maximizes your profit.  Consider the most profitable such transaction among all the available DEXes.  If that transaction increases your holdings in USD, then take that action.  It's also possible that a *double trade* would yield a profit, where as a single trade would not (for example, exchanging some ETH for some TC in one DEX, and then trading that TC back for more ETH at a different DEX).  We are not considering double trades for this assignment.


#### How much to buy

We can formulaically determine how much to buy.  The full derivation of the formulas in this section is being omitted here, but you can see that full derivation [here](extra.html) ([md](extra.md)).  First we need to define a number of variables:

- The DEX values are $x_d$, $y_d$, and $k_d$
- The current prices are $p_e$ and $p_t$, the price of ETH and TC, respectively
- The quantity of each that we currently have is $q_e$ and $q_t$, for the quantity of ETH and TC, respectively
- Our holdings are $h_{now}$ (our current holdings) and $h_{after}$ (our holdings after the transaction)
- The gas fees, computed as per the [introduction to web3.py](../../docs/web3py.html) ([md](../../docs/web3py.md)) page, are $g$; this is in units of ETH.  Gas fees are discussed below (in the "Assignment" section)
- $f$ is the percentage (out of 1.0) obtained after the DEX fees are removed.  So if $f_n$ is the fee numerator (say, 3) and $f_d$ is the fee denominator (say, 1000), then $f=1-f_n/f_d$.  As an example, if $f_n=3$ and $f_d=1000$, then $f=0.997$.  Note that this fee applies to both ETH and TC transactions, but only on the amount paid out.  Each DEX will have their own fee values.

The above values are all fixed when the program runs -- either from the config file (described below) or by querying the DEXes.  Different DEXes will have different values for $x_d$, $y_d$, and $k_d$, of course.  The only values that the program chooses are the amount of ETH that we trade in (we'll call this $\delta_e$) or the amount of TC that we trade in (we'll call this $\delta_t$).  As we are only considering a single trade, only one of them will be non-zero.

The formulas that we need are (derivations [here](extra.html) ([md](extra.md))):

- Our current holdings, in USD, are: <!-- $h_{now} = q_{e} \ast p_{e} + q_{t} \ast p_{t}$ --> <img src="formulas/formulas/img1.svg" class="formula">
- If we trade in TC, then our holdings after (in USD) are: <!-- $h_{after} = (q_{e} + f \ast x_{d}-f \ast k_d/(y_{d}+\delta_{t})) \ast p_{e} + (q_{t}-\delta_{t}) \ast p_{t} - g \ast p_e$  --> <img src="formulas/formulas/img3.svg" class="formulabig">
- If we trade in ETH, then our holdings after (in USD) are: <!-- $h_{after} = (q_{t} + f \ast y_{d}-f \ast k_d/(x_{d}+\delta_{e})) \ast p_{t} + (q_{e}-\delta_{e}) \ast p_{e} - g \ast p_e$  --> <img src="formulas/formulas/img5.svg" class="formulabig">

For a single trade, want to find the maximum profit for the two $h_{after}$ formulas.  We take the derivative, then set it equal to zero to find the roots (details [here](extra.html) ([md](extra.md)), if you are interested).  The roots will give us the maximum and/or minimum points.  This gives us:

- If we traded in TC, then the maxima or minima is at: <!-- $\delta_{t}=-y_d\pm$ &#8730; $(f \ast k_d \ast p_e/p_t)$ --> <img src="formulas/formulas/img7.svg" class="formulabig">
    - Note that $p_e$ is in the numerator in that fraction, which is different than the fraction in the next formula
- If we traded in ETH, then the maxima or minima is at: <!-- $\delta_{e}=-x_d\pm$ &#8730; $(f \ast k_d \ast p_t/p_e)$ --> <img src="formulas/formulas/img9.svg" class="formulabig">
    - Note that $p_t$ is in the numerator in that fraction, which is different than the fraction in the previous formula
<!-- - Those two formulas do not render well in HTML, but the entire parenthetical is what we take the square root of -->

A few notes on those:

- If you want to cut-and-paste these formulas into your program, the [derivations page](extra.html) ([md](extra.md)) has them in text form
- Neither of these are guaranteed to make a profit!  But if a profit can be made, then one of those will be the maximum profit.
- How much profit is determined from the $h_{after}$ formulas, above
- Because the variables in the square root can never be negative, and because the fraction denominators can never be zero, the square root will always return real values
- However, the values to trade (meaning $\delta_e$ or $\delta_t$) may be negative, and you should ignore them in that case
- The values to trade (meaning $\delta_e$ or $\delta_t$) may be larger than your balance; if so, then you should consider how much profit can be made from trading in all of your balance in that case


### Assignment

Your assignment is to create a program that attempts to make a profit by arbitrage trading.  For the purposes of this assignment, a *profit* means an increase in the value of your holdings in USD; the holdings are computed from the amount of ETH and TC your program controls as well as the current price of each.  

You must take gas estimation into account!  Otherwise, if you were only to make 0.001 ETH, but it costs 0.002 ETH in gas, you are losing money.  How to estimate gas fees is discussed on the [introduction to web3.py](../../docs/web3py.html) ([md](../../docs/web3py.md)) page -- once you create a transaction, you call `eth.estimateGas()`.  The expected gas values will be in the tens of thousands of gas -- 36,000 to 65,000 is a reasonable guess, but yours may be higher or lower.

When providing a transaction, you also have to supply the gasPrice.  **For this assignment, we will select a standard 10 gwei as the gas price.**  The gas estimate times the gas cost (10 gwei) will allow you to compute the cost of gas in ether, which is the $g$ variable in the formulas above.

Your program must be in Python.  It must be named `arbitrage_trading.py`.

In practice, your program would listen for events from any of the DEXes, and any time the exchange rate of any of the DEXes changed, it would re-run the analysis.  In order to make this assignment gradable, we are going to ignore events, and specify a different way that this program is to be run.

#### Input

The program will import an arbitrage_config.py file to provide all the settings, a sample of which is shown below:

```
config = {
    'account_address': '0x123456789abcdef0123456789abcdef123456789',
    'account_private_key': hexbytes.HexBytes('0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'),
    'connection_is_ipc': True,
    'connection_uri': '/path/to/geth.ipc',
    'price_eth': 100.00,
    'price_tc': 10.0,
    'dex_addrs': ['0x123456789abcdef0123456789abcdef123456789', '0x123456789abcdef0123456789abcdef123456789', 
                  '0x123456789abcdef0123456789abcdef123456789', '0x123456789abcdef0123456789abcdef123456789',
                  '0x123456789abcdef0123456789abcdef123456789'],
    'dex_fees': 0.005, # 0.5%, or from the DEX assignment: feeNumerator = 5, feeDenominator = 1000
    'tokencc_addr': '0x123456789abcdef0123456789abcdef123456789',
    'max_eth_to_trade': 10.0,
    'max_tc_to_trade': 100.0,
}
```

The `output()` function, below, will also be in the [arbitrage_config.py](arbitrage_config.py.html) ([src](arbitrage_config.py)) file, as well as a few more useful items.

You may assume that the arbitrage_config.py will always be present and properly structured, and that all values will be valid.  The parts of the `config` dictionary are:

- `account_address`: the address of the Ethereum account that this program is controlling -- it is the balance that this account has, in both ETH and TC, that constitutes the holdings of this account
- `account_private_key`: the (decrypted) private key for that account, used to initiate transactions; this must be in the exact format shown above
    - You will have obtained the decrypted version of your private key in the [Private Ethereum Blockchain](../ethprivate/index.html) assignment -- you may have to run through that part again if you lost it or are now using a different key
    - That key was likely in the form `b'0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'` -- just copy the hex code (meaning without the leading `b'` and trailing `'`) into the `HexBytes()` constructor to make it the same format as the code above.
- `connection_is_ipc`: whether the connection URI (which is on the next line in this file) is a geth.ipc file or a URL -- this will determine how the web3 provider is created
    - Your code MUST be able to handle both types of connections!
- `connection_uri`: how to connect to the blockchain -- this will either be the path to a geth.ipc file or a URL to the course server; see the [introduction to web3.py](../../docs/web3py.html) ([md](../../docs/web3py.md)) for details -- you either have to pass it to a `Web3.IPCProvider()` call or a `Web3.WebsocketProvider()` call
- `price_eth`: the current price of ETH, in USD, as a float -- this is without all the extra decimal places
- `price_tc`: the current price of TC, in USD, as a float -- this is without all the extra decimal places
- `dex_addrs`: the smart contract addresses of the various DEX smart contracts; there will be at least two in this list
- `dex_fees`: the percentage of fees that the DEX takes.  To make using this simpler, for the purposes of this assignment, we will assume that all the DEXes have the same fee percentage.
- `tokencc_addr`: the smart address of the TokenCC smart contract
- `max_eth_to_trade` is the maximum amount of ether to trade in a given transaction -- it's meant to allow you to limit your trade to a reasonable value (say, 10 ether) rather than accidentally trading everything you have by mistake
- `max_tc_to_trade`: just like the previous, but with TC instead of ether


You will need to edit all those values in arbitrage_config.py to match the deployed addresses (and other values) for your particular situation.

We provide a few other things in arbitrage_config.py: the ABI for IDEX and ITokenCC for you to use.  We also provide a function called `getTXNResult()` that will attempt to figure out what happened on a transaction function call (the return value or revert reason).  You can see these in the [arbitrage_config.py](arbitrage_config.py.html) ([src](arbitrage_config.py)) file.


#### Output

Your program will analyze the various values at the different DEXes, and make a change (or not).  Your output must be in an exact format.  If no profitable trades are possible, then you should output `No profitable arbitrage trades available`.  If an trade is made, then the output should be of the form:

```
Exchanged -123.0000 ETH for 2.3400 TC; fees: 1.23 USD; prices: ETH 12.30 USD, TC: 1.23 USD; holdings: 34.30 USD
```

<!--

If two trades are made, then print out two lines of that form.  Keep in mind that each program execution will either make one single trade or one double trade.  

-->

To ensure you output in the correct format, we provide a function that will print the appropriate lines.  This function is also provided in the [arbitrage_config.py](arbitrage_config.py.html) ([src](arbitrage_config.py)) file.

```
def output(ethAmt, tcAmt, fees, holdings):
    if ethAmt == 0 and tcAmt == 0:
        print("No profitable arbitrage trades available")
        return
    assert ethAmt * tcAmt < 0, "Exactly one of ethAmt and tcAmt should be negative, the other positive"
    if ethAmt < 0:
        print("Exchanged %.4f ETH for %.4f TC; fees: %.2f USD; prices: ETH %.2f USD, TC: %.2f USD; holdings: %.2f USD" %
              (ethAmt, tcAmt, fees, config['price_eth'], config['price_tc'], holdings))
    else:
        print("Exchanged %.4f TC for %.4f ETH; fees: %.2f USD; prices: ETH %.2f USD, TC: %.2f USD; holdings: %.2f USD" %
              (tcAmt, ethAmt, fees, config['price_eth'], config['price_tc'], holdings))
```

***YOUR FINAL PROGRAM SHOULD PRODUCE NO OTHER OUTPUT*** other than the result of calling the `output()` function, above.

If there are no profitable transactions available, then pass in 0 for the first two parameters; the values of the last two parameters do not matter in this case.  When a transaction is made, then one of `ethAmt` or `tcAmt` should be negative -- that's the one that is being sold.  The other should be positive, and is how much of the other you received for that exchange.  These values should be the amount of coin being bought or sold, and without all the decimals (so 1.5 TC rather than 15000000000 TC).  The prices for ETH and TC are pulled from `config` dict, so they do not have to be passed into this function.  The `fees` and `holdings` parameters should be in USD.

The `fees` value that you are reporting is just the USD value of the Ethereum transaction fees PLUS the DEX fees (amount withheld times its price).


### Testing

When testing your code, don't worry about getting the $x$, $y$, and $k$ values exactly correct for a test.  If you want to test a particular situation.  To see if your program makes the right decision, for example, you can hard-code those values in the arbitrage_trading.py program and print out the results to see if it computed the correct values to trade.  Trying to get all the DEXes deployed and configured exactly will be very frustrating if you are trying for exact values.  Instead, make a few transactions to the various DEXes from *another* account to get the $x$, $y$, and $k$ values to differ between the different DEXes.  The provided [Arbitrage.sol](Arbitrage.sol.html) ([src](Arbitrage.sol)) contract performs a few initial trades, but you may need to do more for your testing.  The `arbitrage_trading.py` program is then called to see if any profitable trades can be made.

When testing this code, you can open up the appropriate WebSocket port when you run geth -- just add `--ws --ws.origins localhost,127.0.0.1` to the (now long) list of command line parameters when you start your geth node.  Your connection_uri will then be `ws://localhost:8546`.  You are also welcome to connect to the course server (the URI of which is on the Collab landing page) or via your geth.ipc file.

#### Testing setup

[![](img/ddc.webp){style='width:300px;float:right'}](img/ddc.webp){target='_blank'}

To help you in your testing, we have deployed six DEXes that all trade the same coin, but at different rates.  The coin is Dragon Dice Coin (DDC), whose image is shown to the right.  The six different DEXes all trade at a *fixed* exchange rate -- which means that multiple trades will *not* change their $x$, $y$, or $k$ values.  This is not realistic in a real-world situation, of course, but it is useful for testing.  The six different DEXes have the icons of different sided dice, which correspond to their exchange rates:

- [![](img/d4c.webp){style='width:50px;vertical-align:middle'}](img/d4c.webp){target='_blank'} D4 exchanges at a rate of 1:4 (ETH:TC)
- [![](img/d6c.webp){style='width:50px;vertical-align:middle'}](img/d6c.webp){target='_blank'} D6 exchanges at a rate of 1:6 (ETH:TC)
- [![](img/d8c.webp){style='width:50px;vertical-align:middle'}](img/d8c.webp){target='_blank'} D8 exchanges at a rate of 1:8 (ETH:TC)
- [![](img/d10c.webp){style='width:50px;vertical-align:middle'}](img/d10c.webp){target='_blank'} D10 exchanges at a rate of 1:10 (ETH:TC)
- [![](img/d12c.webp){style='width:50px;vertical-align:middle'}](img/d12c.webp){target='_blank'} D12 exchanges at a rate of 1:12 (ETH:TC)
- [![](img/d20c.webp){style='width:50px;vertical-align:middle'}](img/d20c.webp){target='_blank'} D20 exchanges at a rate of 1:20 (ETH:TC)

Just to clarify: all six of these DEXes exchange the same DDC coin, but at different exchange rates.  The individual dice images are used for the images of the DEXes; the multi-dice image to the right is the image of the coin.  The DEXes all follow the [IDEX.sol](../dex/IDEX.sol.html) ([src](../dex/IDEX.sol) interface, and the DDC coin follows the [ITokenCC.sol](../tokens/ITokenCC.sol.html) ([src](../tokens/ITokenCC.sol)) interface.

The addresses of all these DEXes, as well as DDC, are on the Collab landing page.

#### Obtaining DDC

The [ITokenCC.sol](../tokens/ITokenCC.sol.html) ([src](../tokens/ITokenCC.sol)) interface has a `requestFunds()` function, which you just had revert in the [dApp Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  For DDC, that function will pay you 100 DDC on each call.  This will allow you to obtain DDC for use in your exchange testing.

Of course, you can also exchange ether for DDC with any of the DEXes to obtain DDC.

#### Limiters

The problem with fixed exchange rates is that it is easy to deplete the DEX of funds -- one could exchange 1 ETH for 20 TC via the D20 DEX, then back for 5 ETH via the D4 DEX, and repeat forever.  This would deplete the reserves of the DEXes and also cause the blockchain size to balloon.  It would also prevent other students from using the DEXes.  For this reason, there are three limiters in effect for DDC and these DEXes:

- You may not make more than 1 exchange to a given DEX every 5 minutes (300 seconds).  This is checked by looking at the block timestamp.  Remix will not always be able to judge correctly when 5 minutes has passed; see the [Arbitrage trading](../arbitrage/index.html) ([md](../arbitrage/index.md)) for details (in the "Notes and Hints" tab, under "`block.timestamp()` behavior").  This time limit is per DEX, so if you exchange with one DEX, you can still exchange with another right away.
- You may not receive more than 10,000 ether from all of these DEXes combined.  This is a total, and is independent of how much you have paid back to the DEXes.  Thus, if you exchange for 10,000 ether from one of the DEXes, and then exchange it back for DDC with that same DEX, this limit will still take effect and none of these six DEXes will allow any further exchanges for ether.  Thus, you should try exchanging for smaller values (say, 10 ether).
- You may not own more than 100,000 DDC at any one time.  Unlike the previous limitation, this is a single snapshot, so if you are at the limit, and you exchange some back, you can then exchange for more DDC.

These values can be changed by the course instructor, although that may take some time (i.e., it's not instantaneous).  However, you should use smaller amounts -- don't start by trading in a huge amount of ether, or all of your DDC, as this will cause you to hit your limits very quickly.

Keep in mind that the difficult part of this assignment is making the calculations.  During testing you can have your code make those calculations, print out the result (and lots of intermediate values), but not make the actual trade on the blockchain.  When you finally submit your solution, it should print out exactly one line, as described above, and make the trade.

Lastly, these DEXes have the ability to be "turned off" so that any attempt at a transaction will revert with an appropriate error message (either "trading not currently enabled" or "this DEX has been destructed").  In the former case, it will be turned on again soon.  In the latter case, the DEXes were likely replaced -- check the Collab landing page for new DEX (and DDC) addresses.

#### Usage

The different DEX addresses are on the Collab landing page, and also provided in the arbitrage_config.py file.  THe intent is for you to comment out different DEXes in that file so that you can test it with different pairs.  The provided [arbitrage_config.py](arbitrage_config.py.html) ([src](arbitrage_config.py)) does not have the addresses of the six DEXes deployed on the course-wide blockchain, but the version linked to from the Collab landing page does.

#### Examples

To be filled in...


### Real-world profit?

Could you use this program in the real world with real ETH?

Well, sorta.

The concepts are the same.  But you would have to make a few changes:

- The DEX addresses would be different, of course, since that would be on the real Ethereum blockchain.
- You would listen for events from the DEXes to trigger the analysis -- we know how to do that from the [DAO & web3 assignment](../daoweb3/index.html) ([md](../daoweb3/index.md)) in Javascript, and the function calls are similar in web3.py.
- You would need to consider double (or triple) trades, not just single trades.
- They are going to use a different set of exchange functions, and different DEXes are likely to have different interfaces (and thus different ABIs); thus you would need *separate* code to interact with each individual DEX.
- I'm guessing you would want to test your code really, really, really well if you were about to put a whole bunch of money into it.
- We assumed a fixed price based on what was in the config file.  If the USD value of the holdings was your metric, then you would need a means to get real-time prices.  You could also use a different metric, such as how much of each currency you had in your holdings.
- One of the big issues here is speed -- if an arbitrage opportunity does exist, and your program takes 20 seconds to figure that out, it is going to get beat by a program written in a faster language that can do it in 10 seconds.  The difference between those would mean that the other one would get in the block before yours, and make the profit instead.
- You would likely be making *limit* orders instead of *market* orders (meaning you place an upper bound on the exchange rate when you place an order) -- we have ignored limit orders in this course.

But the concepts are certainly the same!

### Submission

You will need to fill in the various values from this assignment into the [arbitrage.py](arbitrage.py.html) ([src](arbitrage.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Python source code, are the only files that must be submitted.  The 'sanity_checks' dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.


There is only one submission for this assignment.

Submission 1: Submit your `arbitrage_trading.py` source code file, along with your completed `arbitrage.py` file, to Gradescope.  You should not submit the arbitrage_config.py file.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in arbitrage.py, etc.).
