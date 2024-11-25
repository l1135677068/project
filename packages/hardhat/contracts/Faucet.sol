//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet {
	uint256 public amountAllowedOnce = 1000;
	address public tokenContract;
	mapping(address => bool) public requestedAddress;

	constructor(address _tokenContract) {
		tokenContract = _tokenContract;
	}

	function requestToken() public {
		require(!requestedAddress[msg.sender], "Already requested");
		IERC20 token = IERC20(tokenContract);
		require(
			token.balanceOf(address(this)) >= amountAllowedOnce,
			"Not enough tokens in the contract"
		);
		token.transfer(msg.sender, amountAllowedOnce);
		requestedAddress[msg.sender] = true;
	}
}
