// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./IAuctioneer.sol";


interface IAuctioneer2 is IAuctioneer {

    // This just calls the mintWithURI() function on the resident nftmanager
    // contract.
    function mintNFT(string memory _uri) external returns (uint);

}
