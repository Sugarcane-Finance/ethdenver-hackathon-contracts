// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

// Local imports
import "../libs/StringOperations.sol";
import "../libs/SugarcaneLib.sol";

// Interface imports
import "./SugarcaneManagerBase.sol";
import "../../interfaces/core/ISugarcaneManagerPrimary.sol";

//  The manager on the canonical chain
contract SugarcaneManagerPrimary is
    SugarcaneManagerBase,
    ISugarcaneManagerPrimary
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
    function initialize(address gateway_, address gasService_)
        public
        initializer
    {
        __SugarcaneManagerBase_init(gateway_, gasService_);

        __SugarcaneManagerPrimary_init_unchained();
    }

    function __SugarcaneManagerPrimary_init_unchained() internal initializer {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – executeOnboardReceiver() returns address
    Returns the execute onboard receiver address
    */

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – addToUserControlledAddress(uint256 chainId_, address userAddress_)
    This is a function only the Sugarcane_Onboard_Execute_Receiver_Primary contract can change it is 

    [WRITE] – crossChainOnboardUserInitiate(uint256 chainId_, address userAddress_)
    Does checks on valid chain name and talks to Axelar gateway to create on the other chain

    [WRITE] – onboardUser(address userAddress_)
    Does checks for valid request and talks to Sugarcane_Factory to create Holdings address on Base

    [WRITE] – setExecuteOnboardReceiver(address receiverExecuteAddress_)
    Updates the valid address of the Sugarcane_Onboard_Execute_Receiver_Primary contract
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[50] private __gap;
}
