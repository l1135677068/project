//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Caller {
	address public proxy;
	uint256 public value;

	constructor(address _proxy) {
		proxy = _proxy;
	}

	function increment() external {
		(, bytes memory data) = proxy.call(
			abi.encodeWithSignature("increment()")
		);
		value = abi.decode(data, (uint));
	}
}
