// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.21;

import "./IERC721Metadata.sol";
import "./IERC165.sol";

interface INFTManager is IERC721Metadata {

    // This creates a NFT for `_to` with the pased file name `_uri`.  Note
    // that `_uri` is just the filename itself -- the prefix is set via
    // overriding _baseURI()
    function mintWithURI(address _to, string memory _uri) external returns (uint);

    // This also creates a NFT, but assumes `msg.sender` is who the NFT is
    // for; it can just call the previous function.
    function mintWithURI(string memory _uri) external returns (uint);

    // This is just a count of how many NFTs have been minted with this
    // manager; it can be a public variable.
    function count() external view returns (uint);

    // Additional functions to implement / override:
    // supportsInterface(): for the interfaces specified in the HW writeup
    // _baseURI(): the part of the full path name before the filename itself
    // tokenURI(): get the file name (with _baseURI() before it) for the passed NFT ID

}