import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract, ContractFactory, Signer } from "ethers";
import { ethers, upgrades } from "hardhat";

async function main() {
  // Addresses
  let deployer: SignerWithAddress;
  let addr1: SignerWithAddress;
  let addr2: SignerWithAddress;
  let addrs: SignerWithAddress[];
  [deployer, addr1, addr2, ...addrs] = await ethers.getSigners();

  // Set up the factory contract
  const SugarcaneBadge: ContractFactory = await ethers.getContractFactory(
    "SugarcaneBadge"
  );
  const sugarcaneBadge: Contract = await upgrades.deployProxy(
    SugarcaneBadge,
    [process.env.BASE_GOERLI_RELAYER_ADDRESS],
    {
      kind: "uups",
    }
  );
  console.log("\n[DEPLOYED] SugarcaneBadge - ", sugarcaneBadge.address);

  /*
  // Test  connecting to an existing contract insted of redeploying
  const sugarcaneFactoryAddr = "0xqwerty";
  let SugarcaneFactory: ContractFactory = await ethers.getContractFactory(
    "SugarcaneFactory"
  );
  const sugarcaneFactory: Contract = await SugarcaneFactory.attach(
    sugarcaneFactoryAddr
  );
  */
  // decide to unpause the sugarcaneFactory contract
  await sugarcaneBadge.connect(deployer).unpause();
  console.log("--- SugarcaneBadge: unpaused");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
