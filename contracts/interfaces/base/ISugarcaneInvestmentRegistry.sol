// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";

// The registry of what investments a given admin has
interface ISugarcaneInvestmentRegistry {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – investments(address adminAddress_) returns SugarcaneLib.Investment[]
    Sends back an array of the investments

    [READ] – manager() returns address
    Returns the manager address
    */
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – addInvestments(address adminAddress_) returns SugarcaneLib.Investment[]
    Adds to the list of investments an admin has

    [WRITE] – setManager(address managerAddress_)
    Updates the manager contract location 
    */
}
