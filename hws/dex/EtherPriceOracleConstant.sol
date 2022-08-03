// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IEtherPriceOracle.sol";

contract EtherPricerConstant is IEtherPriceOracle {

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return
            interfaceId == type(IEtherPriceOracle).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    function getEtherPriceInCents() external pure override returns (uint) {
    	return 10000; // $100 in cents
    }

}