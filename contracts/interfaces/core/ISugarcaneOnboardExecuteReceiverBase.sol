// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";

// The contract on the secondary chains that updates the manager
interface ISugarcaneOnboardExecuteReceiverBase {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – _execute(
        string calldata sourceChain,
        string calldata sourceAddress,
        bytes calldata payload
    )
    Talks to the Sugarcane manager that is on this chain to run 

    [READ] – getManager() returns address
    Returns the manager address
    */
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – setManager(address managerAddress_)
    Updates the manager contract location
    */
}
