Solidity Reference
==================

[Go up to the main CCC docs page](index.html) ([md](index.md))


This document is meant to be a series of reminders about Solidity programming tasks, all in one place.


### SPDX license line

The first line of your program, it might look like:

```
// SPDX-License-Identifier: Unlicensed
```

The fill list can be found [here](https://spdx.org/licenses/).  For this class, you can use any one you want.  A few examples:

- `Unlicensed`: there is no attached license.  This will silence the SPDX missing warning.
- `GPL` or `GPL-3.0-only` or `GPL-3.0-or-later`: the [GNU Public License](https://spdx.org/licenses/GPL-3.0-or-later.html) which means that anybody who uses that code must release it under a similar license (which, in practice, is pretty much always the GPL); this generally prevents commercial usage unless they publicly release their code
- `MIT`: the [MIT license](https://spdx.org/licenses/MIT.html) which means anybody can use this code, personal or commercial, for any reason, and they do not have to release their derived code


### Paying from a contract

```
(bool success, ) = payable(a).call{value: v}("");
require(success, "Failed to transfer ETH");
```


### Getting the balance of a contract

This only pertains to the spring 2022 semester; outside that semester, just call `address(this).balance`.

Having a contract get it's own balance should be easy -- just `address(this).balance`.  But for the spring 2022 semester, that is not working due to a misconfiguration in how the blockchain was setup -- it complains about `SELFBALANCE` being an unknown opcode.  So we need a work-around: a contract has to ask something *else* to get it's own balance.  

Consider this contract:

```
// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.16;
contract GetBalance {
    function getBalance(address a) public view returns (uint) {
        return a.balance;
    }
}
```

Once deployed, you can call the `getBalance()` method to get one's own balance.  This is deployed at address `0x1E2c5E21c3b9cFD67bedF28e04fDd295AecbC500` <span class="copylink" onclick="navigator.clipboard.writeText('0x1E2c5E21c3b9cFD67bedF28e04fDd295AecbC500')">&#x2398;</span> on the course blockchain.

If you need to be able to switch between this code on the course blockchain, and Remix (in which you can just call `address(this).balance`), you can use the following method:

```
// This is SUCH AND UGLY HACK, but it will work for the spring 2022 semester
function getSelfBalance() public view returns (uint) {
    if ( block.number > 70000 )
        return GetBalance(0x1E2c5E21c3b9cFD67bedF28e04fDd295AecbC500).getBalance(address(this));
    else
        return address(this).balance;
}
```
