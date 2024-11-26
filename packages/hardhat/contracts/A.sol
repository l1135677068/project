//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract A {
	address public owner;
	uint256 public _num;

	function callSetNumber(address contrt, uint256 number) external {
		contrt.call{ gas: 10000000 }(
			abi.encodeWithSignature("setNumber(uint256)", number)
		);
	}

	function delegatecallSetNumber(address contrt, uint256 number) external {
		contrt.delegatecall{ gas: 10000000 }(
			abi.encodeWithSignature("setNumber(uint256)", number)
		);
	}
}
