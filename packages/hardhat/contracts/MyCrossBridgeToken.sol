//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyCrossBridgeToken is ERC20, Ownable {
	event Bridge(address user, uint256 amount);
	event Mint(address user, uint256 amount);

	constructor(
		uint256 totalSupply
	) payable ERC20("CrossBirdgeToken", "CBT") Ownable(msg.sender) {
		_mint(msg.sender, totalSupply);
	}

	function bridge(uint256 amount) public {
		_burn(msg.sender, amount);
		emit Bridge(msg.sender, amount);
	}

	function mint(address ad, uint256 amount) external onlyOwner {
		_mint(ad, amount);
		emit Mint(ad, amount);
	}
}
