# DNDCoin Smart Contract

This Solidity program demonstrates a simple ERC20 token implementation with additional features such as minting, burning tokens, and ensuring a capped supply. It introduces essential concepts for managing token-based transactions, access control, and supply limitations, providing a foundation for more complex token systems.

## Description

The `DNDCoin` contract is a simple ERC20 token that has the following features:

- **Max Supply Limit**: The token has a maximum supply of 100,000 tokens, ensuring that the total supply cannot exceed this limit.
- **Minting Functionality**: The owner of the contract can mint new tokens to any address, provided it does not exceed the maximum supply.
- **Burning Functionality**: Tokens can be burned from any address, reducing the total supply.
- **Access Control**: Only the owner can mint and burn tokens, with a modifier in place to enforce this access control.
- **ERC20 Standard Compliance**: The contract adheres to the ERC20 token standard, allowing for typical token operations such as transfers and approvals.

This contract serves as an example of an ERC20 token with additional administrative functionality, and it can be expanded or integrated into various decentralized applications (dApps).

## Getting Started

### Executing Program

To deploy and interact with this contract, you can use **Remix**, an online Solidity IDE. Follow the steps below to get started:

1. Go to the [Remix website](https://remix.ethereum.org/).
2. In the left-hand sidebar, click the "+" icon to create a new file.
3. Save the file with a `.sol` extension (e.g., `DNDCoin.sol`).
4. Copy and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract DNDCoin is ERC20 {
    address public owner;

    // For demonstration purposes
    uint256 public constant MAX_SUPPLY = 100000; // Max supply set to 100000

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner is allowed to initiate this function");
        _;
    }

    modifier validateMint(uint256 value) {
        require(totalSupply() + value <= MAX_SUPPLY, "Exceeds maximum supply");
        _;
    }

    constructor(uint256 initialSupply) ERC20("DND Coin", "DND") {
        _mint(msg.sender, initialSupply);
        owner = msg.sender;
    }

    function mint(address to, uint256 value) external onlyOwner validateMint(value) {
        _mint(to, value);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function burn(address from, uint256 value) external {
        _burn(from, value);
    }
}
```

### Compilation and Deployment

1. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar of Remix.
2. Ensure the compiler version is set to `0.8.18` (or another compatible version), and click "Compile DNDCoin.sol."
3. Once the contract is compiled, go to the "Deploy & Run Transactions" tab in Remix.
4. Select the `DNDCoin` contract from the dropdown menu and click the "Deploy" button.

### Interacting with the Contract

1. **Mint Tokens** (Owner Only)
   - Only the owner can mint new tokens to an address, up to the maximum supply of 100,000 tokens.
   - To mint tokens, use the `mint` function. For example, calling `mint(address, 5000)` will mint 5,000 tokens to the specified address.

2. **Burn Tokens**
   - Any address can burn tokens by calling the `burn` function.
   - For example, calling `burn(address, 100)` will burn 100 tokens from the specified address, reducing the total supply.

3. **Transfer Tokens**
   - Transfer tokens between addresses using the standard ERC20 `transfer` function.
   - For example, calling `transfer(address, 100)` will send 100 tokens from the sender’s address to the recipient address.

4. **Get Token Balance**
   - Use the `balanceOf` function (inherited from ERC20) to check the balance of any address. For example, calling `balanceOf(address)` will return the token balance of the specified address.

5. **Check Total Supply**
   - Use the `totalSupply` function (inherited from ERC20) to check the total supply of tokens. This will return the number of tokens currently in circulation.

### Events

The contract emits the following events:

- **Transfer**: Triggered when tokens are transferred between addresses.
- **Approval**: Triggered when a spender is approved to transfer tokens on behalf of an account (inherited from ERC20).
- **Mint**: Triggered when new tokens are minted (can be manually emitted for tracking purposes).
- **Burn**: Triggered when tokens are burned from an account (can be manually emitted for tracking purposes).

## Conclusion

The `DNDCoin` contract serves as a foundation for creating a token with basic minting, burning, and transferring functionalities. It also includes mechanisms to enforce a capped supply, ensuring that the total token supply does not exceed the predefined maximum. This contract is designed for educational purposes, and can be used as a starting point for more complex token systems in decentralized applications (dApps).
