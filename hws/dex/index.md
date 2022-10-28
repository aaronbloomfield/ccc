Decentralized Exchange (DEX)
============================

[Go up to the CCC HW page](../index.html) ([md](../index.md))


### Overview

In this assignment you are going to create a Decentralized Cryptocurrency Exchange (hereafter: DEX) for your token cryptocurrency (hereafter: TC) that you created in the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  Once deployed, anybody will be able to exchange (fake) ETH for your token cryptocurrency.  The DEX will use the 
[Constant Product Automated Market Maker (CPAMM)](../../slides/applications.html#/cpamm) method for determining the exchange rates.

Completion this homework will require completion of the following assignments:

- [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md))
- [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md))
- [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md))

Note that this assignment requires that your [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment is working properly.  If you did not get it working properly, then contact us.  You are expected to use your TokenCC code from the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment. You are welcome to use that deployment or re-deploy it; however, you may find that you have to re-deploy it many times as you are testing your DEX.  Be sure to save the contract address of the final deployment that you will use when you submit the assignment.

You will also need to be familiar with the [Ethereum slide set](../../slides/ethereum.html#/), the [Solidity slide set](../../slides/solidity.html#/), the [Tokens slide set](../../slides/tokens.html#/), and the [Blockchain Applications](../../slides/applications.html) slide set.  The last one is most relevant, as it discusses how a DEX works.

In addition to your source code, you will submit an edited version of [dex.py](dex.py.html) ([src](dex.py)).

### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### ETH price

To simulate changing market conditions, we have deployed two smart contracts to help one determine the price of our (fake) ETH.  Both of these contracts fulfill the [IEtherPriceOracle.sol](IEtherPriceOracle.sol.html) ([src](IEtherPriceOracle.sol)) interface:

```
interface IEtherPriceOracle is IERC165 {

    // The name (really a description) of the implementing contract
    function name() external view returns (string memory);

    // The currency symbol this is being reported in, such as '$'
    function symbol() external view returns (string memory);

    // How many decimals this is being reported in; for cents, it's 2
    function decimals() external view returns (uint);

    // The current price, in cents, of the (fake) ether
    function price() external view returns (uint);

    // also supportsInterface() from IERC165.sol
}
```

The `price()` function will return the current price in cents.  Thus, if the price is $99.23 per (fake) ETH, it would return `9923`.

As mentioned, there are two deployed contracts that implemented this interface, the contract addresses of which are on the Collab landing page.  The first is a constant implementation, which always returns $100.00 (formally: `10000`) as the price.  The implementation for this is in [EtherPriceOracleConstant.sol](EtherPriceOracleConstant.sol.html) ([src](EtherPricerConstant.sol)).  You can use this file for debugging or on the Javascript development environment in Remix, as it always returns the same value.

The second one is a variable version, whose price ranges greatly, but generally averages (over time) around $100 in price.  As there is no true randomness on a fully deterministic blockchain, the value is based on the highest block number and/or the latest block hash.  So while this will change at each block, it will not change until a new block is created.  The implementation for the variable version is not being provided, but it implements the IEtherPriceOracle interface above.

You should use the first (constant) one while you are debugging your code.  You will need to use the second (variable) one when you make your final deployment.  The current variable price of our (fake) ETH is shown on the DEX web page, which is described below.  The addresses for these two contracts (constant and variable) are on the Collab landing page.



### Details

Your DEX must follow the [CPAMM (Constant Product Automated Market Maker](../../slides/applications.html#/cpamm) method as discussed in the lecture slides.  Once deployed, there will be some liquidity that must be added to the DEX before trading can start.  Anybody can then exchange some of our (fake) ETH for your token cryptocurrency.  This, combined with the varying price of our (fake) ETH, will cause the price of your token cryptocurrency to fluctuate significantly.  At the end of the assignment you will register your DEX with the course-wide DEX web page so that the entire class can see all of the exchangeable token cryptocurrencies.

As far as this assignment is concerned, there will only be *one* DEX for each token cryptocurrency.  You may have deployed multiple ones to test your code, but for our class trading we will only be using the one DEX that you deploy at the end.  Specifically, the "official" DEX for a given cryptocurrency is going to be the *most recent one deployed* (this is so the explorer knows which one to use).  Thus, for this assignment, [arbitrage trading](../../slides/applications.html#/arbitrage) is not possible, since that requires trading between two or more exchanges that exchange the same pairs of tokens.  Furthermore, we are not going to be implementing [routing](../../slides/applications.html#/routing).

### Interface

Formally, you must implement a `DEX` contract that implements the [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)) interface.  Your contract opening line MUST be: `contract DEX is IDEX`.  Note that the `IDEX` interface extends the `IERC165` interface, so you will have to implement the `supportsInterface()` function as well.  The functions in this interface are shown below, and much more detail is provided in the comments in the [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)) file.

Note that many of these functions are just the getter functions from `public` variables; which ones are described in the full source file and also below.  Also note that $x$ is the amount of ether liquidity (with 18 decimals) and $y$ is the amount of token liqudity (with 8-12 decimals).

```
// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.16;

import "./IERC165.sol";
import "./IEtherPriceOracle.sol";

interface IDEX is IERC165 {

    // Events
    event liquidityChangeEvent();

    // Getting the exchange rates and prices
    function decimals() external view returns (uint);
    function symbol() external returns (string memory);
    function getEtherPrice() external view returns (uint);
    function getTokenPrice() external view returns (uint);

    // Getting the liquidity of the pool or part thereof
    function k() external view returns (uint);
    function x() external view returns (uint);
    function y() external view returns (uint);
    function getPoolLiquidityInUSDCents() external view returns (uint);
    function etherLiquidityForAddress(address who) external returns (uint);
    function tokenLiquidityForAddress(address who) external returns (uint);

    // Pool creation
    function createPool(uint _tokenAmount, uint _feeNumerator, uint _feeDenominator, 
                        address _erc20token, address _etherPricer) external payable;

    // Fees
    function feeNumerator() external view returns (uint);
    function feeDenominator() external view returns (uint);
    function feesEther() external view returns (uint);
    function feesToken() external view returns (uint);

    // Managing pool liquidity
    function addLiquidity() external payable;
    function removeLiquidity(uint amountEther) external;

    // Exchanging currencies
    function exchangeEtherForToken() external payable;
    function exchangeTokenForEther(uint amountToken) external;

    // Functions for debugging and grading
    function setEtherPricer(address p) external;
    function etherPricer() external returns (address);
    function erc20Address() external returns (address);

    // Functions for efficiency
    function getDEXinfo() external returns (address, string memory, string memory, 
                            address, uint, uint, uint, uint, uint, uint, uint, uint);

    // Inherited functions
    // function supportsInterface(bytes4 interfaceId) external view returns (bool);

}
```

This may seem like a lot, as there are 25 functions (including `supportsInterface()` and the constructor) to implement, but it turns out it's not quite as much as it seems:

- Twelve of them are just `public` variables: `k`, `x`, `y`, `decimals`, `feeNumerator`, `feeDenominator`, `feesToken`, `feesEther`, `etherLiquidityForAddress`, `tokenLiquidityForAddress`, `etherPricer`, and `erc20Address`
- Eight of them are one-line (or very short) functions: `symbol()`, `getEtherPrice()`, `getTokenPrice()`, `getPoolLiquidityInUSDCents()`, `setEtherPricer()`, `getDEXinfo()`, `supportsInterface()`, and the constructor
- That leaves only 5 significant functions to implement: `createPool()`, `addLiquidity()`, `removeLiquidity()`, `exchangeEtherForToken()`, and `exchangeTokenForEther()`

Here are all the files you will need:

- [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)): the interface, above, that your contract will need to implement; that file has many more comments in the file to describe what each function does
- [IEtherPriceOracle.sol](IEtherPriceOracle.sol.html) ([src](IEtherPriceOracle.sol)): the interface that the two pricing smart contracts implement; the contract addresses for these are on the Collab landing page
- [EtherPricerConstant.sol](EtherPriceOracleConstant.sol.html) ([src](EtherPriceOracleConstant.sol)) is the contract implementation of IEtherPriceOracle.sol that always returns 100 in cents (formally: `10000`); note that the source code for the variable version is not being made available
- Files from the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment:
	- [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)): the ERC-165 interface, which most things implement
	- [ITokenCC.sol](ITokenCC.sol.html) ([src](ITokenCC.sol)): what your token cryptocurrency implements
	- [IERC20Metadata.sol](IERC20Metadata.sol.html) ([src](IERC20Metadata.sol)): what ITokenCC extends
	- [IERC20.sol](IERC20.sol.html) ([src](IERC20.sol)): what IERC20Metadata extends
- [DEXtest.sol](DEXtest.sol.html) ([src](DEXtest.sol)) is a file to help test the TokenDEX contract, and is explained in detail below

When you want to test your program, this is the expected flow to get it started, whether to the Javascript blockchain in Remix or to our private Ethereum blockchain:

- Deploy your TokenDEX contract and (if necessary) your TokenCC contract.
- Approve your TokenDEX contract for some amount of your TokenCC supply via `approve()` on your TokenCC contract.
- Call `createPool()` on your TokenDEX.  Choose how much TokenCC supply to use (you don't have to use it all, but must use at least 10.0 TC), and put in the appropriate EtherPricer contract address.  You will have to transfer in some ether with this call.

As far this this assignment is concerned, the exchange rate between our (fake) ETH and your token cryptocurrency is initially set based on the ratio of what you send in via `createPool()`.  The overall value of the DEX is based on the current (fake) ETH price.  So if you have 100 (fake) ETH, and the price of the (fake) ETH is $99.23, then the ETH liquidity is $9,923; the value of the DEX is twice that, or $19,846.

### Fees

Each transaction will have fees deducted.  Fees are always deducted from the amount the DEX pays out (either ether or token) -- it just pays that much less.  Reasonable fees are a fraction of a percent -- between 0.2% and 0.5%, for example.  Thus, if you were trading some amount of ETH and getting 100 TC, with 0.2% fees, you would trade the same amount of (fake) ETH, but receive 99.8 TC; the other 0.2 TC are the fees.  When fees are withheld, the amount that is withheld is added to the `feesEther` and `feesToken` variables.  These variables accumulate the *total* amount of fees that the DEX has accumulated over time.

***NOTE:*** the ONLY functions that remove fees are `exchangeEtherForToken()` and `exchangeTokenForEther()`, and they only remove the fee from the amount paid *out*.  The other functions (specifically `addLiquidity()` and `removeLiquidity()`) do not deduct fees.

Managing fee payout to the liquidity providers is quite complicated -- one has to take into account how much liquidity each provider has in the DEX, and over what time frame.  There could be thousands of liquidity providers in the pool, each of which had different times that the DEX held their liquidity, and each of which gets a cut -- proportional to their liquidity -- of each transaction's fee.  Furthermore, fees are added to the liquidity pool, but only when they can be balanced with the other currency so that they can be added in appropriate proportions.

For this assignment, we are not going to handle distributing fees back to the liquidity providers -- we are just going to accumulate them into the `feesEhter` and `feesToken` variables.  This means that this inability to retrieve the fees will result in lost ETH and TC.  That's fine for this assignment, even if it would not be fine in a real world situation.

### Example

To help you debug your program, here is a worked-out example of how the values in the DEX change as various transactions occur.  This is assuming a constant (fake) ETH price of $100.  In the example below, we will call the token cryptocurrency "TC" for "Token Cryptocurrency".  For reasons we will see below, we are only putting in 10 (fake) ETH in this example, whereas you will have put in 100 when you deploy it at the end of the assignment.

- We are starting off with a few assumptions; if these vary from yours, then change as necessary
    - $x$ will always represent the amount of ETH in the pool.  As ETH is represented in wei, this will be the ETH amount with 18 decimal places
    - $y$ will always represent the amount of TC in the pool.  We assume that there are 10 decimal places for TC.
    - The assumption is that you have more TC that you own beyond what you have just deposited
    - For the examples herein, we are ignoring fees -- you can set the `feeNumerator` to 0 to get this when testing your contract
- Step 1: The DEX is deployed
    - As no pool has been created, $k$, $x$, and $y$ should all be 0
- Step 2: `createPool()` is called: initially, we will deposit 10 (fake) ETH and 100 TC
    - $k$ should be $10 \ast 100 = 1,000$, since we deposited 10 ETH and 100 TC.  But the value reported by the DEX will be with 10 more decimal places for TC and 18 more decimal places for the ETH.  So $k$ will report as $1,000 \ast 10^{10} \ast 10^{18} = 10^{31} = 10,000,000,000,000,000,000,000,000,000,000$
    - The 10 ETH are worth $100 each (we are assuming the constant price for this example), so the ETH is worth $1,000.  Since the TC is assumed to have the same value, the overall DEX liquidity is $2,000.  As we put in 100 TC into the pool, then each TC is worth $10.
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 10 or $x=10*10^{18}=10^{19}$
        - $y$, the amount of TC, is 100 or $y=100*10^{10}=10^{12}$
        - The exchange ratio is 1 ETH for 10 TC, since the DEX has 10 ETH and 100 TC, or 1 ETH per 10 TC
    - The value of the DEX is determined by how much ETH and the current price, which we are assuming is $100, since we are using the constant ether price in this example
        - As there is 10 ETH in the DEX, the value of the ETH is $10 \ast 100$ = $1,000
        - The TC is assumed to be worth an equal amount
        - Thus, the DEX liquidity is $2,000
        - In effect, the value of the DEX is twice the value of the ether therein
- Step 3: Transaction 1: we exchange 2.5 ETH for some amount of TC
    - The pool will then have 12.5 ETH (or $x=12.5 \ast 10^{18}$ wei)
    - Determine $y$ by dividing $k$ by $x$: $y = k/x = 10^{31} / 12.5 \ast 10^{18} = 8 \ast 10^{11}$ or (after removing the decimals) 80 TC
    - As the pool had 100 TC before this transaction, we get $100-80=20$ TC (formally: $20 \ast 10^{10}$)
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 12.5 or $x=12.5 \ast 10^{18}=1.25 \ast 10^{19}$
        - $y$, the amount of TC, is 80 or $y=80 \ast 10^{10}=8 \ast 10^{11}$
        - The exchange rate is 1 ETH for 6.4 TC (we just divide 80 by 12.5)
    - 20 TC are paid out, minus fees, which we are ignoring here
    - But if fees were withheld, then....
        - Let's assume fees were 0.5% (`feeNumerator` is 5, `feeDenominator` is 1000)
        - 0.5% of 20 is 0.1 TC
        - The account exchanging gets 19.9 TC for the trade
        - `feesToken` is incremented by 0.1 TC
        - $x$, $y$, and $k$ do NOT change due to the fee withholding (as the fee was deducted *after* the 20 TC were extracted from the DEX)
    - As there is 12.5 ETH in the DEX, the value of the DEX is $2,500
        - Assuming a price of $100 per ETH, and that the TC is worth the same amount
- Step 4: Transaction 2: we exchange 120 TC for some ETH
    - The pool will then have 200 TC (or $y=200 \ast 10^{10} = 2 \ast 10^{12}$)
    - Determine $x$ by dividing $k$ by $y$: $x = k/y = 10^{31} / 2 \ast 10^{12} = 5 \ast 10^{18}$ or 5 ETH
    - As the pool had 12.5 ETH, we get $12.5-5=7.5$ ETH as the payout for the exchange
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 5 or $x=5 \ast 10^{18}$
        - $y$, the amount of TC, is 200 or $y=200 \ast 10^{10}=2 \ast 10^{12}$
        - The exchange rate is 1 ETH for 40 TC (we just divide 200 by 5)
    - As there is 5 ETH in the DEX, the value of the DEX is $1,000
        - This had a huge effect on the DEX liquidity, but that is because we have (relatively) very small amounts of liquidity in the DEX
- Step 5: We add liquidity to the pool
    - The DEX has 5 ETH and 200 TC; the exchange rate is 1 ETH for 40 TC (from above)
    - We have to add in equal amounts; as far as this DEX is concerned, 1 ETH is equal to 40 TC; thus, we have to put in 40 times as many TC as we put in ETH
    - We opt to put in 1 ETH and 40 TC
    - The new amounts in the DEX will be 6 ETH and 240 ETH; this keeps the same exchange ratio of 1 ETH = 40 TC (we just divide 240 by 6)
    - $x$, the amount of ETH, increases by 1 (really $1 \ast 10^{18}$ wei) to become $x=5 \ast 10^{18} + 1 \ast 10^{18} = 6 \ast 10^{18} = 6 \ast 10^{18}$
    - $y$, the amount of TC, increases by 40 (really $40 \ast 10^{10}$) to become: $y=200 \ast 10^{10} + 40 \ast 10^{10} = 240 \ast 10^{10} = 2.4 \ast 10^{12}$
    - We recompute $k$ via $k = x \ast y = 6 \ast 10^{18} \ast 2.4 \ast 10^{12} = 1.44 \ast 10^{31}$
    - At this point:
        - $k=1.44 \ast 10^{31}$
        - $x$, the amount of ETH, is 6 or $x=6*10^{18}=6 \ast 10^{18}$
        - $y$, the amount of TC, is 240 or $y=240*10^{10}=2.4 \ast 10^{12}$
        - The exchange rate is 1 ETH for 40 TC (we just divide 240 by 6)
    - The value of the DEX is $1,200


### Testing

To help you test your code, below is a method that will test the first case from the example above -- the `createPool()` step.  This is intended to be done on the Javascript development environment in Remix.  This file is saved as [DEXtest.sol](DEXtest.sol.html) ([src](DEXtest.sol)).

```
// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./DEX.sol";
import "./TokenCC.sol";
import "./EtherPriceOracleConstant.sol";

contract DEXtestfull {

    TokenCC public tc;
    DEX public dex;

    constructor() {
        tc = new TokenCC();
        dex = new DEX();
    }

    function test() public payable {
        require (msg.value == 15 ether, "Must call test() with 15 ether");

        // Step 1: deploy the dex
        IEtherPriceOracle pricer = new EtherPriceOracleConstant();
        tc.approve(address(dex),tc.totalSupply());

        // Step 1 tests: DEX is depoloyed
        require(dex.k() == 0, "k value not 0 after DEX creation()");
        require(dex.x() == 0, "x value not 0 after DEX creation()");
        require(dex.y() == 0, "y value not 0 after DEX creation()");

        // Step 2: createPool() is called with 10 (fake) ETH and 100 TC
        try dex.createPool{value: 10 ether}(100*10**tc.decimals(), 0, 1000, address(tc), address(pricer)) {
            // do nothing
        } catch Error(string memory reason) {
            require (false, string(abi.encodePacked("createPool() call reverted: ",reason)));
        }
        
        // Step 2 tests
        require(dex.k() == 1e31, "k value not correct after createPool()");
        require(dex.x() == 10 * 1e18, "x value not correct after createPool()");
        require(dex.y() == 100 * 10**(tc.decimals()), "y value not correct after createPool()");

        // Step 3: transaction 1, where 2.5 ETH is provided to the DEX for exchange

        // Step 3 tests

        // Step 4: transaction 2, where 120 TC is provided to the DEX for exchange
  
        // Step 4 tests

        // Step 5: addLiquidity() is called with 1 (fake) ETH and 40 TC

        // Step 5 tests

        // finish up
        require(false,"end fail"); // huh?  see why in the homework description!
    }
 
    receive() external payable { } // see note in the HW description

}
```

To use this file, deploy it and then call `test()` with with 13 ether.  There are a few new concepts here, and various notes as well:

- When compiling it, you may get a message that the size exceeds the maximum limit for the blockchain -- that's because it's compiling a whole bunch of code, including all of the code of the imported files as well as the code in this file.  This large code size is fine, since we are only using it to test on the Javascript environment, which does not have this size limit, despite the warning.  So you can click on 'force send' in the Remix pop-up box.  Or you can enable compiler optimizations to get rid of that warning.
- You will need to have your `TokenCC.sol` file in the same directory so that it can compile and run
  - And the amount of your token cryptocurrency that is minted must be greater than 100
- This code verifies that the first example, above, works correctly (the example that calls `createPool()`)
	- This also does not enable any fees (the `feeNumerator` parameter is set to 0), just like the example above.
	- It is left to you to add in additional code to test the other cases above, or when fees are enabled.
- The `test()` function creates it's own copy of your token cryptocurrency (in the `cc` variable) as well as a copy of your DEX (in the `dex` variable).  Notice the use of the `new` keyword here.  Thus, they are not modifying any ones that you have previously deployed.
- This code will adapt to however many decimals your token cryptocurrency uses via the various calls to `cc.decimals()`
- There is a try-catch block here
  - The syntax is quite different than other programming languages
  - The "thing" to try is between the `try` keyword and the open curly brace at the end of that line
  - The code to do if that function call is successful (meaning no errors were thrown) is on the next line -- in this case, it's just `// do nothing`
  - The `catch` block executes if the function call reverts via `revert()` or `require()`
  - This particular version of the catch block prints out the error message obtained from the second parameter of `require()` for ease of debugging
- You will notice the last line of the function is: `require(false,"end fail")`, and this will *always* revert.  If that line were not present, and all the tests pass, then our account will lose the 16 ether we passed in.  While we can reset the account, that requires a Remix restart (or other measures).  What we want is on a means to check that all the tests pass, but get a full refund for all of the payments (including the payment to `createPool()`, in this example).  That's the purpose of this line -- if it reverts on that line, we know all the previous tests passed, but the reversion causes our account to be refunded the (fake) ETH we passed in.
- We call the function with 13 ether is so that we have enough for the initial `createPool()` call (which uses 10 ether), the successive transaction 1 listed above (which uses 2.5 ether), and a bit extra for gas.

As you work through the other test cases, one of them (transaction 2) will be paying ether *back*.  And, in this case, it is paying it back to the `DEXtest` smart contract.  Smart contracts can receive ether in two ways: as part of a `payable` function, or through a general transfer of ether.  In order to make the second one work for a smart contract, you will have to put, in `DEXtest`, the following function: `receive() external payable { }`.  Note that this function doesn't have to actually *do* anything -- hence the empty curly brackets -- but it must be present.  It is listed in the code above and the [DEXtest.sol](DEXtest.sol.html) ([src](DEXtest.sol)) file.

Notes to add:

- add 'return' in the middle for testing a failed require()
- why the end fail is there
- about code size issues, gas, increasing the gas limit, and how remix can't tell if it ran out of gas
- debugging in remix
- put require before any subtraction
- how to get balance
- gas check in dextest
- remind about capturing intermediate state
- why contract creation is in the constructor (for gas)
- how to pass in ether with a contract call


### Deployment

This part has three different steps.  This may require a few runs to get it right -- that's fine, just be sure to submit the various values (contract addresses and transaction hashes) from the last deployment.

Step 1: You will need to have deployed your TokenCC smart contract, from the previous assignment, to the blockchain, and you will need to know its contract address.  You are welcome to use the deployed one from the previous assignment, or re-deploy it for this one.  You may want to have it mint a *lot* of your token cryptocurrency.  If you mint, say, 1 million TC, then you can use that same contract on successive DEX tests, putting in 100 (or 1000 or whatever) TC each time.

Step 2: Deploy your DEX to the private Ethereum blockchain.  So that it will work properly with all of your other classmates' DEX implementations, we have some strict requirements for the deployment:

- It must be initialized with the *variable* EtherPricer contract for the price of our (fake) ether.  While you are welcome to use the constant one for testing, you MUST use the variable one for the final deployment.
- You need to call `createPool()`
	- You must fund it with 100 (fake) ether.  *Do not put a different amount in!*
	    - This implies initializing the TokenCC and allowing the DEX to transfer it via `approve()`
	- You can put as many or as little of your token in as you like (but no less than 10.0 TC).  Putting in fewer will give them a higher monetary value, but allow for less growth.  But you should keep some for yourself, as you will need it below -- so don't put them all in.  We recommend putting in no more than half of what you own, and you can certainly put in less.
	    - Or you can just mint a million of your TC, and put in 1,000 each time you run another test
- For your *final* deployment -- meaning what you are going to submit when you turn the assignment in -- do not call either `addLiquidity()` or `removeLiquidity()` yet

Step 3: You need to register your DEX with the course-wide exchange board website; the URL for this is on the Collab landing page.  To register your DEX, fill out the contract address form at the bottom of that page.  You will see your DEX values populate one of the table rows -- make sure they are correct.  Note that the current ETH price is listed at the top of the page.

### Send some TC

We will need some of your token cryptocurrency to test your DEX for grading purposes.  While you sent me some in a previous homework, that was likely with a differently deployed TokenCC smart contract.  Please send me 10.0 coins.  This means that if your TokenCC has 10 decimal places, then the value you need to send me is 100,000,000,000.  The address to send this to is on the Collab landing page.  If you are using the exact same deployed contract (meaning the same contract address), then you don't have to send me this again.  You can check how much of your TC is owned by looking at that account page in the blockchain explorer.  


### Exchanges

Now that your exchange is registered, you can view all the exchanges.  You should see your exchange in there, along with your cryptocurrency's logo.  The stats of each exchange are listed in that table.

You need to make 4 total exchanges with DEXes other than you own (meaning four or more different exchanges, but with four *different* DEXes).  You are welcome to exchange for more if you want to own more.  As you accumulate more TC from other students, you can see them on the blockchain explorer page for your account.  As you likely have more of your own Token cryptocurrency, you can now exchange that with your DEX to get some ether.  Or you can get more ether from the faucet and use that to exchange for the others.

Depending on when you submit your assignment, there may not be other DEXes to interact with.  That's fine – you don't have to have those bids completed by the time the assignment is due; you have an extra few days to place your bids. We are going to judge lateness on this assignment by the Gradescope submission time, and the Google form does not ask for the transaction hashes of the exchanges. We are going to check whether you exchange for the other token cryptocurrencies by looking if your eth.coinbase account, the address of which you will submit below, initiated exchanges on any one of your classmate's submitted DEX addresses by a few days after the due date. Note that you have to place the bid via Remix or geth; the course website just displays the auctions.


### Submission

You will need to fill in the various values from this assignment into the [dex.py](dex.py.html) ([src](dex.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Solidity source code, are the only files that must be submitted.  The 'sanity_checks' dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.


There are *three* forms of submission for this assignment; you must do all three.

Submission 1: Deploy the TokenDEX smart contract to the private Ethereum blockchain.  Your TokenCC will need to have been deployed as well, either from the previous assignment or again for this one.  These were likely done in the deployment section, above.

Submission 2: You should submit your `TokenDEX.sol` and `TokenCC.sol` files and your completed `dex.py` file, and ONLY those three files, to Gradescope.  All your Solidity code should be in the first two files, and you should specifically import the various interfaces.  Those interface files will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in dex.py, etc.).

Submission 3: Register your DEX smart contract with the course-wide exchange.  This, also, was likely done in the deployment section, above.
