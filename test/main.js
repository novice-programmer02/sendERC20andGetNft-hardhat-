
const { expect } = require("chai");

describe("Contract", function () {
  let Robot;
  let Test1;
  let Test2
  let Main
  let test1;
  let test2;
  let robot;
  let t1;
  let t2;
  let nft;
  let mnaddr;

  beforeEach(async function () {
    const [owner, user1] = await ethers.getSigners();

     Robot = await ethers.getContractFactory("myERC721");
     Main = await ethers.getContractFactory("sendNFT");
     Test1 = await ethers.getContractFactory("token1");
     Test2 = await ethers.getContractFactory("token2");

     robot = await Robot.deploy();
     test1 = await Test1.deploy();
     test2 = await Test2.deploy();
    main = await Main.deploy(robot.address, test1.address, test2.address);

    t1= test1.address;
    t2= test2.address;
    nft = robot.address;
    mnaddr= main.address;

    await robot.transferOwnership(mnaddr);

    await test1.connect(user1)._mint(user1.address, 1000);
    await test2.connect(user1).mint(user1.address, 1000);

    await test1.connect(user1).approve(main.address, 1000);
    await test2.connect(user1).approve(main.address, 1000);
    
    
    [Robot, Test1, Test2, Main] = await ethers.getSigners();
  });

  describe("Transactions", function () {

    it("should ERC20 tokens are minted to the owner address", async function(){
        const [owner, user1] = await ethers.getSigners();

      //   await test1.connect(user1)._mint(user1.address, 1000);
      //   await test2.connect(user1).mint(user1.address, 1000);

      //  await test2.connect(user1).approve(main.address, 1000);
      // await test2.connect(user1).approve(main.address, 1000);

        await main.connect(user1).getNFT(100,200);

        const tok1 = await test1.balanceOf(main.address);
        const tok2 = await test2.balanceOf(main.address );

        console.log(tok1.toNumber());
        console.log(tok2.toNumber());

        expect(tok1.toNumber()).to.equal(100);
        expect(tok2.toNumber()).to.equal(200);

    });

    it("should 1nft send to the user accounts", async function() {
        const [owner, user1] = await ethers.getSigners();

      //   await test1.connect(user1)._mint(user1.address, 1000);
      // await test2.connect(user1).mint(user1.address, 1000);

      // await test2.connect(user1).approve(main.address, 1000);
      // await test2.connect(user1).approve(main.address, 1000);

        await main.connect(user1).getNFT(100,200);

        const balanceuser = await robot.balanceOf(user1.address)

        console.log(balanceuser.toNumber());
        expect(balanceuser.toNumber()).to.equal(1);
 
      });
  });
});