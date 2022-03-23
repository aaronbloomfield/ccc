// SPDX-License-Identifier: ...
pragma solidity ^0.8.7;

import "./IERC20.sol";

interface IERC20full is IERC20 {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    // this must implement the 6 functions from IERC20

}
