import { expect } from "chai";
import { ethers } from "hardhat";
import { YourContract } from "../typechain-types";

const twoSufficientSendValue = ethers.parseEther("0.0002");
const oneSufficientSendValue = 0.0001;
describe("YourContract", function () {
  // We define a fixture to reuse the same setup in every test.

  let yourContract: YourContract;
  before(async () => {
    const yourContractFactory = await ethers.getContractFactory("YourContract");
    // deploy (constructor args)
    yourContract = (await yourContractFactory.deploy()) as YourContract;
    await yourContract.waitForDeployment();
  });

  describe("Deployment", function () {
    it("owner shoule be 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", async function () {
      const owner = await yourContract.getOwner();
      expect(owner).to.equal("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");
    });

    describe("Participation", async function () {
      it("insufficient Ether value sent", async function () {
        await expect(yourContract.participate([1, 1])).to.be.revertedWith("insufficient Ether value sent");
        await expect(
          yourContract.participate([1, 1], { value: ethers.parseEther(oneSufficientSendValue.toString()) }),
        ).to.be.revertedWith("insufficient Ether value sent");
      });
      it("first buy", async function () {
        await yourContract.participate([1, 1], {
          value: ethers.parseEther((oneSufficientSendValue * 2).toString()),
        });
        const bonus = await yourContract.getBonus();
        const owner = await yourContract.getOwner();
        const participantNumber = await yourContract.getParticipantNumber();
        const participantAddress = await yourContract.getParticipantAddress();
        const ownerSelectNumber = await yourContract.getLotteryMap(owner);
        const addressKeysArray = await yourContract.getAddressKeysArray();
        expect(bonus).to.equal(twoSufficientSendValue); // 0.0002
        expect(participantNumber).to.equal(1);
        expect(participantAddress[0]).to.equal(owner);
        expect(addressKeysArray[0]).to.equal(owner);
        // deep compare
        expect(ownerSelectNumber).to.deep.equal([1, 1]);
      });
    });
    describe("random number ", async function () {
      it("randow number shoule less than 10, greater than 0", async function () {
        await yourContract.testGetWinnerNumber();
        const randomNumber = await yourContract.getWinnerNumber();
        console.log(randomNumber, "randomNumber");
        expect(randomNumber).to.be.lessThan(10);
      });
    });
  });
});
