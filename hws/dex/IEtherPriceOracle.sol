// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IERC165.sol";

interface IEtherPriceOracle is IERC165 {

	function getEtherPriceInCents() external view returns (uint);

}
