import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";

import { IBaseContracts, setUp as setUpBase } from "./setup/base.setup";
import { IGoerliContracts, setUp as setUpGoerli } from "./setup/goerli.setup";
import { IMumbaiContracts, setUp as setUpMumbai } from "./setup/mumbai.setup";
import { badgeIds, IBridgeAddresses, protocolIds } from "./utils";

async function main() {
  let deployer: SignerWithAddress;
  let addr1: SignerWithAddress;
  let addr2: SignerWithAddress;
  let addrs: SignerWithAddress[];
  [deployer, addr1, addr2, ...addrs] = await ethers.getSigners();

  console.log("\n\n[ID] Badge Ids");
  console.log(badgeIds);

  console.log("\n\n[ID] Protocol Ids");
  console.log(protocolIds);

  // Set up Base
  /* */
  const baseBridge: IBridgeAddresses = {
    gatewayAddress: addr1.address,
    gasServiceAddress: addr2.address,
  };
  const baseContracts: IBaseContracts = await setUpBase(
    // deployer: SignerWithAddress,
    deployer,
    // onboarder: string,
    deployer.address,
    // bridge: IBridgeAddresses
    baseBridge
  );
  /*

  // Set up Goerli
  const goerliBridge: IBridgeAddresses = {
    gatewayAddress: addr1.address,
    gasServiceAddress: addr2.address,
  };
  const goerliContracts: IGoerliContracts = await setUpGoerli(
    // deployer: SignerWithAddress,
    deployer,
    // onboarder: string,
    addr2.address,
    // bridge: IBridgeAddresses
    goerliBridge
  );

  /*
  // Set up Mumbai
  const mumbaiBridge: IBridgeAddresses = {
    gatewayAddress: addr1.address,
    gasServiceAddress: addr2.address,
  };
  const mumbaiContracts: IMumbaiContracts = await setUpMumbai(
    deployer,
    mumbaiBridge
  );
  */
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
