// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../../code/libs/SugarcaneLib.sol";
import "../utils/ISugarcaneCore.sol";

// The registry of what investments a given signer has
interface ISugarcaneInvestmentRegistry is ISugarcaneCore {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Emitted when there is an investment added
     * @param manager The manager address that made the update
     * @param signerAddress The signer address
     * @param investmentId The id of the investment
     * @param investmentIndex The index of the investment for this signer
     */
    event InvestmentAdded(
        address indexed manager,
        address indexed signerAddress,
        uint256 indexed investmentId,
        uint256 investmentIndex
    );

    /**
     * @notice Emitted when the manager is address is updated
     * @param sugarcaneAdmin The admin that made the update
     * @param oldManagerAddress The old manager address
     * @param newManagerAddress The new manager address
     */
    event ManagerUpdated(
        address indexed sugarcaneAdmin,
        address indexed oldManagerAddress,
        address indexed newManagerAddress
    );

    // // // // // // // // // // // // // // // // // // // //
    // GETTERS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Gets all the investments that have been added for this address
     * @return returns full list of the investment ids
     */
    function investments(address signerAddress_)
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
     * @notice Combines the signer address and the investment index to create a unique id
     * @return returns the investment id
     */
    function investmentIdHash(address signerAddress_, uint256 investmentIndex_)
        external
        view
        returns (uint256);

    /**
     * @notice Get the address of the manager
     * @return returns the address of the manager
     */
    function manager() external view returns (address);

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Adds the investment to the signer
     */
    function addInvestment(
        address signerAddress_,
        uint256 chainId_,
        uint256 protocolId_,
        uint256 initialAmountUsd_
    ) external;

    /**
     * @notice Updates the manager contract location
     */
    function setManager(address managerAddress_) external;
}
