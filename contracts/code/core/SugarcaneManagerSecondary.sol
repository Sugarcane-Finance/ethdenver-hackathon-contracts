// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

// Local imports
import "../libs/StringOperations.sol";
import "../libs/SugarcaneLib.sol";

// Interface imports
import "./SugarcaneManagerBase.sol";
import "../../interfaces/core/ISugarcaneManagerSecondary.sol";

//  The manager on a non-canonical chain
contract SugarcaneManagerSecondary is
    SugarcaneManagerBase,
    ISugarcaneManagerSecondary
{
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    using SafeMathUpgradeable for uint256;
    using StringOperations for string;

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    /**
     * @notice Initializes the contract.
     */
    function initialize(
        uint256 chainId_,
        address gateway_,
        address gasService_
    ) public initializer {
        __SugarcaneManagerBase_init(chainId_, gateway_, gasService_);

        __SugarcaneManagerSecondary_init_unchained();
    }

    function __SugarcaneManagerSecondary_init_unchained()
        internal
        initializer
    {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Does checks for valid request and talks to Sugarcane_Factory to create Holdings address on Base
     * @param signerAddress_ the address of the account to onboard
     */
    function onboardAccount(address signerAddress_)
        external
        override(ISugarcaneManagerBase, SugarcaneManagerBase)
        nonReentrant
        whenNotPausedExceptAdmin
        onlyOnboarder
    {
        // Run onboard locally
        _onboardAccount(signerAddress_);

        // Send a message to the primary chain that the account has been onboarded
    }

    /*
    [WRITE] – onboardUser(address userAddress_)
    Only the Sugarcane_Onboard_Execute_Receiver_Secondary contract can talk to this.
    Talks to the Sugarcane_Factory.createHoldingsAccount(userAddress_) to create holdings on this chain
    Talks to the gateway() to let the primary manager know what this chain’s holdings is
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[50] private __gap;
}
