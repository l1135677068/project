//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract TokenOne is ERC20 {
	address private owner;

	constructor() ERC20("TokenOne", "TKO") {
		_mint(msg.sender, 100000);
	}
}
