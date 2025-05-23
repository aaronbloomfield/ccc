Decentralized Exchange (DEX)
============================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

<!-- 

to put on the canvas landing page:

- dex.php URL
- the account to send the 10.0 TC to
- the addresses of the constant and variable etherpricers

-->

### Overview

In this assignment you are going to create a Decentralized Cryptocurrency Exchange (hereafter: DEX) for your token cryptocurrency (hereafter: TCC) that you created in the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  Once deployed, anybody will be able to exchange (fake) ETH for your token cryptocurrency.  The DEX will use the 
[Constant Product Automated Market Maker (CPAMM)](../../slides/applications.html#/cpamm) method for determining the exchange rates.

Completion this homework will require completion of the following assignments:

- [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md))
- [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md))
- [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md))

You are expected to use your TokenCC code from the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment. If you did not get it working properly, then contact us.  You have to make a small modification to your TokenCC.sol file and then re-deploy it; however, you may find that you have to re-deploy it many times as you are testing your DEX.  Be sure to save the contract address of the final deployment that you will use when you submit the assignment.

You will also need to be familiar with the [Ethereum slide set](../../slides/ethereum.html#/), the [Solidity slide set](../../slides/solidity.html#/), the [Tokens slide set](../../slides/tokens.html#/), and the [Blockchain Applications](../../slides/applications.html) slide set.  The last one is most relevant, as it discusses how a DEX works.

In addition to your source code, you will submit an edited version of [dex.py](dex.py.html) ([src](dex.py)).

### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### ETH price

To simulate changing market conditions, we have deployed two smart contracts to help one determine the price of our (fake) ETH.  Both of these contracts fulfill the [IEtherPriceOracle.sol](IEtherPriceOracle.sol.html) ([src](IEtherPriceOracle.sol)) interface:

```
interface IEtherPriceOracle is IERC165 {

    // The name (really a description) of the implementing contract
    function name() external pure returns (string memory);

    // The currency symbol this is being reported in, such as '$'
    function symbol() external pure returns (string memory);

    // How many decimals this is being reported in; for cents, it's 2
    function decimals() external pure returns (uint);

    // The current price, in cents, of the (fake) ether
    function price() external view returns (uint);

    // also supportsInterface() from IERC165.sol
}
```

The `price()` function will return the current price in cents.  Thus, if the price is $99.23 per (fake) ETH, it would return `9923`.

There are two deployed contracts that implemented this interface, the contract addresses of which are on the Canvas landing page.  The first is a constant implementation, which always returns $100.00 (formally: `10000`) as the price.  The implementation for this is in [EtherPriceOracleConstant.sol](EtherPriceOracleConstant.sol.html) ([src](EtherPriceOracleConstant.sol)), and shown below.  You can use this file for debugging or on the Javascript development environment in Remix, as it always returns the same value.

```
// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.24;
import "./IEtherPriceOracle.sol";

contract EtherPriceOracleConstant is IEtherPriceOracle {
    string public constant name = "A constant EtherPrice oracle that always returns $100.00";
    string public constant symbol = "$";
    uint public constant decimals = 2;
    uint public constant price = 10000; // in cents

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return interfaceId == type(IEtherPriceOracle).interfaceId || interfaceId == type(IERC165).interfaceId;
    }
}
```

The second deployed contract is a variable version, whose price ranges greatly, but generally averages (over time) around $100 in price.  As there is no true randomness on a fully deterministic blockchain, the value is based on the highest block number and/or the latest block hash.  So while this will change at each block, it will not change until a new block is created.  The implementation for the variable version is not being provided, but it implements the `IEtherPriceOracle` interface, above.

You should use the first (constant) one while you are debugging your code.  You will need to use the second (variable) one when you make your final deployment.  The current variable price of our (fake) ETH is shown on the DEX web page, which is described below.  The addresses for these two contracts (constant and variable) are on the Canvas landing page.


### TokenCC

You will be using your TokenCC contract from the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  However, you will need to make two changes to your contract.  These are to your TokenCC.sol file, *NOT* to the interface.

When tokens are transferred to any contract address, we are going to have our TokenCC code attempt to call an `onERC20Received()` function on that contract, ignoring the error if the contract does not implement the `IERC20Receiver` interface.  Calling this method will also not be attempted on an owned account.

The first change is that you will have to import the [IERC20Receiver.sol](IERC20Receiver.sol.html) ([src](IERC20Receiver.sol)) file.  This file defines the `IERC20Receiver` interface which defines only one function: `onERC20Received()`.  Our TokenCC contracts are going to call this function any time tokens are transferred to another contract.  There is a similar concept for ERC-721 contracts, but not (yet) for ERC-20 contracts.  Note that your TokenCC contract does NOT implement this interface; it just needs to know about it so it can call a function (`onERC20Received()`) on *another* contract that implements this interface.

The second change is that we have to include the following two functions, adapted from [here](https://stackoverflow.com/questions/73630656/how-to-make-onrecivederc20-function), in our TokenCC.sol file:

```
// This overrides the _update() function in ERC20.sol -- first we call the
// overridden function, then we call afterTokenTransfer().  Note that this is
// called on a mint, burn, or transfer.
function _update(address from, address to, uint256 value) internal override virtual {
    ERC20._update(from,to,value);
    afterTokenTransfer(from,to,value);
}

// When a transfer occurs to a contract, this function will call
// onERC20Received() on that contract.
function afterTokenTransfer(address from, address to, uint256 amount) internal {
    if ( to.code.length > 0  && from != address(0) && to != address(0) ) {
        // token recipient is a contract, notify them
        try IERC20Receiver(to).onERC20Received(from, amount, address(this)) returns (bool success) {
            require(success,"ERC-20 receipt rejected by destination of transfer");
        } catch {
            // the notification failed (maybe they don't implement the `IERC20Receiver` interface?)
            // we choose to silently ignore this case
        }
    }
}
```

This function overrides the `_update()` function in the [ERC20.sol](../tokens/ERC20.sol.html) ([src](../tokens/ERC20.sol)) contract; this "hook" is called any time a token is transferred.  Our overridden function above will first check if the `to` is a contract by checking if it has a non-zero code size; owned accounts always have zero length code.  It also checks that both addresses are non-zero (`from` is zero on a mint operation, and `to` is zero on a burn operation).  If it passed those checks, it will attempt to call the `onERC20Received()` function, if it exists; since it's in a try-catch block, nothing happens if it the function does not exist.  If that function does not exist, then it does nothing (we could have had it revert in the `catch` clause as well).

The net effect of these two changes is that any time your TokenCC is transferred to a contract, it will attempt to notify that contract that it just received some ERC-20 tokens.

Lastly, we recommend minting a large amount of coins (a million or so, which is multiplied by $10^d$, where $d$ is how many decimals your coin uses).  This will allow you to use the same deployed TokenCC contract for multiple DEX deployments and tests.

The next section describes a way to "turn off" the functionality of the `onERC20Received()` function.

Lastly, you will need to send me 10.0 of your TCC.  But do this from the final deployment -- we remind you about that below.

### Background

#### Exchange method

Your DEX must follow the [CPAMM (Constant Product Automated Market Maker](../../slides/applications.html#/cpamm) method as discussed in the lecture slides.  Once deployed, there will be some liquidity that must be added to the DEX before trading can start.  Anybody can then exchange some of our (fake) ETH for your token cryptocurrency.  This, combined with the varying price of our (fake) ETH, will cause the price of your token cryptocurrency to fluctuate significantly.  At the end of the assignment you will register your DEX with the course-wide DEX web page so that the entire class can see all of the exchangeable token cryptocurrencies.

#### Number of DEXes

As far as this assignment is concerned, there will only be *one* DEX for each token cryptocurrency.  You may have deployed multiple ones to test your code, but for our class trading we will only be using the one DEX that you register with the DEX web page, described below.  Thus, for this assignment, [arbitrage trading](../../slides/applications.html#/arbitrage) is not possible, since that requires trading between two or more exchanges that exchange the same pairs of tokens.  Furthermore, we are not going to be implementing [routing](../../slides/applications.html#/routing).

#### Obtaining a balance

To get the ether balance of a given account, you just use the `balance` property.  You may have to cast it as a `address` first, as such: `address(a).balance`.  This reports the ether balance in wei.  To get the ERC-20 balance, you call the `balanceOf()` function on the TokenCC contract, which reports it with as many decimals as the ERC-20 contract uses (call `decimals()` to find out how many).

#### Initiating an exchange

To initiate an exchange, you just transfer the appropriate cryptocurrency to the DEX.

To exchange ether for TCC, you transfer some amount of ether to the DEX.  This will call the `receive()` function, which will handle the payout of the TCC back to the caller (aka `msg.sender`).

To exchange TCC for ether, you transfer the TCC to the DEX via your TokenCC contract; based on the modifications done above, this will call the `onERC20Received()` function, which will handle the payout of the ether back to the caller (aka `msg.sender`).

#### `receive()`

A contract can receive either in one of two ways.  The first is to have a `payable` function is called along with some ether transfer.  This was done in the `placeBid()` function in the [dApp Auction](../auction/index.html) ([md](../auction/index.md)) assignment.

To receive ether without a function call -- meaning to receive a regular ether transfer -- a special function called `receive()` must be present.  It doesn't have to *do* anything, necessarily, but it does have to be declared.  Note that, in this assignment, our `receive()` function is going to have to do quite a bit.  This function has a special form:

```
receive() payable external { // might need 'override' also
    // ...
}
```

Note that there is no `function` keyword!  Other than the different syntax, and the special case when it is called, it operates like any other function.  It can take any action, including reverting (which will abort the transfer).  In our case, this is how we are going to exchange ether for TCC.  To initiate an exchange of ether for TCC, we transfer ether in, which will call `receive()`, and the TCC will be transferred back to the caller.  As our `receive()` function is overriding what is in an interface (described below), we also put the `override` keyword there.

In Remix, you can invoke the `receive()` function by sending some ether without a function call.  To do this, put the amount in the "Value" box of the Deployment pane, set the right unit (ether, gwei, or wei), and then click on the "Transact" button at the very bottom of the contract (below the "Low level interactions" header).  This is just like transferring ether in geth.  Note that the Javascript environment seems to hang on some platforms when doing this, but if you are connected to the course blockchain, then it seems to work fine.

#### Transferring ether

To transfer ether to an address `a`, you could use the following:

```
(bool success, ) = payable(a).call{value: amount}("");
require (success, "payment didn't work");
```

A bunch of notes on this:

- The variable `a` can be an address or a specific contract.  In the DEXtest.sol file, shown below, you can pay the DEX, which is stored in a `dex` variable, via `payable(dex)`
- The parameter to call is the empty string
- The amount, in the `amount` variable, is in wei; you can also specify it as `1 ether`
- The `payable` keyword is casting it to a payable address, as you can't transfer ether to a non-payable address
- This will work for both owned addresses and contract addresses (as long as the contract address has a `receive()` function)

If this causes a reversion -- for example, the receiving contract reverts in `receive()` -- then look in the Testing section, below, for how to decode the reversion reason.


#### Receiving ether

In any function, the `msg.value` contains how much ether was sent in with the function call.  It's in wei, so 1 ether would have a `msg.value` value of $10^{18}$.  Non-`payable` functions will always have `msg.value` equal to zero.  You can't check the balance of `msg.sender`, as they do not have that amount of ether during the function call (they sent it in with the call).


#### `onERC20Received()`

The `onERC20Received()` function will be called any time TCC is transferred to a contract.  We are going to use this to initiate an exchange of TCC for ether -- one just has to transfer the TCC to the DEX, and then the DEX will compute the amount of ether to send back.

This function takes in three parameters -- the address that sent in the TC (`from`), the amount sent in (`amount`), and the ERC-20 contract for that TC (`erc20`).  For the amount, keep in mind that it is with all the decimals -- so if you send in 10 TC, and you have 10 decimals, then the value of `amount` will be $10 \ast 10^{10}$.  The point of the `erc20` parameter is to make sure that one is not trying to send in another TC, with a different ERC-20 contract, to get ether out of the DEX.  Thus, we have to check (via a `require()`) that the `erc20` address is the same as the ERC-20 contract that the DEX uses.

However, there are some times where we may NOT want `onERC20Received()` to do anything.  In particular, `addLiquidity()` (and possibly `removeLiquidity()`) will initiate a ERC-20 transfer (via calling `transferFrom()`), but we probably *don't* want `onERC20Received()` to be called at that point (it's not an exchange).  So we are going to want to have a way to "turn off" the functionality of `onERC20Received()`.  The easiest way to do this is to have an `internal` contract variable, such as `adjustingLiquidity`, that is normally set to `false`.  In `addLiquidity()` and `removeLiquidity()`, you set it to `true` when you are about to initiate the transfer, and then set it to `false` when done.

***IMPORTANT NOTE:*** Your `onERC20Received()` MUST check that the address passed in as the third parameter is the same address as the contract it is part of; `require(erc20==erc20Address,"witty error message");` will do this.  Otherwise, somebody could call that function with a *different* ERC-20 contract and drain all the TCC from your contract.

### Interface

Formally, you must implement a `DEX` contract that implements the [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)) interface.  Your contract opening line MUST be: `contract DEX is IDEX`.  Note that the `IDEX` interface extends the [IERC165](IERC165.sol.html) ([src](IERC165.sol)) interface, so you will have to implement the `supportsInterface()` function as well.  It also implements the [IERC20Receiver.sol](IERC20Receiver.sol.html) ([src](IERC20Receiver.sol)) interface, which means implementing the `onERC20Received()` function.  The functions in this interface are shown below, and much more detail is provided in the comments in the [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)) file.

Note that many of these functions are just the getter functions from `public` variables; which ones are described in the full source file and also below.  Also note that $x$ is the amount of ether liquidity (with 18 decimals) and $y$ is the amount of token liquidity (with 8-12 decimals).

```
// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.24;

import "./IERC165.sol";
import "./IEtherPriceOracle.sol";

interface IDEX is IERC165, IERC20Receiver {

    // Events
    event liquidityChangeEvent();

    // Getting the exchange rates and prices
    function decimals() external view returns (uint);
    function symbol() external returns (string memory);
    function getEtherPrice() external view returns (uint);
    function getTokenPrice() external view returns (uint);

    // Getting the liquidity of the pool or part thereof
    function k() external view returns (uint);
    function x() external view returns (uint); // amount of eth
    function y() external view returns (uint); // amount of tc
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
    function removeLiquidity(uint amountWei) external;

    // Exchanging currencies (the second one is from the IERC20Receiver interface)
    receive() external payable;
    // function onERC20Received(address from, uint amount) external returns (bool);

    // Functions for debugging and grading
    function setEtherPricer(address p) external;
    function etherPricer() external returns (address);
    function erc20Address() external returns (address);

    // Functions for efficiency
    function getDEXinfo() external returns (address, string memory, string memory, 
                            address, uint, uint, uint, uint, uint, uint, uint, uint);

    // From IERC165.sol; this contract supports three interfaces
    // function supportsInterface(bytes4 interfaceId) external view returns (bool);

    // Functions for a future assignment; they should just revert for now
    function reset() external;

}
```

This may seem like a lot, as there are 26 functions (including `supportsInterface()`, `onERC20Received()`, and the constructor) to implement, but it turns out it's not quite as much as it seems:

- Twelve of them are just `public` variables: `k`, `x`, `y`, `decimals`, `feeNumerator`, `feeDenominator`, `feesToken`, `feesEther`, `etherLiquidityForAddress`, `tokenLiquidityForAddress`, `etherPricer`, and `erc20Address`
- Eight of them are one-line (or very short) functions: `symbol()`, `getEtherPrice()`, `getTokenPrice()`, `getPoolLiquidityInUSDCents()`, `setEtherPricer()`, `getDEXinfo()`, `supportsInterface()`, `reset()`, and the constructor
- That leaves only 5 significant functions to implement: `createPool()`, `addLiquidity()`, `removeLiquidity()`, `receive()`, and `onERC20Received()`

Here are all the files you will need:

- [IDEX.sol](IDEX.sol.html) ([src](IDEX.sol)): the interface, above, that your contract will need to implement; that file has many more comments in the file to describe what each function does
- [IEtherPriceOracle.sol](IEtherPriceOracle.sol.html) ([src](IEtherPriceOracle.sol)): the interface that the two pricing smart contracts implement; the contract addresses for these are on the Canvas landing page
- [EtherPriceOracleConstant.sol](EtherPriceOracleConstant.sol.html) ([src](EtherPriceOracleConstant.sol)) is the contract implementation of IEtherPriceOracle.sol that always returns 100 in cents (formally: `10000`); note that the source code for the variable version is not being made available
- Files from the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment:
	- [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)): the ERC-165 interface, which most things implement
	- [ITokenCC.sol](ITokenCC.sol.html) ([src](ITokenCC.sol)): what your token cryptocurrency implements
	- [IERC20Metadata.sol](IERC20Metadata.sol.html) ([src](IERC20Metadata.sol)): what ITokenCC extends
	- [IERC20.sol](IERC20.sol.html) ([src](IERC20.sol)): what IERC20Metadata extends
- [IERC20Receiver.sol](IERC20Receiver.sol.html) ([src](IERC20Receiver.sol)) which was described above
- [DEXtest.sol](DEXtest.sol.html) ([src](DEXtest.sol)) is a file to help test the DEX contract, and is explained in detail below

When you want to test your program, this is the expected flow to get it started, whether to the Javascript blockchain in Remix or to our private Ethereum blockchain:

- Deploy your DEX contract and (if necessary) your TokenCC contract.
- Approve your DEX contract for some amount of your TokenCC supply via `approve()` on your TokenCC contract.
- Call `createPool()` on your DEX.  Choose how much TokenCC supply to use (you don't have to use it all, but must use at least 10.0 TCC), and put in the appropriate EtherPriceOracle contract address.  You will have to transfer in some ether with this call.

As far this this assignment is concerned, the exchange rate between our (fake) ETH and your token cryptocurrency is initially set based on the ratio of what you send in via `createPool()`.  The overall value of the DEX is based on the current (fake) ETH price.  So if you have 100 (fake) ETH, and the price of the (fake) ETH is $99.23, then the ETH liquidity is $9,923; the value of the DEX is twice that, or $19,846.

### Fees

Each transaction will have fees deducted.  Fees are always deducted from the amount the DEX pays out (either ether or token) -- it just pays that much less.  Reasonable fees are a fraction of a percent -- between 0.2% and 0.5%, for example.  Thus, if you were trading some amount of ETH and getting 100 TCC, with 0.2% fees, you would trade the same amount of (fake) ETH, but receive 99.8 TCC; the other 0.2 TCC are the fees.  When fees are withheld, the amount that is withheld is added to the `feesEther` and `feesToken` variables.  These variables accumulate the *total* amount of fees that the DEX has accumulated over time.

***NOTE:*** the ONLY functions that remove fees are `receive()` and `onERC20Received()`, and they only remove the fee from the amount paid *out*.  The other functions (specifically `addLiquidity()` and `removeLiquidity()`) do not deduct fees.

Managing fee payout to the liquidity providers is quite complicated -- one has to take into account how much liquidity each provider has in the DEX, and over what time frame.  There could be thousands of liquidity providers in the pool, each of which had different times that the DEX held their liquidity, and each of which gets a cut -- proportional to their liquidity -- of each transaction's fee.  Furthermore, fees are added to the liquidity pool, but only when they can be balanced with the other currency so that they can be added in appropriate proportions.

For this assignment, we are not going to handle distributing fees back to the liquidity providers -- we are just going to accumulate them into the `feesEther` and `feesToken` variables.  It adds a lot of complexity to compute who is owned what part of the fees based on the amount of liquidity they have in the DEX and for how long they have had it.  This means that this inability to retrieve the fees will result in lost ETH and TCC.  That's fine for this assignment, even if it would not be realistic in a real world situation.

### Example

To help you debug your program, here is a worked-out example of how the values in the DEX change as various transactions occur.  This is assuming a constant (fake) ETH price of $100.  For reasons we will see below, we are only putting in 10 (fake) ETH in this example, whereas you will have put in 100 when you deploy it at the end of the assignment.

- We have a few conventions that we are following for this assignment:
    - $x$ will always represent the amount of ETH in the pool.  As ETH is represented in wei, this will be the ETH amount with 18 decimal places
    - $y$ will always represent the amount of TCC in the pool.
- We are starting off with a few assumptions; if these vary from yours, then change as necessary
    - The assumption is that you have more TCC that you own beyond what you have just deposited
    - You had to choose a number of decimals between 8 and 12 for your TCC; we assume it is 10 for this example
    - For the examples herein, we are ignoring fees -- you can set the `feeNumerator` to 0 to get this when testing your contract
- Step 1: The DEX is deployed
    - As no pool has been created, $k$, $x$, and $y$ should all be 0
- Step 2: `createPool()` is called: initially, we will deposit 10 (fake) ETH and 100 TCC
    - $k$ should be $10 \ast 100 = 1,000$, since we deposited 10 ETH and 100 TCC.  But the value reported by the DEX will be with 10 more decimal places for TCC and 18 more decimal places for the ETH.  So $k$ will report as $1,000 \ast 10^{10} \ast 10^{18} = 10^{31} = 10,000,000,000,000,000,000,000,000,000,000$
    - The 10 ETH are worth $100 each (we are assuming the constant price for this example), so the ETH is worth $1,000.  Since the TCC is assumed to have the same value, the overall DEX liquidity is $2,000.  As we put in 100 TCC into the pool, then each TCC is worth $10.
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 10 or $x=10*10^{18}=10^{19}$
        - $y$, the amount of TCC, is 100 or $y=100*10^{10}=10^{12}$
        - The exchange ratio is 1 ETH for 10 TCC, since the DEX has 10 ETH and 100 TCC, or 1 ETH per 10 TCC
    - The value of the DEX is determined by how much ETH and the current price, which we are assuming is $100, since we are using the constant ether price in this example
        - As there is 10 ETH in the DEX, the value of the ETH is $10 \ast 100$ = $1,000
        - The TCC is assumed to be worth an equal amount
        - Thus, the DEX liquidity is $2,000
        - In effect, the value of the DEX is twice the value of the ether therein
- Step 3: Transaction 1: we exchange 2.5 ETH for some amount of TCC
    - The pool will then have 12.5 ETH (or $x=12.5 \ast 10^{18}$ wei)
    - Determine $y$ by dividing $k$ by $x$: $y = k/x = 10^{31} / 12.5 \ast 10^{18} = 8 \ast 10^{11}$ or (after removing the decimals) 80 TCC
    - As the pool had 100 TCC before this transaction, we get $100-80=20$ TCC (formally: $20 \ast 10^{10}$)
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 12.5 or $x=12.5 \ast 10^{18}=1.25 \ast 10^{19}$
        - $y$, the amount of TCC, is 80 or $y=80 \ast 10^{10}=8 \ast 10^{11}$
        - The exchange rate is 1 ETH for 6.4 TCC (we just divide 80 by 12.5)
    - 20 TCC are paid out, minus fees, which we are ignoring here
    - But if fees were withheld, then....
        - Let's assume fees were 0.5% (`feeNumerator` is 5, `feeDenominator` is 1000)
        - 0.5% of 20 is 0.1 TCC
        - The account exchanging gets 19.9 TCC for the trade
        - `feesToken` is incremented by 0.1 TCC
        - $x$, $y$, and $k$ do NOT change due to the fee withholding (as the fee was deducted *after* the 20 TCC were extracted from the DEX)
    - As there is 12.5 ETH in the DEX, the value of the DEX is $2,500
        - Assuming a price of $100 per ETH, and that the TCC is worth the same amount
- Step 4: Transaction 2: we exchange 120 TCC for some ETH
    - The pool will then have 200 TCC (or $y=200 \ast 10^{10} = 2 \ast 10^{12}$)
    - Determine $x$ by dividing $k$ by $y$: $x = k/y = 10^{31} / 2 \ast 10^{12} = 5 \ast 10^{18}$ or 5 ETH
    - As the pool had 12.5 ETH, we get $12.5-5=7.5$ ETH as the payout for the exchange
    - At this point:
        - $k=10^{31}$
        - $x$, the amount of ETH, is 5 or $x=5 \ast 10^{18}$
        - $y$, the amount of TCC, is 200 or $y=200 \ast 10^{10}=2 \ast 10^{12}$
        - The exchange rate is 1 ETH for 40 TCC (we just divide 200 by 5)
    - As there is 5 ETH in the DEX, the value of the DEX is $1,000
        - This had a huge effect on the DEX liquidity, but that is because we have (relatively) very small amounts of liquidity in the DEX
- Step 5: We add liquidity to the pool
    - The DEX has 5 ETH and 200 TCC; the exchange rate is 1 ETH for 40 TCC (from above)
    - We have to add in equal amounts; as far as this DEX is concerned, 1 ETH is equal to 40 TCC; thus, we have to put in 40 times as many TCC as we put in ETH
    - We opt to put in 1 ETH and 40 TCC
    - The new amounts in the DEX will be 6 ETH and 240 ETH; this keeps the same exchange ratio of 1 ETH = 40 TCC (we just divide 240 by 6)
    - $x$, the amount of ETH, increases by 1 (really $1 \ast 10^{18}$ wei) to become $x=5 \ast 10^{18} + 1 \ast 10^{18} = 6 \ast 10^{18} = 6 \ast 10^{18}$
    - $y$, the amount of TCC, increases by 40 (really $40 \ast 10^{10}$) to become: $y=200 \ast 10^{10} + 40 \ast 10^{10} = 240 \ast 10^{10} = 2.4 \ast 10^{12}$
    - We recompute $k$ via $k = x \ast y = 6 \ast 10^{18} \ast 2.4 \ast 10^{12} = 1.44 \ast 10^{31}$
    - At this point:
        - $k=1.44 \ast 10^{31}$
        - $x$, the amount of ETH, is 6 or $x=6*10^{18}=6 \ast 10^{18}$
        - $y$, the amount of TCC, is 240 or $y=240*10^{10}=2.4 \ast 10^{12}$
        - The exchange rate is 1 ETH for 40 TCC (we just divide 240 by 6)
    - The value of the DEX is $1,200


### Testing

#### Handling reversions on payment

When paying out to another address, your Solidity code is going to look like the following:

```
(bool success, ) = payable(a).call{value: v}("");
require(success, "Failed to transfer ETH");
```

If that call fails (by returning false), then it will stop on that require.  However, if that call fails by reverting -- such as when the receiving contract reverts in `receive()` -- then we have to do a bit more work to get (and display) the reversion reason.

The following function will decode the reversion reason:

```
// From https://ethereum.stackexchange.com/questions/83528/how-can-i-get-the-revert-reason-of-a-call-in-solidity-so-that-i-can-use-it-in-th
function getRevertMsg(bytes memory _returnData) internal pure returns (string memory) {
    // If the _res length is less than 68, then the transaction failed silently (without a revert message)
    if (_returnData.length < 68)
        return 'Transaction reverted silently';

    assembly {
        // Slice the sighash.
        _returnData := add(_returnData, 0x04)
    }
    return abi.decode(_returnData, (string)); // All that remains is the revert string
}
```

However, in order to use that function, we have to get the encoded reversion reason.  We will use the following code to pay from a contract -- it captures the (encoded) reversion reason in the second part of the tuple (`result`).

```
(bool success, bytes memory result) = payable(address(dex)).call{value:amtEther * 1 ether}("");
require (success, string.concat("Payment to DEX didn't work: ", getRevertMsg(result)));
```

#### DEXtest testing contract

To help you test your code, below is a method that will test the first case from the example above -- the `createPool()` step.  This is intended to be done on the Javascript development environment in Remix and NOT on the course blockchain.  This file is saved as [DEXtest.sol](DEXtest.sol.html) ([src](DEXtest.sol)).

```
// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.24;

import "./DEX.sol";
import "./TokenCC.sol";
import "./EtherPriceOracleConstant.sol";

contract DEXtest {

    TokenCC public tc;
    DEX public dex;

    constructor() {
        tc = new TokenCC();
        dex = new DEX();
    }

    function test() public payable {
        require (msg.value == 13 ether, "Must call test() with 13 ether");

        // Step 1: deploy the ether price oracle
        IEtherPriceOracle pricer = new EtherPriceOracleConstant();

        // Step 1 tests: DEX is deployed
        require(dex.k() == 0, "k value not 0 after DEX creation()");
        require(dex.x() == 0, "x value not 0 after DEX creation()");
        require(dex.y() == 0, "y value not 0 after DEX creation()");

        // Step 2: createPool() is called with 10 (fake) ETH and 100 TCC
        bool success = tc.approve(address(dex),100*10**tc.decimals());
        require (success,"Failed to approve TCC before createPool()");
        try dex.createPool{value: 10 ether}(100*10**tc.decimals(), 0, 1000, address(tc), address(pricer)) {
            // do nothing
        } catch Error(string memory reason) {
            require (false, string.concat("createPool() call reverted: ",reason));
        }
        
        // Step 2 tests
        require(dex.k() == 1e21 * 10**tc.decimals(), "k value not correct after createPool()");
        require(dex.x() == 10 * 1e18, "x value not correct after createPool()");
        require(dex.y() == 100 * 10**tc.decimals(), "y value not correct after createPool()");

        // Step 3: transaction 1, where 2.5 ETH is provided to the DEX for exchange

        // Step 3 tests

        // Step 4: transaction 2, where 120 TCC is provided to the DEX for exchange
  
        // Step 4 tests

        // Step 5: addLiquidity() is called with 1 (fake) ETH and 40 TCC

        // Step 5 tests

        // finish up
        require(false,"end fail"); // huh?  see why in the homework description!
    }
 
    receive() external payable { } // see note in the HW description

}
```

#### Using DEXtest

To use this file, deploy it and then call `test()` with with 13 ether.  There are a few new concepts here, and various notes as well:

- When compiling it, you may get a message that the size exceeds the maximum limit for the blockchain -- that's because it's compiling a whole bunch of code, including all of the code of the imported files as well as the code in this file.  This large code size is fine, since we are only using it to test on the Javascript environment, which does not have this size limit, despite the warning.  So you can click on 'force send' in the Remix pop-up box.  Or you can enable compiler optimizations to get rid of that warning.
- You will need to have your (updated) `TokenCC.sol` file in the same directory so that it can compile and run
  - And the amount of your token cryptocurrency that is minted must be greater than 100
- You may have to increase the default gas limit when calling this function.  If it runs out of gas, the Javascript environment just says it reverted, but does not say why.  Just add one more zero to the gas limit box (30 million instead of 3 million), and you should be fine.
- This code verifies that the first example, above, works correctly (the example that calls `createPool()`)
	- This also does not enable any fees (the `feeNumerator` parameter is set to 0), just like the example above.
	- It is left to you to add in additional code to test the other cases above, or when fees are enabled.
- The constructor creates it's own copy of your token cryptocurrency (in the `cc` variable) as well as a copy of your DEX (in the `dex` variable).  These are done there to save gas usage when calling the `test()` function.  Notice the use of the `new` keyword here.  Thus, they are not modifying any ones that you have previously deployed.
- This code will adapt to however many decimals your token cryptocurrency uses via the various calls to `cc.decimals()`
- There is a try-catch block here
  - The syntax is quite different than other programming languages
  - The "thing" to try is between the `try` keyword and the open curly brace at the end of that line
  - The code to do if that function call is successful (meaning no errors were thrown) is on the next line -- in this case, it's just `// do nothing`
  - The `catch` block executes if the function call reverts via `revert()` or `require()`
  - This particular version of the catch block prints out the error message obtained from the second parameter of `require()` for ease of debugging
- You will notice the last line of the function is: `require(false,"end fail")`, and this will *always* revert.  If that line were not present, and all the tests pass, then our account will lose the 16 ether we passed in.  While we can reset the account, that requires a Remix restart (or other measures).  What we want is on a means to check that all the tests pass, but get a full refund for all of the payments (including the payment to `createPool()`, in this example).  That's the purpose of this line -- if it reverts on that line, we know all the previous tests passed, but the reversion causes our account to be refunded the (fake) ETH we passed in.
- We call the function with 13 ether is so that we have enough for the initial `createPool()` call (which uses 10 ether), the successive transaction 1 listed above (which uses 2.5 ether), and a bit extra for gas.



#### General debugging hints

We have collected a number of debugging hints here.

- The debugger in Remix is not all that useful, as it can only debug in EVM opcode form, and does not do a good job to map the EVM opcodes back to the Solidity source code.  And of course we don't have print statements.
- Put in a LOT of `require()` statements.  You can always remove them later.  For example, on each subtraction, put in a require that the first value is greater than or equal to the second, and with a different error message each time.  This way it will revert with a known error message.  Otherwise, a subtraction that yields a negative value will revert with no error message and with no line number.
- You may get an oddball reversion, and are unable to trace it.  Put a line in your code such as `require(false,"got here");` and then re-run it.  Move that line around until you figure out what line in your source code is causing the reversion.
- It may be that something is not working, and you can't tell why.  To help figure out the solution, you will need to see what the various values are in the middle of the function execution -- this is capturing the intermediate state.  To do this, you can create a number of contract variables (`uint public debug1`, for example) and save your intermediate state to them.  When you get to the point that is causing a problem, put a `return` right before it.  This way the function will successfully complete, and you can look at the debug variables to see what your intermediate state is.
- Don't you wish you had gdb or lldb to help debug all this?
- Did you turn off the functionality of `onERC20Received()` via a contract variable, as described above?  Otherwise, adding or removing liquidity will call the `onERC20Received()` function, which is probably not what you want to do.

### Deployment

This part has three different steps.  This may require a few runs to get it right -- that's fine, just be sure to submit the various values (contract addresses and transaction hashes) from the most recent deployment.

Step 1: You will need to have deployed your (updated) TokenCC smart contract to the private Ethereum blockchain, and you will need to know its contract address.

Step 2: Deploy your DEX smart contract to the private Ethereum blockchain.  So that it will work properly with all of your other classmates' DEX implementations, we have some strict requirements for the deployment:

- It must be initialized (in `createPool()`) with the *variable* EtherPriceOracle contract for the price of our (fake) ether.  While you are welcome to use the constant one for testing, you MUST use the variable one for the final deployment.
    - Keep in mind that you can always update it via the `setEtherPricer()` function if you initialize it with the wrong one
- You need to call `createPool()`; save the TXN from this call, as that will need to be submitted
	- You must fund it with 100 (fake) ether.  ***Do not put a different amount in!***
    - You can put as many or as little of your token in as you like (but no less than 10.0 TCC).  Putting in fewer will give them a higher monetary value, but allow for less growth.  But you should keep some for yourself, as you will need it below -- so don't put them all in.  We recommend putting in no more than half of what you own, and you can certainly put in less.
        - Or you can just mint a million of your TCC, and put in 1,000 each time you run another test
        - This implies initializing the TokenCC and allowing the DEX to transfer it via `approve()`
- For your *final* deployment -- meaning what you are going to submit when you turn the assignment in -- do not call either `addLiquidity()` or `removeLiquidity()` yet

Step 3: You need to register your DEX with the course-wide exchange board website; the URL for this is on the Canvas landing page.  To register your DEX, fill out the contract address form at the bottom of that page.  You will see your DEX values populate one of the table rows -- make sure they are correct.  Note that the current ETH price is listed at the top of the page.


#### Exchanges

Now that your exchange is registered, you can view all the exchanges.  You should see your exchange in there, along with your cryptocurrency's logo.  The stats of each exchange are listed in that table.

You need to make 4 total exchanges with DEXes other than you own (meaning four or more different exchanges, but with four *different* DEXes).  You are welcome to exchange for more if you want to own more.  As you accumulate more TCC from other students, you can see them on the blockchain explorer page for your account.  As you likely have more of your own Token cryptocurrency, you can now exchange that with your DEX to get some ether.  Or you can get more ether from the faucet and use that to exchange for the others.

Depending on when you submit your assignment, there may not be other DEXes to interact with.  That's fine – you don't have to have those bids completed by the time the assignment is due; you have an extra few days to place your bids. We are going to judge lateness on this assignment by the Gradescope submission time, and the Google form does not ask for the transaction hashes of the exchanges. We are going to check whether you exchange for the other token cryptocurrencies by looking if your eth.coinbase account, the address of which you will submit below, initiated exchanges on any one of your classmate's submitted DEX addresses by a few days after the due date. Note that you have to place the bid via Remix or geth; the course website just displays the auctions.


### Submission

You will need to fill in the various values from this assignment into the [dex.py](dex.py.html) ([src](dex.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Solidity source code, are the only files that must be submitted.  The `sanity_checks` dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.

There are *five* forms of submission for this assignment; you must do all five.

Submission 1: Deploy the DEX smart contract to the private Ethereum blockchain.  Your TokenCC will need to have been deployed as well.  These were likely done in the deployment section, above.  You have to call `createPool()` with exactly 100 (fake) ether, some number of TCC (no less than 10.0 TCC), and the address of the variable EtherPriceOracle.

Submission 2: Send 10.0 TCC to the address listed on the Canvas landing page.  This means that if your TokenCC has 10 decimal places, then the value you need to send is 100,000,000,000.  You can check how much of your TCC is owned by any account by looking at that account page in the blockchain explorer.  

Submission 3: You should submit your `DEX.sol`, your (updated) `TokenCC.sol` files, and your completed `dex.py` file, and ONLY those three files, to Gradescope.  All your Solidity code should be in the first two files, and you should specifically import the various interfaces.  Those interface files will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in dex.py, etc.).

Submission 4: Register your DEX smart contract with the course-wide exchange.  This, also, was likely done in the deployment section, above.

Submission 5: Make at least 4 exchanges with other DEXes.
