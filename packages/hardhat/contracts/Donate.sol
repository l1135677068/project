// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Donate {
	address public owner;
	mapping(address => uint256) public donateAddress;
	event SendEtherFromCall(address to);

	constructor() {
		owner = msg.sender;
	}

	function showBalance() public view returns (uint256) {
		return address(this).balance;
	}

	function donate() public payable {
		require(msg.value > 0, "Not Enough Ehter");
		donateAddress[msg.sender] = msg.value;
	}

	modifier OnlyOwner() {
		require(msg.sender == owner, "Not Owner");
		_;
	}

	modifier EnoughBalance(uint256 _amount) {
		require(address(this).balance >= _amount, "Insufficent Balance");
		_;
	}

	function getEtherFromCall(
		address _to,
		uint256 _amount
	) public OnlyOwner EnoughBalance(_amount) {
		require(address(this).balance >= _amount, "Insufficent Balance");
		(bool sent, ) = _to.call{ value: _amount }("");
		emit SendEtherFromCall(_to);
		require(sent, "sent fail");
	}

	function getEtherFromSend(
		address payable _to,
		uint256 _amount
	) public OnlyOwner EnoughBalance(_amount) {
		bool success = _to.send(_amount);
		require(success, "send fail");
	}

	function getEtherFromTransfer(
		address payable _to,
		uint256 _amount
	) public OnlyOwner EnoughBalance(_amount) {
		_to.transfer(_amount);
	}
}
