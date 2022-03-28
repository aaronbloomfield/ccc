// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IERC721.sol";
import "./IERC721Receiver.sol";

interface AuctionManager is IERC165, IERC721Receiver {

    // holds the information for each auction
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

    // There are four possible states for (endTime,active): 
    // - (0,false) is when the auction has ended
    // - (0,true) should never occur
    // - (> 0, false) is when endTime is the duration, and it's waiting the NFT receipt
    // - (> 0, true) is when the auction is active

    // how many auctions have been created; those auction IDs are 0 to n-1,
    // where n is the value returned; this can just be via the getter method
    // from a public variable
    function num_auctions() external view returns (uint);

    // gets the ID of any auction that is active with the provided data string
    function active_auction(string memory data) external view returns (uint);

    // gets the auction struct for the given acution; this can just be via the
    // getter method from a public mapping
    function auctions(uint _id) external view returns (Auction memory);
    
    // this sets the data for the auction, but the auction time doesn't start
    // until the ERC-721 contract is trasnferred over
    function createAuction(uint m, uint h, uint d, string memory _data, uint _reserve) external returns (uint);

    // this gets the ID of a pending auction; meaning one that has had
    // createAuction() called, but the NFT has not yet been transferred over.
    // It returns 0 (not revert!) if there is no pending auction for that address
    function getPendingAuctionID(address) external view returns (uint);

    // cancel an auction that has been created but that the NFT has not yet be
    // transferred over for
    function cancelAuction(uint id) external;

    // this finishes the auction, but is only valid after the auction end
    // time
    function closeAuction(uint _id) external;

    // when one wants to submit a bid on a NFT
    function placeBid(uint _id) payable external;

    // the time left (in seconds) for the given auction; this can just be via
    // the getter method from a public mapping
    function auctionTimeLeft(uint _id) external view returns (uint);

    // when an auction starts (meaning when the NFT is transfered); the ID is
    // the auction ID
    event auctionStartEvent(uint indexed _id);

    // when an auction ends (in closeAuction() but not cancelAuction()); the
    // ID is the auction ID
    event auctionEndEvent(uint indexed _id);

    // when a new bid is placed that is higher than the existing highest bid;
    // the ID is the auction ID
    event higherBidEvent (uint indexed _id);

}
