import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";

import {
  deploySugarcaneContract,
  IBridgeAddresses,
  IContractSet,
  ISetUpFunction,
} from "../utils";

export interface IBaseContracts extends IContractSet {
  // sugarcaneManager: Contract;
  // sugarcaneInvestmentRegistry: Contract;
  // sugarcaneBadge: Contract;
}

export const setUp: ISetUpFunction<IBaseContracts> = async (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => {
  // --- Deploy Sugarcane_Factory()
  // --- Deploy Sugarcane_Manager_Primary(goerliGateway_, goerliGasService_)
  // --- > Sugarcane_Factory.setManager(goerliManagerAddress_)
  // --- > Sugarcane_Manager_Primary.setFactory(factoryAddress_)
  // --- > Sugarcane_Manager_Primary.setOnboarder(defenderAddress_)
  // --- Deploy Sugarcane_Onboard_Execute_Receiver_Primary(goerliManagerAddress_)
  return {};
};
