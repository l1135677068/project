//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Receive {
	// 收到eth事件，记录amount和gas
	event Log(uint amount, uint gas);
	address owner;

	constructor() {
		owner = msg.sender;
	}

	modifier isOwner() {
		// msg.sender: predefined variable that represents address of the account that called the current function
		require(msg.sender == owner, "Not the Owner");
		_;
	}

	receive() external payable {
		emit Log(msg.value, gasleft());
	}

	// 返回合约ETH余额
	function getBalance() public view returns (uint) {
		return address(this).balance;
	}

	function payForContract() public payable {}

	// delete the contract
	function deleteContract() public isOwner {
		selfdestruct(payable(msg.sender));
	}
}
