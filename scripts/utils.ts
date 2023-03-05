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

export const chainIds = {
  baseGoerli: 84531,
  goerli: 5,
  mumbai: 80001,
};

export type ISetUpFunction<IContractSet> = (
  deployer: SignerWithAddress,
  bridge: IBridgeAddresses
) => Promise<IContractSet>;

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
  console.log(`\n[DEPLOYED] ${contractName} - `, sugarcaneContract.address);

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
