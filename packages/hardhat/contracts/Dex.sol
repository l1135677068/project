//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dex is ERC20 {
	address owner;
	IERC20 token0;
	IERC20 token1;

	// 代币储备量
	uint256 public reserve0;
	uint256 public reserve1;

	event Burn(
		uint256 tokenZeroAmount,
		uint256 tokenOneAmount,
		uint256 lpAmount,
		address provider
	);

	event Mint(
		uint256 tokenZeroAmount,
		uint256 tokenOneAmount,
		uint256 lpAmount,
		address provider
	);

	event Swap(
		address sender,
		uint256 amountIn,
		IERC20 tokenIn,
		uint256 amountOut,
		IERC20 tokenOut
	);

	// 构造器，初始化支持交易的代币地址
	constructor(IERC20 _token0, IERC20 _token1) ERC20("Dex", "Dex") {
		token0 = _token0;
		token1 = _token1;
	}

	// 取两个数的最小值
	function min(uint x, uint y) internal pure returns (uint z) {
		z = x < y ? x : y;
	}

	// 计算平方根
	function sqrt(uint y) internal pure returns (uint z) {
		if (y > 3) {
			z = y;
			uint x = y / 2 + 1;
			while (x < z) {
				z = x;
				x = (y / x + x) / 2;
			}
		} else if (y != 0) {
			z = 1;
		}
	}

	// 添加流动性
	function addLiquidity(
		uint256 amount0,
		uint256 amount1
	) public returns (uint256 lpAmount) {
		// 委托
		token0.transferFrom(msg.sender, address(this), amount0);
		token1.transferFrom(msg.sender, address(this), amount1);

		// 流动性份额
		lpAmount = 0;
		uint256 _totalSupply = totalSupply();
		if (_totalSupply == 0) {
			lpAmount = (amount0 * amount1);
		} else {
			lpAmount =
				_totalSupply *
				min(amount0 / reserve0, amount1 / reserve1);
		}

		// 检查流动性是否大于0
		require(lpAmount > 0, "INSUFFICIENT_LIQUIDITY_MINTED");
		// 为什么不是相加？
		reserve0 = token0.balanceOf(address(this));
		reserve1 = token1.balanceOf(address(this));

		//  铸造LP代币
		_mint(msg.sender, lpAmount);
		emit Mint(amount0, amount1, lpAmount, msg.sender);
	}

	// 移除流动性
	function removeLiquidity(
		uint256 lpAmount
	) public returns (uint256 amount0, uint256 amount1) {
		// 获取余额
		uint256 balance0 = token0.balanceOf(address(this));
		uint256 balance1 = token1.balanceOf(address(this));

		// 要转出的代币数量
		uint256 totalLp = totalSupply();
		amount0 = (balance0 * lpAmount) / totalLp;
		amount1 = (balance1 * lpAmount) / totalLp;

		// 检查代币数量
		require(amount0 > 0 && amount1 > 0, "INSUFFICIENT_LIQUIDITY_BURNED");

		// 销毁Lp
		_burn(msg.sender, lpAmount);
		// 转移代币
		token0.transfer(msg.sender, amount0);
		token1.transfer(msg.sender, amount1);

		emit Burn(amount0, amount1, lpAmount, msg.sender);
	}

	// 交易数量
	function getSwapAmountOut(
		uint256 amountIn,
		uint256 reserveIn,
		uint256 reserveOut
	) public pure returns (uint256 amountOut) {
		require(amountIn > 0, "INSUFFICIENT_INPUT_AMOUNT");
		require(reserveIn > 0 && reserveOut > 0, "INSUFFICIENT_LIQUIDITY");
		amountOut = (amountIn * reserveOut) / (reserveIn + amountIn);
		return amountOut;
	}

	// 交易
	function swap(
		uint256 amountIn,
		IERC20 tokenIn,
		uint256 minAmountOut
	) public returns (uint amountOut, IERC20 tokenOut) {
		require(amountIn > 0, "INSUFFICIENT_INPUT_AMOUNT");
		require(tokenIn == token0 || tokenIn == token1, "INVALID_TOKEN");

		// 代币余额
		uint256 balance0 = token0.balanceOf(address(this));
		uint256 balance1 = token1.balanceOf(address(this));
		// token0 交换token1
		if (tokenIn == token0) {
			tokenOut = token1;
			amountOut = getSwapAmountOut(amountIn, balance0, balance1);
		} else {
			// token1 交换token0
			tokenOut = token0;
			amountOut = getSwapAmountOut(amountIn, balance1, balance0);
		}

		require(amountOut > minAmountOut, "INSUFFICIENT_OUTPUT_AMOUNT");
		// 转移代币
		tokenIn.transferFrom(msg.sender, address(this), amountIn);
		tokenOut.transfer(msg.sender, amountOut);
		// 更新储备量
		reserve0 = token0.balanceOf(address(this));
		reserve1 = token1.balanceOf(address(this));

		emit Swap(msg.sender, amountIn, tokenIn, amountOut, tokenOut);
	}
}
