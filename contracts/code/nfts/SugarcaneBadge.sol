// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract SugarcaneBadge is
    Initializable,
    ERC1155Upgradeable,
    OwnableUpgradeable,
    ERC1155SupplyUpgradeable,
    UUPSUpgradeable
{
    uint256 public constant MARKET_MAKER = 0;
    uint256 public constant STAKER = 1;
    uint256 public constant LENDER = 2;

    address internal _managerAddress;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address managerAddress_) public initializer {
        __ERC1155_init("");
        __Ownable_init();
        __ERC1155Supply_init();
        __UUPSUpgradeable_init();

        _managerAddress = managerAddress_;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(
        uint256 badgeId
    ) public view virtual override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "https://sugarcane.infura-ipfs.io/ipfs/QmdPqKhoYKbrqDx1jCEjPpHdi86nHdfcJS6ZJfKZQcbTJa/metadata/",
                    Strings.toString(badgeId),
                    ".json"
                )
            );
    }

    function managerAddress() public view returns (address) {
        return _managerAddress;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155Upgradeable, ERC1155SupplyUpgradeable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    // function safeTransferFrom(
    //     address from,
    //     address to,
    //     uint256 id,
    //     uint256 amount,
    //     bytes memory data
    // ) public virtual override {
    //   revert();
    // }

    // function mint() public
}
