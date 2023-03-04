import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";

import {
  deploySugarcaneContract,
  IBridgeAddresses,
  IContractSet,
  ISetUpFunction,
} from "../utils";

export interface IGoerliContracts extends IContractSet {
  // sugarcaneManager: Contract;
  // sugarcaneFactory: Contract;
  // sugarcaneOnboardExecuteReceiverSecondary: Contract;
}

export const setUp: ISetUpFunction<IGoerliContracts> = async (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => {
  // --- Deploy Sugarcane_Manager_Primary(goerliGateway_, goerliGasService_)
  // --- Deploy Sugarcane_Factory()
  // --- > Sugarcane_Factory.setManager(goerliManagerAddress_)

  // --- > Sugarcane_Manager_Primary.setFactory(factoryAddress_)
  // --- > Sugarcane_Manager_Primary.setOnboarder(defenderAddress_)

  // --- Deploy Sugarcane_Onboard_Execute_Receiver_Primary(goerliManagerAddress_)
  return {};
};
