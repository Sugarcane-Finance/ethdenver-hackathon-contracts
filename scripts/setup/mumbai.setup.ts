import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";

import {
  deploySugarcaneContract,
  IBridgeAddresses,
  IContractSet,
  ISetUpFunction,
} from "../utils";

export interface IMumbaiContracts extends IContractSet {
  // sugarcaneManager: Contract;
  // sugarcaneFactory: Contract;
  // sugarcaneOnboardExecuteReceiverSecondary: Contract;
}

export const setUp: ISetUpFunction<IMumbaiContracts> = async (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => {
  // --- Deploy Sugarcane_Manager_Secondary(mumbaiGateway_, mumbaiGasService_, chainId_)

  // --- Deploy Sugarcane_Factory()
  // --- > Sugarcane_Factory.setManager(mumbaiManagerAddress_)

  // --- > Sugarcane_Manager_Secondary.setFactory(mumbaiFactoryAddress_)

  // --- Deploy Sugarcane_Onboard_Execute_Receiver_Secondary
  // --- > Sugarcane_Manager_Secondary.setOnboarder(onboardExecuteReceive_)
  return {};
};
