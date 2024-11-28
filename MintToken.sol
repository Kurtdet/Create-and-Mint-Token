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
