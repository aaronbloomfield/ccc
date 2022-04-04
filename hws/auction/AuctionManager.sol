// SPDX-License-Identifier: GPL
pragma solidity ^0.8.7;

import "./IERC721.sol";
import "./IERC721Receiver.sol";

// Some general notes:
//
// - All monetary values passed in as parameters to the functions below are in
//   gwei; note that msg.value is in wei, so it will have to be divided by
//   10**9 to get the amount in gwei
// - Beyond what is listed below, there are two other methods to implement,
//   based on the interfaces that this interface implements:
//   supportsInterface()(from IERC165) and onERC721Received()
//   (from IERC721Receiver).
// - the onERC721Received() should do a whole bunch of checks, most of which
//   are left for you to decide.  But it shoudl also check that the given URI
//   is not already in an active auction.
// - The parameters for onERC721Received() are:
//   - operator: the address which called the `safeTrasnferFrom()` function;
//     this can be ignored for this assignment
//   - from: the address which previously owned the token
//   - tokenId: the NFT identifier being transfered
//   - data: additional data with no specified format; this can be ignored for
//     this assignment
// - There are four possible states for (endTime,active): 
//   - (0,false) is when the auction has ended
//   - (0,true) should never occur
//   - (> 0, false) is when endTime is the duration, and it's waiting the NFT
//     receipt
//   - (> 0, true) is when the auction is active


interface AuctionManager is IERC165, IERC721Receiver {

    // Holds the information for each auction
    struct Auction {
        uint id;            // the auction id
        uint num_bids;      // how many bids have been placed
        string data;        // a text description of the auction or NFT data
        uint highestBid;    // the current highest bid
        uint reserve;       // the minimum bid that can win
        address winner;     // the current highest bidder
        address initiator;  // who started the auction
        address manager;    // the ERC721 contract address that holds the NFT
        uint tokenId;       // the token ID at that ERC721 manager
        uint endTime;       // when the auction will end
        bool active;        // if the auction is active
    }

    // How many auctions have been created; those auction IDs are 1 to n(NOT 0
    // to n-1), where n is the value returned; this can just be via the
    // getter method from a public variable.
    function num_auctions() external view returns (uint);

    // How much fees, in gwei, have been collected so far -- the auction
    // collects 1% fees of *successful* auctions
    function fees() external view returns (uint);

    // The deployer of the contract, and ONLY that address, can collect the
    // fees that this auction contract has accumulated; a call to this by any
    // other address should revert.  This causes the fees to be paid to the
    // deployer.
    function collectFees() external;

    // Gets the auction struct for the passed acution id.
    function auctions(uint _id) external view returns (Auction memory);
    
    // This sets the data for the auction, but the auction time doesn't start
    // until the ERC-721 contract is trasnferred over.  The first three
    // parameters are the number of minutes, hours, and days for the auction
    // to last -- they can't all be zero.  The data parameter is a textual
    // description of the auction, NOT the file name.  The reserve is the
    // minimum price that will win the auction; this amount is in gwei
    // (which is 10^-9 eth). This returns the auction ID of the newly
    // configured auction.
    function createAuction(uint m, uint h, uint d, string memory _data, uint _reserve) 
                    external returns (uint);

    // This cancels an auction, the id of which is passed in as a parameter,
    // that has been created but that the NFT has not yet be transferred over
    // for.  Only the creator of an auction can cancel that auction.
    function cancelAuction(uint id) external;

    // This closes out the auction, the ID of which is passed in as a
    // parameter, but is only valid after the auction end time.  It will
    // handle the transfer of the ETH (if any bids were placed) and the NFT.
    // Note that anybody can call this function, although it will only close
    // auctions whose time has expired.
    function closeAuction(uint _id) external;

    // When one wants to submit a bid on a NFT; the ID of the auction is
    // passed in as a parameter, and some amount of ETH is transferred with
    // this function call.  If a bid is attempted to be placed on an inactive
    // auction or after the close time, then this function should revert.
    function placeBid(uint _id) payable external;

    // The time left (in seconds) for the given auction, the ID of which is
    // passed in as a parameter.
    function auctionTimeLeft(uint _id) external view returns (uint);

    // This is emitted when an auction is configured in createAuction(); the
    // ID is the auction ID.
    event auctionCreateEvent(uint indexed _id);

    // This is emitted when an auction starts (meaning when the NFT is
    // transfered); the ID is the auction ID.  It's emitted by the
    // onERC721Received() function.
    event auctionStartEvent(uint indexed _id);

    // This is emitted when an auction ends in closeAuction(); the ID is the
    // auction ID.
    event auctionCloseEvent(uint indexed _id);

    // This is emitted when an auction is canceled in cancelAuction(); the ID
    // is the auction ID.
    event auctionCancelEvent(uint indexed _id);

    // This is emitted when a new bid is placed that is higher than the
    // existing highest bid; the ID is the auction ID.
    event higherBidEvent (uint indexed _id);

}
