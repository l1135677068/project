//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract B {
	address private owner;
	uint256 private _num;

	function setNumber(uint256 number) public {
		_num = number;
		owner = msg.sender;
	}

	function getNumber() public view returns (uint256) {
		return _num;
	}

	function getOwner() public view returns (address) {
		return owner;
	}

	function pay() public payable {}

	receive() external payable {}
}
