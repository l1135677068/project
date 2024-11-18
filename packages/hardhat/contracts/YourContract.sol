//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import { VRFConsumerBaseV2Plus } from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import { VRFV2PlusClient } from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";
import "hardhat/console.sol";

/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author luohanxiong
 */
contract YourContract {
	// State Variables
	address private immutable owner;
	address[] public winnerAddress;
	// 确定的数组
	uint256[] public numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	// min price
	uint256 public minimumPrice = 0.0001 ether;
	uint256 public minimumParticipantNumber = 2;
	uint256 public participantNumber;
	// address -> selected number
	mapping(address => uint256[]) public lotteryMap;
	// lotteryMap's address
	address[] public addressKeysArray;
	address[] public participantAddress;
	uint256 public winnerNumber;
	uint256 bonus;

	constructor() {
		owner = msg.sender;
	}

	function setBouns() internal {
		bonus = address(this).balance;
	}

	// record the address key
	function setKeyValue(
		address payable key,
		uint256[] memory value,
		bool isFirstBuy
	) internal {
		if (isFirstBuy) {
			lotteryMap[key] = value;
			addressKeysArray.push(key);
		} else {
			uint256[] memory oldValue = lotteryMap[key];
			uint256[] memory newValue = new uint256[](
				oldValue.length + value.length
			);
			for (uint i = 0; i < oldValue.length; i++) {
				newValue[i] = oldValue[i];
			}
			lotteryMap[key] = newValue;
		}
	}

	function getRandomNumber() internal returns (uint256) {
		uint256 tempNumber = uint256(
			keccak256(
				abi.encodePacked(
					block.prevrandao,
					block.timestamp,
					participantNumber
				)
			)
		) % 10;
		winnerNumber = tempNumber;
		return tempNumber;
	}

	function checkIsFirstBuy(address ars) internal view returns (bool) {
		for (uint i = 0; i < addressKeysArray.length; i++) {
			if (addressKeysArray[i] == ars) {
				return false;
			}
		}
		return true;
	}

	// participate the lottery
	function participate(uint256[] memory selectedNumber) public payable {
		require(
			msg.value >= minimumPrice * selectedNumber.length,
			"insufficient Ether value sent"
		);
		// check if the address is the first time to buy
		bool isFirstBuy = checkIsFirstBuy(msg.sender);
		if (isFirstBuy) {
			participantAddress.push(msg.sender);
			participantNumber++;
		}
		setKeyValue(payable(msg.sender), selectedNumber, isFirstBuy);
		setBouns();
	}

	function testGetWinnerNumber() public {
		getRandomNumber();
	}

	// only contract owner can start select the winner
	function selectWinner() public isOwner {
		require(
			participantNumber >= minimumParticipantNumber,
			"insufficient participant"
		);
		uint256 number = getRandomNumber();
		for (uint i = 0; i < addressKeysArray.length; i++) {
			uint256[] memory numberArray = lotteryMap[addressKeysArray[i]];
			for (uint j = 0; j < numberArray.length; j++) {
				if (numberArray[j] == number) {
					winnerAddress.push(addressKeysArray[i]);
				}
			}
		}
	}

	modifier isOwner() {
		// msg.sender: predefined variable that represents address of the account that called the current function
		require(msg.sender == owner, "Not the Owner");
		_;
	}

	// transfer the funds to the winner
	function transferFunds() public isOwner {
		require(address(this).balance > 0, "Insufficient contract balance");
		require(winnerAddress.length > 0, "No winner");
		uint256 winnerAddressLength = winnerAddress.length;
		uint256 transferAmount = address(this).balance / winnerAddressLength;
		for (uint256 i = 0; i < winnerAddress.length; i++) {
			payable(winnerAddress[i]).transfer(transferAmount);
		}
	}

	function withdraw() public isOwner {
		require(address(this).balance > 0, "Insufficient contract balance");
		payable(owner).transfer(address(this).balance);
	}

	/**
	 * Function that allows the contract to receive ETH
	 */
	receive() external payable {}
}
