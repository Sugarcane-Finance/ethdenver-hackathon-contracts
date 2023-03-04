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
  sugarcaneInvestmentRegistry: Contract;
  sugarcaneBadge: Contract;
}

export const setUp: ISetUpFunction<IBaseContracts> = async (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => {
  // --- Deploy SugarcaneManagerPrimary()
  const sugarcaneManager = await deploySugarcaneContract(
    deployer,
    "SugarcaneManagerPrimary",
    [bridge.gatewayAddress, bridge.gasServiceAddress]
  );

  // --- Deploy Sugarcane Investment Registry
  const sugarcaneInvestmentRegistry = await deploySugarcaneContract(
    deployer,
    "SugarcaneInvestmentRegistry",
    [sugarcaneManager.address]
  );

  // --- Deploy Sugarcane Badges
  const sugarcaneBadge = await deploySugarcaneContract(
    deployer,
    "SugarcaneBadge",
    [sugarcaneManager.address]
  );

  return {
    sugarcaneManager,
    sugarcaneInvestmentRegistry,
    sugarcaneBadge,
  };
};
