import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

/**
 * Deploys a contract named "YourContract" using the deployer account and
 * constructor arguments set to the deployer address
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  /*
    On localhost, the deployer account is the one that comes with Hardhat, which is already funded.

    When deploying to live networks (e.g `yarn deploy --network sepolia`), the deployer account
    should have sufficient balance to pay for the gas fees for contract creation.

    You can generate a random account with `yarn generate` which will fill DEPLOYER_PRIVATE_KEY
    with a random private key in the .env file (then used on hardhat.config.ts)
    You can run the `yarn account` command to check your balance in every network.
  */
  // const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  // await deploy("YourContract", {
  //   from: deployer,
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Receive", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("MyToken", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Faucet", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: ["0x59e144DE9B86795AB8eB8F4211744Ff97E5BC21e"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("AirDrop", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: ["0x59e144DE9B86795AB8eB8F4211744Ff97E5BC21e"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("WAIA", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  await deploy("Donate", {
    from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
    // Contract constructor arguments
    args: [],
    log: true,
    // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
    // automatically mining the contract deployment transaction. There is no effect on live networks.
    autoMine: true,
  });
  // await deploy("A", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("TokenOne", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("TokenZero", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Dex", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: ["0x5041dfa0364C1A6F5417aD68BA64d154B449AaCB", "0xa21b3dC204cD773bbE8795059aa00F435871f603"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("MultiCall", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await verify(AContract.address, []);
  // await deploy("B", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Caller", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: ["0x86c66D19b87351c1AD7125889Bcb382f5baFABc7"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Proxy", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: ["0x6b8AcB313683B03ED861Cd3504BAfe8001710818"],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
  // await deploy("Logic", {
  //   from: "0x6080D00fc35A843eBeA436B4E2244fEE552595a6",
  //   // Contract constructor arguments
  //   args: [],
  //   log: true,
  //   // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
  //   // automatically mining the contract deployment transaction. There is no effect on live networks.
  //   autoMine: true,
  // });
};

export default deployYourContract;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
deployYourContract.tags = ["YourContract"];
