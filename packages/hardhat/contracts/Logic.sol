//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Logic {
	address public implemention;
	uint256 public x = 90;
	event CallSuccess();

	function increment() public returns (uint256) {
		emit CallSuccess();
		x = x + 1;
		return x;
	}
}
