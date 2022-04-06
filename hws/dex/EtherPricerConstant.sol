// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./EtherPricer.sol";

contract EtherPricerConstant is EtherPricer {

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return
            interfaceId == type(EtherPricer).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    function getEtherPriceInCents() external pure override returns (uint) {
    	return 10000; // $100 in cents
    }

}