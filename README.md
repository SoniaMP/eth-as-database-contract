# Blockchain CRM for Small Companies

## Overview

**A decentralized CRM** where authenticated users (via MetaMask) can manage company records through **on-chain CRUD operations**. Built with:

- **Frontend**: React + TypeScript + ethers.js
- **Blockchain**: Ethereum (Local/Testnet via Anvil)
- **Smart Contracts**: Solidity (Foundry)

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

## Architecture

<img width="553" height="175" alt="image" src="https://github.com/user-attachments/assets/2138f527-6ec0-4255-b166-c32ab47de383" />

## Usage

### Clone the project

```shell
git clone [https://github.com/your-username/your-repo.git](https://github.com/SoniaMP/eth-as-database-be.git)
cd eth-as-database-contract
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test -vvv
```

### Format

```shell
$ forge fmt
```

### Anvil

```shell
$ anvil
```

### Deploy in Anvil

```shell
$ forge create src/Company.sol:Company --rpc-url http://127.0.0.1:8545 --private-key private_key_provided_by_anvil --broadcast
```
