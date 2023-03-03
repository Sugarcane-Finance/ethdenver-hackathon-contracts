// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../utils/ISugarcaneCore.sol";

// The contract that produces more holdings contracts
interface ISugarcaneFactory is ISugarcaneCore {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – manager() returns address
    Returns the manager address
    */
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – createHoldingsAccount(address adminAddress_) returns address 
    Only the manager can talk to this function Sends back the address of the created holdings 

    [WRITE] – setManager(address managerAddress_)
    Updates the manager contract location 
    */
}
