import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract, ContractFactory } from "ethers";
import { keccak256, toUtf8Bytes } from "ethers/lib/utils";
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

// Badge Ids
export const badgeIds = {
  LIQUIDITY_PROVIDER: keccak256(
    toUtf8Bytes("badge.LIQUIDITY_PROVIDER")
  ).toLowerCase(),
  STAKER: keccak256(toUtf8Bytes("badge.STAKER")).toLowerCase(),
  LENDER: keccak256(toUtf8Bytes("badge.LENDER")).toLowerCase(),
  FRIEND_REFER: keccak256(toUtf8Bytes("badge.FRIEND_REFER")).toLowerCase(),
  INVEST_ONE: keccak256(toUtf8Bytes("badge.INVEST_ONE")).toLowerCase(),
  INVEST_FIVE: keccak256(toUtf8Bytes("badge.INVEST_FIVE")).toLowerCase(),
  INVEST_TEN: keccak256(toUtf8Bytes("badge.INVEST_TEN")).toLowerCase(),
};

export const badgeImageCIDs = {
  LIQUIDITY_PROVIDER: "QmQU19gBFVZcwEUmg3AXYPkcX6YXu3goq1KuuWSiAaGMgD",
  STAKER: "QmYHisJxv83NjZi4f6uSYF6zakydVKJq65jhTmkWSihFKF",
  LENDER: "QmabrikTiCD3JeoQyMAS9xASC7fpAQkBnC26QXws6GdJWD",
  FRIEND_REFER: "QmZw42ok2N1n8fAycjCbXQMGfqwkNQEp9htUU89pj4BtTk",
  INVEST_ONE: "Qmc7fU4nV6PVuctqQdmmEja8DFmszkP5VibXfG4Bg8QNeV",
  INVEST_FIVE: "QmVaLm7aWKZW1dxfoUoYqPEMPkEmaKVqCC83zi5XHzeg7b",
  INVEST_TEN: "QmX3oJ24G3SctAR4TgVi7YkmBwWcWsa2aHhRsBg3uAVM9q",
};

// Protocol Ids
export const protocolIds = {
  AAVE: keccak256(toUtf8Bytes("protocol.AAVE")).toLowerCase(),
  UNISWAP: keccak256(toUtf8Bytes("protocol.UNISWAP")).toLowerCase(),
  SSV_LIQUID_STAKING: keccak256(
    toUtf8Bytes("protocol.SSV_LIQUID_STAKING")
  ).toLowerCase(),
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
