//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AirDrop {
	address[] public s_transferAddress;
	uint256[] public s_transferTokenAmount;
	address public tokenContract;

	constructor(address tokenAddress) {
		tokenContract = tokenAddress;
	}

	function getSum() public view returns (uint256) {
		uint256 sum = 0;
		for (uint256 i = 0; i < s_transferTokenAmount.length; i++) {
			sum += s_transferTokenAmount[i];
		}
		return sum;
	}

	function addAddress() public {
		s_transferAddress.push(msg.sender);
		s_transferTokenAmount.push(100);
	}

	function multiTransferToken() public {
		require(
			s_transferAddress.length == s_transferTokenAmount.length,
			"length not equal"
		);
		IERC20 token = IERC20(tokenContract);
		uint256 sumToken = getSum();
		require(
			token.allowance(msg.sender, address(this)) >= sumToken,
			"allowance not enough"
		);

		for (uint256 i = 0; i < s_transferAddress.length; i++) {
			token.transferFrom(
				msg.sender,
				s_transferAddress[i],
				s_transferTokenAmount[i]
			);
		}
	}
}
