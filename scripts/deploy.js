
async function main() {
const [owner] = await ethers.getSigners();

console.log("Deploying contracts with the account:", owner.address);

console.log("Account balance:", (await owner.getBalance()).toString());

const Robot = await ethers.getContractFactory("myERC721");
const Test1 = await ethers.getContractFactory("token1");
const Test2 = await ethers.getContractFactory("token2");
const Main = await ethers.getContractFactory("sendNFT");

const robot = await Robot.deploy();
const test1 = await Test1.deploy();
const test2 = await Test2.deploy();
const main = await Main.deploy(robot.address, test1.address, test2.address);

console.log("robot address:", robot.address);
console.log("test1 address:", test1.address);
console.log("test2 address:", test2.address);
console.log("main address:", main.address);

}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1);
});