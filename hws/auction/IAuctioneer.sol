// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.7;

import "./IERC721.sol";

// Some general notes:
//
// - All monetary values passed in as parameters to the functions below are in
//   wei
// - Beyond what is listed below, there is one other method to implement,
//   based on the interfaces that this interface implements:
//   supportsInterface() (from IERC165)


interface IAuctioneer is IERC165 {

    // Holds the information for each auction
    struct Auction {
        uint id;            // the auction id
        uint num_bids;      // how many bids have been placed
        string data;        // a text description of the auction or NFT data
        uint highestBid;    // the current highest bid, in wei
        uint reserve;       // the minimum bid that can win, in wei
        address winner;     // the current highest bidder
        address initiator;  // who started the auction
        uint tokenId;       // the NFT token ID
        uint endTime;       // when the auction will end
        bool active;        // if the auction is active
        bool fixedTime;     // if the end time is from the start time or last bid
    }


    // Constructor: while constructors are never listed in an interface, your
    // contract should have one.  Among other things, it needs to create and
    // deploy it's own NFT Manager.


    // The following can just be the automatically created getter functions
    // from public variables

    // The address of the NFT Manager for this Auctioneer; it is mean to be
    // created and deployed when the Auctioneer constructor is called.  This
    // can just be via the getter method from a public variable.
    function nftmanager() external view returns (address);

    // How many auctions have been created; those auction IDs are 1 to n(NOT 0
    // to n-1), where n is the value returned; this can just be via the
    // getter method from a public variable.
    function num_auctions() external view returns (uint);

    // How much fees, in wei, have been collected so far -- the auction
    // collects 1% fees of *successful* auctions
    function totalFees() external view returns (uint);

    // How much fees, in wei, have been collected so far but not yet paid to
    // the deployer -- the auction collects 1% fees of *successful* auctions
    function unpaidFees() external view returns (uint);


    // The following are functions you must create

    // Gets the auction struct for the passed acution id.  This can not be the
    // getter method of a public variable because the public variable is
    // going to be of type `Auction storage`, whereas the required return
    // type is `Auction memory`, and Solidity can't automatically convert
    // between the two.
    function auctions(uint _id) external view returns (Auction memory);
    
    // The deployer of the contract, and ONLY that address, can collect the
    // fees that this auction contract has accumulated; a call to this by any
    // other address should revert.  This causes the fees to be paid to the
    // deployer.
    function collectFees() external;

    // This sets the data for the auction, but the auction time doesn't start
    // until the ERC-721 contract is trasnferred over.  The first three
    // parameters are the number of minutes, hours, and days for the auction
    // to last -- they can't all be zero.  The data parameter is a textual
    // description of the auction, NOT the file name.  The reserve is the
    // minimum price that will win the auction; this amount is in wei
    // (which is 10^-18 eth). The fixedTime parameter is whether the end
    // time (of m,h,d) is from the start time of the auction (if True) or
    // from the last bid (if False).  This returns the auction ID of the
    // newly configured auction.
    function startAuction(uint m, uint h, uint d, string memory _data, 
                          uint _reserve, bool _fixedTime) external returns (uint);

    // This closes out the auction, the ID of which is passed in as a
    // parameter, but is only valid after the auction end time.  It will
    // handle the transfer of the ETH (if any bids were placed) and the NFT.
    // Note that anybody can call this function, although it will only close
    // auctions whose time has expired.
    function closeAuction(uint _id) external;

    // When one wants to submit a bid on a NFT; the ID of the auction is
    // passed in as a parameter, and some amount of ETH is transferred with
    // this function call.  See the homework description for various cases
    // where this function should revert.
    function placeBid(uint _id) payable external;

    // The time left (in seconds) for the given auction, the ID of which is
    // passed in as a parameter.
    function auctionTimeLeft(uint _id) external view returns (uint);


    // The following are the events that need to be emitted at the appropriate
    // times, as per the homework description.

    // This is emitted when an auction is started in startAuction(); the
    // ID is the auction ID.
    event auctionCreateEvent(uint indexed _id);

    // This is emitted when an auction ends in closeAuction(); the ID is the
    // auction ID.
    event auctionCloseEvent(uint indexed _id);

    // This is emitted when a new bid is placed that is higher than the
    // existing highest bid; the ID is the auction ID.
    event higherBidEvent (uint indexed _id);

}
