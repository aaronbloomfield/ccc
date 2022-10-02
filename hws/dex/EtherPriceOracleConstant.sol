// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./IEtherPriceOracle.sol";

contract EtherPricerConstant is IEtherPriceOracle {

    string public constant purpose = "A constant EtherPrice oracle that always returns $100.00";

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return
            interfaceId == type(IEtherPriceOracle).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    function getEtherPriceInCents() external pure override returns (uint) {
    	return 10000; // $100 in cents
    }

}