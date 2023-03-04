import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract, ContractFactory } from "ethers";
import { ethers, upgrades } from "hardhat";

export interface IContractSet {
  [contractName: string]: Contract;
}

export interface IBridgeAddresses {
  gatewayAddress: string;
  gasServiceAddress: string;
}

export type ISetUpFunction<IContractSet> = (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => Promise<IContractSet>;

// // // // // // // // // // // // // // // // // // // //
// MUMBAI SETUP
// // // // // // // // // // // // // // // // // // // //
export const setUpMumbai = async () => {
  // --- Deploy Sugarcane_Factory()
  // --- Deploy Sugarcane_Manager_Secondary(mumbaiGateway_, mumbaiGasService_, chainId_)
  // --- > Sugarcane_Factory.setManager(mumbaiManagerAddress_)
  // --- > Sugarcane_Manager_Secondary.setFactory(mumbaiFactoryAddress_)
  // --- Deploy Sugarcane_Onboard_Execute_Receiver_Secondary
  // --- > Sugarcane_Manager_Secondary.setOnboarder(onboardExecuteReceive_)
};

export const deploySugarcaneContract = async (
  deployer: SignerWithAddress,
  contractName: string,
  args: unknown[]
): Promise<Contract> => {
  // Set up the factory contract
  const SugarcaneContractFactory: ContractFactory =
    await ethers.getContractFactory(contractName);
  const sugarcaneContract: Contract = await upgrades.deployProxy(
    SugarcaneContractFactory,
    args,
    {
      kind: "uups",
    }
  );
  console.log(
    `\n[DEPLOYED] ${SugarcaneContractFactory} - `,
    sugarcaneContract.address
  );

  await unpauseContract(deployer, contractName, sugarcaneContract.address);

  return sugarcaneContract;
};

export const connectToSugarcaneContract = async (
  contractName: string,
  sugarcaneContractAddr: string
): Promise<Contract> => {
  // Connecting to an existing contract
  let SugarcaneContractFactory: ContractFactory =
    await ethers.getContractFactory(contractName);
  const sugarcaneContract: Contract = await SugarcaneContractFactory.attach(
    sugarcaneContractAddr
  );

  return sugarcaneContract;
};

export const unpauseContract = async (
  deployer: SignerWithAddress,
  contractName: string,
  sugarcaneContractAddr: string
) => {
  const sugarcaneContract = await connectToSugarcaneContract(
    contractName,
    sugarcaneContractAddr
  );
  await sugarcaneContract.connect(deployer).unpause();
  console.log(`--- ${contractName}: unpaused`);
};
