import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";

import {
  deploySugarcaneContract,
  IBridgeAddresses,
  IContractSet,
  ISetUpFunction,
} from "../utils";

export interface IBaseContracts extends IContractSet {
  sugarcaneManager: Contract;
  sugarcaneFactory: Contract;
  sugarcaneInvestmentRegistry: Contract;
  sugarcaneBadge: Contract;
}

export const setUp: ISetUpFunction<IBaseContracts> = async (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => {
  // Deploy Sugarcane Manager Primary
  const sugarcaneManager = await deploySugarcaneContract(
    deployer,
    "SugarcaneManagerPrimaryBase",
    [bridge.gatewayAddress, bridge.gasServiceAddress]
  );

  // Deploy Sugarcane Factory
  const sugarcaneFactory = await deploySugarcaneContract(
    deployer,
    "SugarcaneFactory",
    [sugarcaneManager.address]
  );

  // Deploy Sugarcane Investment Registry
  const sugarcaneInvestmentRegistry = await deploySugarcaneContract(
    deployer,
    "SugarcaneInvestmentRegistry",
    [sugarcaneManager.address]
  );

  // Deploy Sugarcane Badges
  const sugarcaneBadge = await deploySugarcaneContract(
    deployer,
    "SugarcaneBadge",
    [sugarcaneManager.address]
  );

  // // // // // // // // // //
  // Update the sugarcane manager

  // Set the Sugarcane factory
  await sugarcaneManager.setSugarcaneFactory(sugarcaneFactory.address);
  console.log(
    `--- Manager.SugarcaneFactory updated - ${sugarcaneFactory.address}`
  );

  // Set the Sugarcane Investment Registry
  await sugarcaneManager.setInvestmentRegistry(
    sugarcaneInvestmentRegistry.address
  );
  console.log(
    `--- Manager.InvestmentRegistry updated - ${sugarcaneInvestmentRegistry.address}`
  );

  // Set the Sugarcane Badge
  await sugarcaneManager.setSugarcaneBadge(sugarcaneBadge.address);
  console.log(`--- Manager.SugarcaneBadge updated - ${sugarcaneBadge.address}`);

  return {
    sugarcaneManager,
    sugarcaneFactory,
    sugarcaneInvestmentRegistry,
    sugarcaneBadge,
  };
};
