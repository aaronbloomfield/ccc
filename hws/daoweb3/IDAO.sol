// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

import "./IERC165.sol";

pragma solidity ^0.8.16;

// This file is heavily adapted from the DAO interface at
// https://github.com/blockchainsllc/DAO/blob/develop/DAO.sol

interface IDAO is IERC165 {

    //------------------------------------------------------------
    // A struct to hold all of our proposal data

    struct Proposal {
        address recipient;      // The address where the `amount` will go to if the proposal is accepted
        uint amount;            // The amount to transfer to `recipient` if the proposal is accepted.
        string description;     // The amount to transfer to `recipient` if the proposal is accepted.
        uint votingDeadline;    // A UNIX timestamp, denoting the end of the voting period
        bool open;              // True if the proposal's votes have yet to be counted, otherwise False
        bool proposalPassed;    // True if the votes have been counted, and the majority said yes
        uint yea;               // Number of Tokens in favor of the proposal; updated upon each yea vote
        uint nay;               // Number of Tokens opposed to the proposal; updated upon each nay vote
        address creator;        // Address of the shareholder who created the proposal
    }

    //------------------------------------------------------------
    // These are all just public variables; some of which are set in the
    // constructor and never changed

    // Obtain a given proposal.   If one lists out the individual fields of
    // the Proposal struct, then one can just have this be a public mapping
    // (otherwise you run into problems with "Proposal memory"
    // versus "Proposal storage"
    //
    // @param i The proposal ID to obtain
    // @return The proposal for that ID
    function proposals(uint i) external view returns (address,uint,string memory,uint,bool,bool,uint,uint,address);

    // The minimum debate period that a generic proposal can have, in seconds;
    // this can be set to any reasonable for testing, but should be set to 10
    // minutes (600 seconds) for final submission.  This can be a constant.
    //
    // @return The minimum debating period in seconds
    function minProposalDebatePeriod() external view returns (uint);

    // NFT token contract address
    //
    // @return The contract address of the NFTManager (ERC-721 contract)
    function tokens() external view returns (address);

    // A string indicating the purpose of this DAO -- be creative!  This can
    // be a constant.
    //
    // @return A string describing the purpose of this DAO
    function purpose() external view returns (string memory);

    // Simple mapping to check if a shareholder has voted for it
    //
    // @param a The address of a member who voted
    // @param pid The proposal ID of a proposal
    // @return Whether the passed member voted yes for the passed proposal
    function votedYes(address a, uint pid) external view returns (bool);

    // Simple mapping to check if a shareholder has voted against it
    //
    // @param a The address of a member who voted
    // @param pid The proposal ID of a proposal
    // @return Whether the passed member voted no for the passed proposal
    function votedNo(address a, uint pid) external view returns (bool);

    // The total number of proposals ever created
    //
    // @return The total number of proposals ever created
    function numberOfProposals() external view returns (uint);

    // A string that states how one joins the DAO -- perhaps contacting the
    // deployer, perhaps some other secret means.  Make this something
    // creative!
    //
    // @return A description of what one has to do to join this DAO
    function howToJoin() external view returns (string memory);

    // This is the amount of ether (in wei) that has been reserved for
    // proposals.  This is increased by the proposal amount when a new
    // proposal is created, thus "reserving" those ether from being spent on
    // another proposal while this one is still being voted upon.  If a
    // proposal succeeds, then the proposal amount is paid out.  In either
    // case, once the voting period for the proposal ends, this amount is
    // reduced by the proposal amount.
    //
    // @return The amount of ether, in wei, reserved for proposals
    function reservedEther() external view returns (uint);

    // Who is the curator (owner / deployer) of this contract?
    //
    // @return The curator (deployer) of this contract
    function curator() external view returns (address);

    //------------------------------------------------------------
    // Functions to implement

    // This allows the function to receive ether without having a payable
    // function -- it doesn't have to have any code in its body, but it does
    // have to be present.
    receive() external payable;

    // `msg.sender` creates a proposal to send `_amount` Wei to `_recipient`
    // with the transaction data `_transactionData`.  This can only be called
    // by a member of the DAO, and should revert otherwise.
    //
    // @param recipient Address of the recipient of the proposed transaction
    // @param amount Amount of wei to be sent with the proposed transaction
    // @param description String describing the proposal
    // @param debatingPeriod Time used for debating a proposal, at least
    //        `minProposalDebatePeriod()` seconds long.  Note that the 
    //        provided parameter can *equal* the `minProposalDebatePeriod()` 
    //        as well.
    // @return The proposal ID
    function newProposal(address recipient, uint amount, string memory description, 
                          uint debatingPeriod) external payable returns (uint);

    // Vote on proposal `_proposalID` with `_supportsProposal`.  This can only
    // be called by a member of the DAO, and should revert otherwise.
    //
    // @param proposalID The proposal ID
    // @param supportsProposal true/false as to whether in support of the
    //        proposal
    function vote(uint proposalID, bool supportsProposal) external;

    // Checks whether proposal `_proposalID` with transaction data
    // `_transactionData` has been voted for or rejected, and transfers the
    // ETH in the case it has been voted for.  This can only be called by a
    // member of the DAO, and should revert otherwise.  It also reverts if
    // the proposal cannot be closed (time is not up, etc.).
    //
    // @param proposalID The proposal ID
    function closeProposal(uint proposalID) external;

    // Returns true if the passed address is a member of this DAO, false
    // otherwise.  This likely has to call the NFTManager, so it's not just a
    // public variable.  For this assignment, this should be callable by both
    // members and non-members.
    //
    // @param who An account address
    // @return A bool as to whether the passed address is a member of this DAO
    function isMember(address who) external view returns (bool);

    // Adds the passed member.  For this assignment, any current member of the
    // DAO can add members. Membership is indicated by an NFT token, so one
    // must be transferred to this member as part of this call.  This can only
    // be called by a member of the DAO, and should revert otherwise.
    // @param who The new member to add
    //
    // @param who An account address to have join the DAO
    function addMember(address who) external;

    // This is how one requests to join the DAO.  Presumably they called
    // howToJoin(), and fulfilled any requirement(s) therein.  In a real
    // application, this would put them into a list for the owner(s) to
    // approve or deny.  For us, this will just call revert(), as joining is
    // done through the other functions listed above.  This should also
    // revert if the caller is already a member.
    function requestMembership() external;

    // also supportsInterface() from IERC165; it should support two
    // interfaces (IERC165 and IDAO)


    //------------------------------------------------------------
    // Events to emit

    // Called whenever newProposal() successfully completes
    // @param proposalID The proposal ID that was just created
    //
    // @param recipient The recipient address that will receive the ether if
    //        the proposal is successful
    // @param amount The amount of wei that the recipient will receive
    // @param description A short textual description of the proposal
    event NewProposal(uint indexed proposalID, address indexed recipient, uint indexed amount, string description);

    // Called whenever a proposal is voted upon
    //
    // @param proposalID Which proposal was voted upon
    // @param position Whether they were in support of the proposal or not
    // @param voter Who voted
    event Voted(uint indexed proposalID, bool indexed position, address indexed voter);

    // Called whenever a proposal is successfully closed via `closeProposal()`
    //
    // @param proposalID The proposal that was closed
    // @param result Whether the proposal was successful or not
    event ProposalClosed(uint indexed proposalID, bool indexed result);

}
