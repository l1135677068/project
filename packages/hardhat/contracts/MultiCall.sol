//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MultiCall {
	struct CallInfo {
		address target; // target ca
		bytes callData; // calldata is compose of function selector and params
	}

	struct Result {
		bool success;
		bytes returnData;
	}

	function multiCall(
		CallInfo[] memory callInfo
	) public returns (Result[] memory results) {
		uint256 length = callInfo.length;
		results = new Result[](length);
		CallInfo memory call;
		for (uint i = 0; i < callInfo.length; i++) {
			Result memory result = results[i];
			call = callInfo[i];
			(result.success, result.returnData) = call.target.call(
				call.callData
			);
			if (!result.success) {
				revert("call failed");
			}
		}
		return results;
	}
}
