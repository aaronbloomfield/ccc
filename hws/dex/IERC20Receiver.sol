// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

/**
 * @title ERC20 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC20 asset contracts.  Based on the IERC721Receiver code.
 */
interface IERC20Receiver {
    /**
     * @dev Whenever an {IERC20} amount is transferred to this contract from `from`, this function is called.
     *
     * It must return true to confirm the token transfer.
     * If false is returned the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC20Receiver.onERC20Received.selector`.
     */
    function onERC20Received(address from, uint amount, address erc20) external returns (bool);
}

/* to use this code, put the following in your ERC-20 implementation:

    function _afterTokenTransfer(address from, address to, uint256 amount) internal override {
        if ( to.code.length > 0  && from != address(0) && to != address(0) ) {
            // token recipient is a contract, notify them
            try IERC20Receiver(to).onERC20Received(from, amount, address(this)) returns (bool success) {
                require(success,"ERC-20 receipt rejected by destination of transfer");
            } catch {
                // the notification failed (maybe they don't implement the `IERC20Receiver` interface?)
                // we choose to ignore this case
            }
        }
    }

*/
