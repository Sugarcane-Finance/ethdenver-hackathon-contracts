// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

// Local imports
import "../libs/StringOperations.sol";
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../../interfaces/core/ISugarcaneManagerBase.sol";

//  Abstract class that the managers on primary and secondary chains will inherit
contract SugarcaneManagerBase is ISugarcaneManagerBase {
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
    function initialize() public initializer {
        __SugarcaneManagerBase_init_unchained();
    }

    function __SugarcaneManagerBase_init_unchained() internal initializer {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [READ] – bridgeGateway() returns address
    Returns the cross-chain communication gateway

    [READ] – factory() returns address
    Returns the Sugarcane factory address

    [READ] – gasReceiver() returns address
    Returns the cross-chain gas payment location 

    [READ] – hasOnboarded(address userAddress_) returns bool
    Tells if the user has onboarded

    [READ] – onboarder() returns address
    Returns the address that can make it onboard users (on Base this is the Base relayer, on Goerli it is the defender address, and on the other chains it is their Sugarcane_Onboard_Executor)
    */

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /*
    [WRITE] – setFactory(address factoryAddress_)
    Updates the factory contract location 

    [WRITE] – setBridgeGateway(address gatewayAddress_)
    Updates the cross-chain communication gateway

    [WRITE] – setOnboarder(address onboarderAddress_)
    Updates the valid onboarding address contract 
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[50] private __gap;
}
