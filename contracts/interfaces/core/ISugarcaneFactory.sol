// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Connected parts of the system
import "../utils/ISugarcaneCore.sol";

// The contract that produces more holdings contracts
interface ISugarcaneFactory is ISugarcaneCore {
    // // // // // // // // // // // // // // // // // // // //
    // EVENTS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Emitted when the manager is address is updated
     * @param manager The admin that made the update
     * @param sugarcaneHoldings The address of the holdings contract
     * @param signerChainId The chain this was deployed on
     * @param signerAddress The signer who owns the holdings
     */
    event HoldingsAccountCreated(
        address manager,
        address indexed sugarcaneHoldings,
        uint256 indexed signerChainId,
        address indexed signerAddress
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
     * @notice Get the address of the manager
     * @return returns the address of the manager
     */
    function manager() external view returns (address);

    // // // // // // // // // // // // // // // // // // // //
    // CORE FUNCTIONS
    // // // // // // // // // // // // // // // // // // // //

    /**
     * @notice Only the manager can talk to this function Sends back the address of the created holdings
     */
    function createHoldingsAccount(
        uint256 signerChainId_,
        address signerAddress_
    ) external returns (address);

    /**
     * @notice Updates the manager contract location
     */
    function setManager(address managerAddress_) external;
}
