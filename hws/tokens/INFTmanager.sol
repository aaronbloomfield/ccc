// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

import "./ERC721.sol";

abstract contract INFTmanager is ERC721 {

    // This creates a NFT for `_to` with the pased file name `_uri`.  Note
    // that `_uri` is just the filename itself -- the prefix is set via
    // overriding _baseURI()
    function mintWithURI(address _to, string memory _uri) external virtual returns (uint);

    // This also creates a NFT, but assumes `msg.sender` is who the NFT is
    // for; it can just call the previous function.
    function mintWithURI(string memory _uri) external virtual returns (uint);

    // Functions to implement / override:
    // supportsInterface(): for the interfaces specified in the HW writeup
    // _baseURI(): the part of the full path name before the filename itself
    // tokenURI(): get the file name (with _baseURI() before it) for the passed NFT ID

}