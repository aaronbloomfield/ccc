Decentralized NFT Auction
=========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))


### Overview

In this assignment you will write a smart contract, in Solidity, to handle auctions for NFTs.  The NFTs will be ERC-721 tokens.

Once deployed to our private Ethereum blockchain, anybody should be able to initiate an auction by transferring an NFT to the smart contract.  Anybody could then submit a bid to the auction.  To prevent somebody from placing a bid and then not paying, one has to transfer ETH to the smart contract when a bid is placed -- it is the transfer of this ETH that actually places the bid.  Anybody who is outbid will have their ETH returned, and they can choose (or not) to place a higher bid.  Once the auction is completed, the ETH from the winning bid is transferred to the person who initiated the auction, and the NFT is transferred to the winning bidder.

### Pre-requisites

Writing this homework will require completion of the following assignments:

- [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md))
- [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md))
- [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md))

Note that this assignment requires that your [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment is working properly.  If you did not get it working properly, then see the next section.

You will also need to be familiar with the [Ethereum slide set](../../slides/ethereum.html#/), the [Solidity slide set](../../slides/solidity.html#/), and the [Tokens slide set](../../slides/tokens.html#/)


### Task 1: Create some NFT images in your NFTmanager

You should use your NFT manager that you wrote and deployed in the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  You can use the previously deployed version or you can redeploy it, either one is fine.  If you were unable to get yours working in that assignment, then speak to me, and I will provide an alternative deployed contract for you to use.

You will need to submit the contract address of your NFT manager, and the transaction hash that deployed it, at the end of this assignment.

You will need to have *three* images for NFTs to be used in this assignment.  You can reuse the ones you created for the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment.  As with that assignment, you are welcome to use anything in the public domain, including memes.  But nothing inappropriate or otherwise offensive.  As before, in this course, owning the NFT does NOT imply ownership of the image -- the assumption is that you don't actually own the original image, since it's in the public domain.

As with the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment, the images should be in the `ipfs/` directory in the Collab Resources tool. Note that you can upload a file into that folder, but once uploaded you can not edit it or delete it -- this is a setting in Collab, but was done to mirror the fact that you can't delete images from the Internet once they are placed on the web.  As it is in the Collab workspace, only those in the class can view those files -- but that means anybody in the class can view it.  All image file names should start with your userid and an underscore: `mst3k_foo.jpg`.  As long as it starts with your userid and an underscore, we don't really care what the rest of the file name is.  Only JPEG and PNG images, please.  Make the images interesting!

Not surprisingly, you will then need to create NFTs for each of your images in your deployed `NFTmanager` smart contract -- you are welcome to do that later as they are needed.


### Task 2: Create and deploy a Decentralized Auction smart contract

The contract you will be creating will allow for a decentralized auction for NFTs.  The intended flow is as follows:

- Anybody can create an auction -- this is via the `createAuction()` function, and involves setting the auction duration, reserve (minimum) price, and various other parameters.  This does not *start* the auction just yet, but configures all the information for it.
    - The person who started the auction is called the 'initiator'
    - There cannot be two *active* auctions of the same NFT going on at the same time -- the contract should check for this and revert in this case
- Once ownership of the NFT is transferred to the auction contract, the auction begins -- the length was specified in the previous step.
    - In the situation where somebody creates a second auction before their first auction has started (meaning calling `createAuction()` twice without transferring the NFT to the auction manager between the two calls), then the second call to `createAuction()` should revert
- Anybody can bid on the auction -- a bid is placed by transferring ether to the auction contract via a call to `placeBid()`, and specifying which auction it is for via a parameter to that function call
    - If the amount bid is less than the reserve price, then the bid still goes through -- however, this is not a winning bid, as described below
    - If the amount bid is less than or equal to the current maximum bid, then it fails via a `require()` or `revert()`
    - If the amount bid is (strictly) higher than the previously highest bid, then the sender is the new winning bidder; the previously highest winning bidder is refunded his/her ether
- Once we are past the auction end time, the auction can be closed via a call to `closeAuction()`
    - If there are no bids, then NFT ownership is transferred back to the initiator
    - If the highest bid is less than the reserve price, then that bidder is refunded his/her money, and the NFT is transferred back to the initiator
    - If the highest bid is equal to or greater than the reserve price, then the NFT is transferred to the winning bidder, and the ether (minus a percentage fee) is transferred to the initiator
    - Once closed, an auction cannot be re-opened, although a new auction with the same NFT later can be created
- The auction contract will keep a fee of 1% of the value of a *winning* bid
    - Any auction that does not succeed -- is canceled, no bids, or does not meet the reserve price -- does not collect a fee
    - Anybody can view the fees via the `fees()` function; the deployer of the auction smart contract, and ONLY that address, can and collect those fees via a call to `collectFees()`
- There are five events that must be emitted at the appropriate times; for each, the parameter is the auction ID:
    - `auctionCreateEvent()`: when `createAuction()` is successfully called
    - `auctionStartEvent()`: when the NFT is transferred to the smart contract and the auction starts (*NOT* when `createAuction()` is called)
    - `auctionCloseEvent()`: when `closeAuction()` is successfully called
    - `auctionCancelEvent()`: when `cancelAuction()` is successfully called
    - `higherBidEvent ()`: when a new (and higher) bid is placed on an NFT via `placebid()`

Formally the task is to develop an `Auctioneer` contract that implements the following `AuctionManager` interface below.  The provided [AuctionManager.sol](AuctionManager.sol.html) ([src](AuctionManager.sol)) file has more comments for this interface.


```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IERC721.sol";
import "./IERC721Receiver.sol";

interface AuctionManager is IERC165, IERC721Receiver {

    struct Auction {
        uint id;            // the auction id
        uint num_bids;      // how many bids have been placed
        string data;        // a text description of the auction or NFT data
        uint highestBid;    // the current highest bid
        uint reserve;       // the minimum bid allowed
        address winner;     // the current highest bidder
        address initiator;  // who started the auction
        address manager;    // the ERC721 contract address that holds the NFT
        uint tokenId;       // the token ID at that ERC721 manager
        uint endTime;       // when the auction will end
        bool active;        // if the auction is active
    }

    function num_auctions() external view returns (uint);

    function fees() external view returns (uint);

    function collectFees() external;

    function auctions(uint _id) external view returns (Auction memory);
    
    function createAuction(uint m, uint h, uint d, string memory _data, uint _reserve) external returns (uint);

    function cancelAuction(uint id);

    function closeAuction(uint _id) external;

    function placeBid(uint _id) payable external;

    function auctionTimeLeft(uint _id) external view returns (uint);


    event auctionCreateEvent(uint indexed _id);

    event auctionStartEvent(uint indexed _id);

    event auctionCloseEvent(uint indexed _id);

    event auctionCancelEvent(uint indexed _id);

    event higherBidEvent (uint indexed _id);
}
```

This interface is provided in the [AuctionManager.sol](AuctionManager.sol.html) ([src](AuctionManager.sol)) file.  This interface extends the [IERC165.sol](IERC165.sol.html) ([src](IERC165.sol)) interface, which requires the `supportsInterface()` function -- your Auctioneer class supports three interfaces (AuctionManager, IERC165, and IERC721Receiver).  

You will also need to use the [IERC721Metadata.sol](IERC721Metadata.sol.html) ([src](IERC721Metadata.sol)) interface (and thus the [IERC721.sol](IERC721.sol.html) ([src](IERC721.sol)) interface), as you will be calling methods on the NFT manager, which implements that interface.  For example, if you have saved an address of a NFT manager into an `addr` field, you call that contract and get it's name via `IERC721Metadata(addr).name()`.

 The `Auctioneer` contract will also need to extend the [IERC721Receiver.sol](IERC721Receiver.sol.html) ([src](IERC721Receiver.sol)) interface:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
```

The `onERC721Received()` function is called when an ERC721 token is transferred to the smart contract.  This was done in the [ERC721.sol](../tokens/ERC721.sol.html) ([src](../tokens/ERC721.sol)) code that your NFTmanager.sol file extended.  The `operator` parameter is the address which called the `safeTrasnferFrom()` function, and this can be ignored for this assignment; the `from` is the address which previously owned the token, the `tokenId` is the token number in that NFT manager, and you can ignore the `data` parameter (it's to send extra data if desired).  Note that in this function you can use `msg.sender` to get the address of the NFT manager.  It is by the call to this function that your Auctioneer knows an NFT has been transferred to it, and can start an auction.  If the owner of the NFT is unknown -- meaning that address has not called `createAuction()` -- then a reversion will cancel the entire NFT transfer.  This function needs to return a confirmation that it acknowledges the receipt of the NFT -- to do this, have the last line of your function return the [function selector](../../slides/tokens.html#/funcsel) for that function -- the line for that is: `return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));`.

To transfer ETH to another account, you can use code such as the following.  Note that the address is in variable `a`, and the value -- in wei -- is in `v`:

```
(bool success, ) = payable(a).call{value: v}("");
require(success, "Failed to transfer ETH");
```

As you are testing it, you will notice in Remix that the button for `placeBid()` is red -- that is because this is a `payable` function.  When you call this function, after setting the correct auction ID as the parameter, you will need to transfer some ETH along with the call.  In the deployment pane in Remix, just enter a numerical value in the 'Value' box, and select the right denomination (wei, gwei, ether, etc.).  That amount of ETH will be transferred along with the function call.  If the call reverts, then you get that money back (minus the fees).  If you have a mistake in your function code, you will likely lose that ETH -- this is why we are developing this on the Javascript deployment environment in Remix and then on a private blockchain where the ETH has no value.

Some people are having problems in Remix with determining the return value of a transaction -- if this is happening to you, you can create a function such as `getPendingAuctionID()` that, given an address, returns the pending (but not yet started) auction ID for that address.  We will not check for this function.

Test all this thoroughly in Remix!  You will need to deploy both your NFTManager contract and also your Auctioneer contract in Remix's Javascript environment to test them working together.  Recall that you have to select the right contract to deploy in the "Contract" list, else Remix may not know which one to deploy.  ***We are going to try to break your contract.***  So you will need to spend some time thinking about all the things that you should be checking for, and also testing it out as much as you can.

One it works, deploy it to our private Ethereum blockchain.  You should test it there as well.  You will need to submit the contract address and transaction hash of the deployed Auctioneer.  If you deploy it multiple times, just submit the most recent contract address.  Once it is deployed to our private Ethereum blockchain, you can view it on the auctions page, the URL of which is on the Collab landing page.  This web page will make it far easier to see what is going on with your auctions.


### Task 3: Populate a few auctions

You should create two auctions in your Auctioneer contract (you'll create a third one below as well).  It's fine if you create more (such as from testing) -- we will only look at the two requested here.  These two auctions will use two of your three NFT images.  In particular, if you have one NFT that you like more than the others, or is "better", you will want to save it for the course-wide auction, below.

Note that you can perform these calls through Remix (via calling an external contract, as described in the [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md)) assignment) or through geth calls (as described in the [Solidity slide set](../../slides/solidity.html#/debtor)).

#### Auction 1

The first one should be an auction that has ended by due date/time of the assignment.  Basically, we want it to be an expired auction.  There should be a few bids on this auction.  You can create multiple accounts for this -- just call `personal.newAccount()` a few more times -- each account is in the `eth.accounts` list, and you will have to unlock each one with `personal.unlockAccount()`.  To get ether into those other accounts you can:

- Transfer ETH to that account (see the [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md)) assignment for how to do that) 
- Mine to that account (set the mining destination account: `miner.setEtherbase(eth.accounts[1])` -- but be sure to change it back!)

You can also get classmates to bid on your auction.  This auction will use the first of your (three) NFTs.  The contract address for your NFTmanager will be submitted as part of the task 2 requirements, above.  You must also submit the auction ID for this auction as well as the NFT token ID.

You *SHOULD* call `closeAuction()` on this auction.

#### Auction 2

The second auction should end *two weeks* after the assignment is due.  Just get it on the day two weeks later -- we don't really care about the time, as long as the date is 14 days after the assignment due date.  Basically, we want to see an active auction.  This, also, should have a few bids on it.  This auction use the second of your (three) NFTs.  The contract address for your NFTmanager will be submitted as part of the task 2 requirements, above.  You must also submit the auction ID for this auction as well as the NFT token ID.


### Task 4: Participate in a class-wide auction manager

We have deployed an auction manager, and the contract address for that Auctioneer contract is on the Collab landing page.  As above, you can perform these calls through Remix (via calling an external contract, as described in the [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md)) assignment) or through geth calls (as described in the [Solidity slide set](../../slides/solidity.html#/)).

You should use the third of your (three) NFTs.  You must use ***YOUR*** NFTmanager.  You should create an auction that ends *one week* after the due date of the assignment (again, we are looking for the day -- we don't care too much about the time of day).  You will need to submit the transaction hash from when you call `createAuction()`, as well as the auction ID from the auction you created as well as the NFT token ID.  ***YOUR RESERVE*** should be no higher than 5 ETH.

Lastly, bid on at least *three* auctions that are not your own.  Depending on when you submit your assignment, there may not be any (or any interesting) auctions available to bid on.  That's fine -- you don't have to have those bids completed by the time the assignment is due; you have an extra few days to place your bids.  We are going to judge lateness on this assignment by the Gradescope submission time, and the Google form does not ask for the transaction hashes of the bids.  We are going to check whether you bid on the auctions by looking if your `eth.coinbase` account, the address of which you will submit below, initiated bids on any one of your classmate's submitted NFT manager addresses by a few days after the due date.  Note that you have to place the bid via Remix or geth; the course website just displays the auctions.

**MAKE YOUR BIDS REASONABLE!!!**  If the current highest bid is 0.5 ETH, don't suddenly bid 5,000 ETH.  Doing so is going to require others who need to bid on that NFT to have to mine a lot more ETH, which will increase the blockchain size and the difficulty, which will make it harder for everybody else in the class.  This will make me very cranky.  Any successive bid should be no more than about 1 ETH more than the previous bid.


### Submission

There are *three* forms of submission for this assignment; you must do all three.

Submission 1: You should submit your `Auctioneer.sol` file, and ONLY that file, to Gradescope.  All your code should be in that file, and you should specifically import the various interfaces.  Those interface files will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, etc.).

Submission 2: You must deploy those two smart contracts (`NFTmanager` and `Auctioneer`) to our private Ethereum blockchain.  It's fine if you deploy it a few times to test it.  But the final deployment for the `Auctioneer` should only have the data specified in task 3, above.  It's also fine if you use your `NFTmanager` from a previous assignment.  Save the contract addresses and transaction hash of these deployments, as you will need to submit them below.

Submission 3: You will need to submit your information via a Google form, the link to which is on the Collab landing page. You will need to submit the following items:

- Your name & UVA userid
- Your account number from `eth.coinbase`. The assumption is that you did your tasks from this account (deployed your contract, the votes, etc.); if you did it from a different account, submit that account address instead.
- From task 1 (NFT images):
  - The contract address and transaction hash of your deployed NFTmanager contract (this may be the same as in the [Ethereum Tokens](../tokens/index.html) ([md](../tokens/index.md)) assignment)
- From task 2 (Auctioneer): the contract address and transaction hash of your deployed smart contract
- From task 3 (your auctions): the auction ID for the two auctions (the contract address for the Auctioneer contract is assumed to be the one from task 2)
- From task 4 (class auctions):
  - The auction ID of the auction you created
  - The transaction hash for each of the three transactions where you bid on another auction
