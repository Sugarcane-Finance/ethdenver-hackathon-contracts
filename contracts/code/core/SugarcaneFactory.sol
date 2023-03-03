// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

// Local imports
import "../libs/StringOperations.sol";
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../../interfaces/core/ISugarcaneFactory.sol";

// The smart contract wallet that the admin controls on various chains
contract SugarcaneFactory is ISugarcaneFactory {
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    using SafeMathUpgradeable for uint256;
    using StringOperations for string;

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    address internal _manager;

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    /**
     * @notice Initializes the contract.
     */
    function initialize() public initializer {
        __SugarcaneFactory_init_unchained();
    }

    function __SugarcaneFactory_init_unchained() internal initializer {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
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
    Only the manager can talk to this function
    Creates a new holdings account for the admin
    Sends back the address of the created holdings 

    [WRITE] – setManager(address managerAddress_)
    Updates the manager contract location 
    */

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[49] private __gap;
}
