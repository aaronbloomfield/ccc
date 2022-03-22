// SPDX-License-Identifier: ...
pragma solidity ^0.8.7;

import "./IERC20.sol";

interface IERC20full is IERC20 {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    // this inherits the one function from IERC165 (supportsInterface())

    // this inherits the 6 functions and 2 events from IERC20

}
