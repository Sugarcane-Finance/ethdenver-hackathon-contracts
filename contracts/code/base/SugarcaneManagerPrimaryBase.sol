// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Libraries
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

// Local imports
import "../libs/StringOperations.sol";
import "../libs/SugarcaneLib.sol";

// Interface imports
import "../core/SugarcaneManagerBase.sol";
import "../../interfaces/core/ISugarcaneManagerPrimaryBase.sol";

//  The manager on the canonical chain
contract SugarcaneManagerPrimaryBase is
    SugarcaneManagerBase,
    ISugarcaneManagerPrimaryBase
{
    // // // // // // // // // // // // // // // // // // // //
    // LIBRARIES AND STRUCTS
    // // // // // // // // // // // // // // // // // // // //

    using SafeMathUpgradeable for uint256;
    using StringOperations for string;

    // // // // // // // // // // // // // // // // // // // //
    // VARIABLES - REMEMBER TO UPDATE __gap
    // // // // // // // // // // // // // // // // // // // //

    address private __investmentRegistry;

    // // // // // // // // // // // // // // // // // // // //
    // CONSTRUCTOR
    // // // // // // // // // // // // // // // // // // // //
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    /**
     * @notice Initializes the contract.
     */
    function initialize(uint256 chainId_) public initializer {
        __SugarcaneManagerBase_init(chainId_, address(0), address(0));

        __SugarcaneManagerPrimaryBase_init_unchained();
    }

    function __SugarcaneManagerPrimaryBase_init_unchained()
        internal
        initializer
    {}

    // // // // // // // // // // // // // // // // // // // //
    // MODIFIERS
    // // // // // // // // // // // // // // // // // // // //

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Sends back the address of the investment registry
     */
    function investmentRegistry() external view returns (address) {
        return __investmentRegistry;
    }

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //
    /**
     * @notice Talks to the investment registry to record an investment
     */
    function recordInvestment(
        address signerAddress_,
        uint256 chainId_,
        uint256 protocolId_,
        uint256 initialAmountUsd_
    ) external nonReentrant onlySugarcaneAdmin {
        ISugarcaneInvestmentRegistry(__investmentRegistry).addInvestment(
            signerAddress_,
            chainId_,
            protocolId_,
            initialAmountUsd_
        );

        // If this is the first lending investment mint the first lending badge
        // If this is the first staking investment mint the first staking badge
        // If this is the first liquidity providing investment mint the first liquidity providing badge

        // If this is the first investment mint the first badge
        // If this is the fifth investment mint the fifth badge
        // If this is the tenth investment mint the tenth badge
    }

    /**
     * @notice Sets the address of the investment registry
     * @param investmentRegistry_ the address of the investment registry
     */
    function setInvestmentRegistry(address investmentRegistry_)
        external
        override
        onlySugarcaneAdmin
    {
        return _setInvestmentRegistry(investmentRegistry_);
    }

    /**
     * @notice Sets the address of the bridge gateway
     * @param investmentRegistry_ the address of the bridge gateway
     */
    function _setInvestmentRegistry(address investmentRegistry_) internal {
        address oldInvestmentRegistry = __investmentRegistry;
        __investmentRegistry = investmentRegistry_;

        emit InvestmentRegistryUpdated(
            _msgSender(),
            oldInvestmentRegistry,
            investmentRegistry_
        );
    }

    // // // // // // // // // // // // // // // // // // // //
    // GAP
    // // // // // // // // // // // // // // // // // // // //

    // Gap for more space
    uint256[49] private __gap;
}
