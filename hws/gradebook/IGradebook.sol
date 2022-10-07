// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

interface IGradebook {

    //------------------------------------------------------------
    // Events

    // This should be emitted when an assignment is created
    event assignmentCreationEvent (uint indexed _id);

    // This should be emitted when a grade is updated
    event gradeEntryEvent (uint indexed _id);

    //------------------------------------------------------------
    // The following six methods are done for you automatically -- as long as
    // you make the appropriate variable public, then Solidity will create
    // the getter function for you
    
    // Returns whether the passed address has been designated as a
    // teaching assistant
    function tas(address ta) external view returns (bool);

    // Returns the max score for the given assignment
    function max_scores(uint id) external view returns (uint);

    // Returns the name of the given assignment
    function assignment_names(uint id) external view returns (string memory);

    // Returns the score for the given assignment ID and the given
    // student
    function scores(uint id, string memory userid) external view returns (uint);

    // Returns how many assignments there are; the assignments are
    // assumed to be indexed from 0
    function num_assignments() external view returns (uint);

    // Returns the address of the instructor, who is the person who
    // deployed this smart contract
    function instructor() external view returns (address);

    //------------------------------------------------------------
    // The following five functions are ones you must implement

    // Designates the passed address as a teaching assistant; re-designating
    // an address a TA does not do anything special (no revert).  Only the
    // instructor OR other TAs can designated TAs.
    function designateTA(address ta) external;

    // Adds an assignment of the given name with the given maximum score.  It
    // should revert if called by somebody other than the instructor or an
    // already designated teaching assistant.  It does not check if an
    // assignment with the same name already exists; thus, you can have
    // multiple assignments with the same name (but different IDs).  It
    // returns the assignment ID.
    function addAssignment(string memory name, uint max_score) external returns (uint);

    // Adds the given grade for the given student and the given assignment.
    // This should revert if (a) the caller is not the instructor or TA, or
    // (b) the assignment ID is invalid, or (c) the score is higher than the
    // allowed maximum score.
    function addGrade(string memory student, uint assignment, uint score) external;

    // Obtains the average of the given student's scores.  Each assignment is
    // weighted based on the number of points for that assignment.  So a 5/10
    // on one assignment and a 20/20 on another assignment would yield 25/30
    // points, or 83.33.  This returns 100 times that, or 8333.  Note that
    // the value is truncated, not rounded; so if the average were 16.67%, it
    // would return 1666.
    function getAverage(string memory student) external view returns (uint);

    // This function is how we are going to test your program -- we are going
    // to request TA access.  For this assignment, it will automatically make
    // msg.sender a TA, and has no effect if the sender is already a TA
    // (or instructor).  In reality, this would revert(), as only the
    // instructor (and other TAs) can make new TAs.
    function requestTAAccess() external;

    //------------------------------------------------------------
    // The implementation for the following is provided in the HW description

    function supportsInterface(bytes4 interfaceId) external view returns (bool);

}
