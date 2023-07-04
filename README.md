# Company Investment Smart Contract

This repository contains a Solidity smart contract that allows investors to invest in a company while incorporating Key Performance Indicators (KPIs) and rules to ensure investor trust.

## Overview

The smart contract enables investors to contribute funds to the company and tracks their investments. It includes the following features:

- Investors can invest in the company by sending Ether to the contract.
- The company can update the KPI threshold required for investors to withdraw their investments.
- The company can update the KPI status to indicate whether the threshold has been met.
- Once the investment period is closed and the KPI threshold is met, investors can withdraw their investments.

## Contract Details

The smart contract is implemented in Solidity and includes the following key components:

- `Investor` struct: Represents an individual investor with their address, invested amount, KPI threshold, and active status.
- `investors` mapping: Tracks the details of all investors participating in the investment.
- `companyAddress`: Stores the address of the company.
- `totalInvestedAmount`: Tracks the total amount invested by all investors.
- `totalKpiThreshold`: Stores the KPI threshold required for investors to withdraw their investments.
- `companyKpiMet`: Indicates whether the company has met the KPI threshold.
- `investmentClosed`: Indicates whether the investment period is closed.

## Getting Started

To use this smart contract, follow these steps:

1. Install a Solidity compiler, such as `solc`, to compile the smart contract.
2. Deploy the smart contract on an Ethereum network using a compatible Ethereum client or platform.
3. Interact with the contract using a web interface, command-line interface, or another contract.

## Example Usage

Here's an example of how to use the smart contract:

1. Deploy the contract, providing the company address and the desired KPI threshold.
2. Investors can call the `invest()` function, sending Ether along with the transaction, to invest in the company.
3. The company can update the KPI threshold using the `updateKpiThreshold()` function.
4. The company can update the KPI status using the `updateKpiStatus()` function.
5. Once the investment period is closed and the KPI threshold is met, investors can call the `withdrawInvestment()` function to withdraw their investments.
