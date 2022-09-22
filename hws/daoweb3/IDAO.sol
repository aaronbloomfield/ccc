// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

// This file is heavily adapted from the DAO interface at
// https://github.com/blockchainsllc/DAO/blob/develop/DAO.sol

interface IDAO {

    //------------------------------------------------------------
    // These are all just variables; some of which are set in the constructor
    // and never changed

    // The minimum debate period that a generic proposal can have, in seconds;
    // this can be set to any reasonable for testing, but should be set to 10
    // minutes (600 seconds) for final submission.  This can be a constant.
    function minProposalDebatePeriod() external returns (uint);

    // NFT token contract address
    function tokens() external returns (address);

    // A string indciating the purpose of this DAO -- be creative!  This can
    // be a constant.
    function purpose() external returns (string memory);

    // Simple mapping to check if a shareholder has voted for it
    function votedYes(address a, uint pid) external returns (bool);

    // Simple mapping to check if a shareholder has voted against it
    function votedNo(address a, uint pid) external returns (bool);

    // The total number of proposals ever created
    function numberOfProposals() external returns (uint);

    // This is the amount of ether that has been reserved for proposals.  This
    // is increased by the proposal amount when a new proposal is created,
    // thus "reserving" those ether from being spent on another proposal
    // while this one is still being voted upon.  If a proposal succeeds,
    // then the proposal amount is paid out.  In either case, once the voting
    // period for the proposal ends, this amount is reduced by the proposal
    // amount.
    function reservedEther() external returns (uint);

    //------------------------------------------------------------
    // A struct to hold all of our proposal data

    struct Proposal {
        address recipient;      // The address where the `amount` will go to if the proposal is accepted
        uint amount;            // The amount to transfer to `recipient` if the proposal is accepted.
        string description;     // The amount to transfer to `recipient` if the proposal is accepted.
        uint votingDeadline;    // A unix timestamp, denoting the end of the voting period        
        bool open;              // True if the proposal's votes have yet to be counted, otherwise False
        bool proposalPassed;    // True if the votes have been counted, and the majority said yes
        uint yea;               // Number of Tokens in favor of the proposal; updated upon each yea vote
        uint nay;               // Number of Tokens opposed to the proposal; updated upon each nay vote
        address creator;        // Address of the shareholder who created the proposal
    }

    //------------------------------------------------------------
    // Functions to implement

    // Obtain a given proposal; this will have to be a separate function,
    // rather than a getter for public mapping, due to the difference in
    // public getter return types (Proposal memory versus Proposal storage)
    // @param i The proposal ID to obtain
    // @return The proposal for that ID
    function proposals(uint i) external returns (Proposal memory);

    // This allows the function to receive ether without having a payable
    // function -- it doesn't have to have any code in its body, but it does
    // have to be present.
    receive() external payable;

    // `msg.sender` creates a proposal to send `_amount` Wei to `_recipient`
    // with the transaction data `_transactionData`.  This can only be called
    // by a member of the DAO, and should revert otherwise.
    // @param _recipient Address of the recipient of the proposed transaction
    // @param _amount Amount of wei to be sent with the proposed transaction
    // @param _description String describing the proposal
    // @param _debatingPeriod Time used for debating a proposal, at least
    //  `minProposalDebatePeriod()` seconds long
    // @return The proposal ID
    function newProposal(address _recipient, uint _amount, string memory _description, 
                          uint _debatingPeriod) external payable returns (uint);

    // Vote on proposal `_proposalID` with `_supportsProposal`.  This can only
    // be called by a member of the DAO, and should revert otherwise.
    // @param _proposalID The proposal ID
    // @param _supportsProposal true/false as to whether in support of the
    //  proposal
    function vote(uint _proposalID, bool _supportsProposal) external;

    // Checks whether proposal `_proposalID` with transaction data
    // `_transactionData` has been voted for or rejected, and transfers the
    // ETH in the case it has been voted for.  This can only be called by a
    // member of the DAO, and should revert otherwise.
    // @param _proposalID The proposal ID
    // @return Whether the proposed transaction has been executed or not
    function executeProposal(uint _proposalID) external returns (bool);

    // Adds the passed member.  Any current member of the DAO can add members.
    // Membership is indicated by an NFT token, so one must be transfered to
    // this member as part of this call.  This can only be called by a member
    // of the DAO, and should revert otherwise.
    // @param _who The new member to add
    function addMember(address _who) external;

    //------------------------------------------------------------
    // Events to emit

    // Called whenever newProposal() successfully completes
    // @param proposalID The proposal ID that was just created
    // @param recipient The recipient address that will receive the ether if
    //  the proposal is successful
    // @param amount The amount of wei that the recipient will receive
    // @param description A short textual description of the proposal
    event ProposalAdded(uint indexed proposalID, address recipient, uint amount, string description);

    // Called whenever a proposal is voted upon
    // @param proposalID Which proposal was voted upon
    // @param position Whether they were in support of the proposal or not
    // @param voter Who voted
    event Voted(uint indexed proposalID, bool position, address indexed voter);

    // Called whenever a proposal is successfully closed via `executeProposal()`
    // @param proposalID The proposal that was closed
    // @param result Whether the proposal was successful or not
    event ProposalTallied(uint indexed proposalID, bool result);
}
