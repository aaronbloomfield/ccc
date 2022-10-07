// SPDX-License-Identifier: ...

pragma solidity ^0.8.16;

import "./IERC721Metadata.sol";

interface IERC721full is IERC721Metadata {

    function mintWithURI(address _to, string memory _uri) external returns (uint);

    // implementing contracts have to implement the one function from IERC165
    // (supportsInterface())

    // implementing contracts have to implement the 6 functions and 2 events
    // from IERC721

    // implementing contracts have to implement the 3 functions from
    // IERC721Metadata

}
