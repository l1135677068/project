//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WAIA is ERC20 {
	event Deposit(address indexed account, uint256 amount);
	event Withdraw(address indexed account, uint256 amount);

	constructor() ERC20("WAIA", "WAIA") {}

	function deposit() public payable {
		_mint(msg.sender, msg.value);
		emit Deposit(msg.sender, msg.value);
	}

	fallback() external payable {
		deposit();
	}

	receive() external payable {
		deposit();
	}

	function withdraw(uint256 amount) public {
		require(amount <= balanceOf(msg.sender), "Insufficient balance");
		_burn(msg.sender, amount);
		payable(msg.sender).transfer(amount);
		emit Withdraw(msg.sender, amount);
	}
}
