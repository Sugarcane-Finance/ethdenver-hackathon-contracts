// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";

import "./ISugarcaneManagerBase.sol";

//  The manager on a non-canonical chain
interface ISugarcaneManagerSecondary is ISugarcaneManagerBase {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – onboardUser(address userAddress_)
    Only the Sugarcane_Onboard_Execute_Receiver_Secondary contract can talk to this.
    Talks to the Sugarcane_Factory.createHoldingsAccount(userAddress_) to create holdings on this chain
    Talks to the gateway() to let the primary manager know what this chain’s holdings is
    */
}
