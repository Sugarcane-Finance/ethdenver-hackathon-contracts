// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol";

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";

// The registry of what investments a given admin has
interface ISugarcaneInvestmentRegistry is IAccessControlUpgradeable {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Emitted when there is an investment added
     * @param operator The admin that made the update
     * @param adminAddress The admin address
     * @param investmentId The id of the investment
     * @param investmentIndex The index of the investment for this admin
     */
    event InvestmentAdded(
        address indexed operator,
        address indexed adminAddress,
        uint256 indexed investmentId,
        uint256 investmentIndex
    );

    /**
     * @notice Emitted when the manager is address is updated
     * @param operator The admin that made the update
     * @param oldManagerAddress The old manager address
     * @param newManagerAddress The new manager address
     */
    event ManagerUpdated(
        address indexed operator,
        address indexed oldManagerAddress,
        address indexed newManagerAddress
    );

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Gets all the investments that have been added for this address
     * @return returns full list of the investments
     */
    function investments(address adminAddress_)
        external
        view
        returns (uint256[] memory);

    /**
     * @notice Get the details of a specific investment
     * @return returns the details of the investment
     */
    function investmentDetails(uint256 investmentId_)
        external
        view
        returns (SugarcaneLib.Investment memory);

    /**
     * @notice Combines the admin address and the investment index to create a unique id
     * @return returns the investment id
     */
    function investmentIdHash(address adminAddress_, uint256 investmentIndex_)
        external
        pure
        returns (uint256);

    /**
     * @notice Get the address of the manager
     * @return returns the address of the manager
     */
    function managerAddress() external view returns (address);

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Adds the investment to the admin
     */
    function addInvestment(
        address adminAddress_,
        uint256 chainId_,
        uint256 protocolId_,
        uint256 initialAmountUsd_
    ) external;

    /**
     * @notice Updates the manager contract location
     */
    function setManager(address managerAddress_) external;
}
