// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.21;

import "./IERC165.sol";

// Some general notes:
//
// - All monetary values passed in as parameters to the functions below are
//   in wei
// - Beyond what is listed below, there is one other method to implement,
//   based on the interfaces that this interface implements:
//   supportsInterface() (from IERC165)
// - See the "Notes and Hints" section of the HW description for more such 
//   notes


interface IAuctioneer is IERC165 {

    // Holds the information for each auction
    struct Auction {
        uint id;            // the auction id
        uint num_bids;      // how many bids have been placed
        string data;        // a text description of the auction or NFT data
        uint highestBid;    // the current highest bid, in wei
        address winner;     // the current highest bidder
        address initiator;  // who started the auction
        uint nftid;         // the NFT token ID
        uint endTime;       // when the auction ends
        bool active;        // if the auction is active
    }


    // Constructor: while constructors are never listed in an interface, your
    // contract should have one.  Among other things, it needs to create and
    // deploy it's own NFT Manager.


    // The following can just be the automatically created getter functions
    // from public variables

    // The address of the NFT Manager for this Auctioneer; it is meant to be
    // created and deployed when the Auctioneer constructor is called.  This
    // can just be via the getter method from a public variable.
    function nftmanager() external view returns (address);

    // How many auctions have been created on this Auctioneer contract; this
    // can just be via the getter method from a public variable.
    function num_auctions() external view returns (uint);

    // How much fees, in wei, have been collected so far -- the auction
    // collects 1% fees of *successful* auctions; these are the total fees
    // that have been collected, whether paid to the deployer of the contract
    // or not.
    function totalFees() external view returns (uint);

    // How much fees, in wei, have been collected so far but not yet paid to
    // the deployer -- the auction collects 1% fees of *successful* auctions
    function uncollectedFees() external view returns (uint);

    // Gets the auction struct for the passed auction id.  If one lists out
    // the individual fields of the Auction struct, then one can just have
    // this be a public mapping (otherwise you run into problems
    // with "Auction memory" versus "Auction storage")
    function auctions(uint id) external view
            returns (uint, uint, string memory, uint, address, address, uint, uint, bool);

    // Who is the deployer of this contract
    function deployer() external view returns (address);


    // The following are functions you must create

    // Anybody can call this function, but it only pays, to the deployer, the
    // fees that this auction contract has accumulated (either since inception
    // or since the last time collectFees() was called).
    function collectFees() external;

    // Start an auction.  The first three parameters are the number of
    // minutes, hours, and days for the auction to last -- they can't all be
    // zero.  The data parameter is a textual description of the auction, NOT
    // the file name; it can't be the empty string.  The reserve is the
    // minimum price that will win the auction; this amount is in wei
    // (which is 10^-18 eth), and can be zero.  The nftid is which NFT is
    // being auctioned.  This function has four things it must do: sanity
    // checks (verify valid parameters, ensure no auction with that NFT ID is
    // running), transfer the NFT over to this contract (revert if it can't),
    // create the Auction struct (which effectively starts the auction), and
    // emit the appropriate event. This returns the auction ID of the newly
    // configured auction.  These auction IDs have to start from 0 for the
    // auctions.php web page to work properly.  Note that only the owner of a
    // NFT can start an auction for it, and this should be checked via
    // require().
    function startAuction(uint m, uint h, uint d, string memory data, 
                          uint reserve, uint nftid) external returns (uint);

    // This closes out the auction, the ID of which is passed in as a
    // parameter.  It first does the basic sanity checks (you have to figure
    // out what).  If bids were placed, then it will transfer the ether to
    // the initiator.  It will handle the transfer of the  NFT (to the
    // initiator if no bids were placed or to the winner if bids were placed)
    // In the latter case, it keeps 1% fees and emits the appropriate event.
    // The auction is marked as inactive. Note that anybody can call this
    // function, although it will only close auctions whose time has
    // expired.
    function closeAuction(uint id) external;

    // When one wants to submit a bid on a NFT; the ID of the auction is
    // passed in as a parameter, and some amount of ETH is transferred with
    // this function call.  So many sanity checks here!  See the homework
    // description some of various cases where this function should revert;
    // you get to figure out the rest.  On a successful higher bid, it should
    // update the auction struct.  Be sure to refund the previous higher
    // bidder, since they have now been outbid.
    function placeBid(uint id) payable external;

    // The time left (in seconds) for the given auction, the ID of which is
    // passed in as a parameter.  This is a convenience function, since it's
    // much easier to call this rather than get the end time as a UNIX
    // timestamp.
    function auctionTimeLeft(uint id) external view returns (uint);


    // The following are the events that need to be emitted at the appropriate
    // times, as per the homework description.

    // This is emitted when an auction is started in startAuction(); the
    // ID is the auction ID.
    event auctionStartEvent(uint indexed id);

    // This is emitted when an auction ends in closeAuction(); the ID is the
    // auction ID.
    event auctionCloseEvent(uint indexed id);

    // This is emitted when a new bid is placed that is higher than the
    // existing highest bid; the ID is the auction ID.
    event higherBidEvent (uint indexed id);

}
