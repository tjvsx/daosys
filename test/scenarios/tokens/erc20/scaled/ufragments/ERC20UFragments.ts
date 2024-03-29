import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ERC20UFragments,
  ERC20UFragments__factory
} from '../../../../../../typechain';

describe("ERC20UFragments", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  let spender: SignerWithAddress;

  // ERC20Basic test variables
  let token: ERC20UFragments;
  const tokenName = "TestToken";
  const tokenSymbol = "TT";
  const tokenDecimals = 9;
  const tokenSupply = ethers.utils.parseUnits("340282366920938463463374607431.768211455", "gwei");

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */
  beforeEach(async function () {

    [
      deployer,
      spender
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";
    tracer.nameTags[spender.address] = "Spender";

    token = await new ERC20UFragments__factory(deployer).deploy();
    tracer.nameTags[token.address] = "Test Token";

  });

  /* -------------------------------------------------------------------------- */
  /*                       SECTION Testing ERC20UFragments                      */
  /* -------------------------------------------------------------------------- */

  describe("ERC20UFragments", function () {
    describe("#name()", function () {
      it("Can read name", async function () {
        await token.initialize(tokenName, tokenSymbol);
        expect(await token.name()).to.equal(tokenName);
      });
    });

    describe("#symbol()", function () {
      it("Can read symbol", async function () {
        await token.initialize(tokenName, tokenSymbol);
        expect(await token.symbol()).to.equal(tokenSymbol);
      });
    });

    describe("#decimals()", function () {
      it("Can read symbol", async function () {
        await token.initialize(tokenName, tokenSymbol);
        expect(await token.decimals()).to.equal(tokenDecimals);
      });
    });

    describe("#approve()", function () {
      describe("(address,uint256)", function () {
        describe("#allowance()", function () {
          it("Can set and read name.", async function () {
            await token.initialize(tokenName, tokenSymbol);
            await token.connect(deployer).approve(spender.address, 100);
            expect(await token.allowance(deployer.address, spender.address)).to.equal(100);
          });
          it("Emits Approval event.", async function () {
            await token.initialize(tokenName, tokenSymbol);
            expect(token.connect(deployer).approve(spender.address, 100))
              .to.emit(token, "Approval")
              .withArgs(deployer.address, spender.address, 100);
          });
        });
      });
    });
    
    describe("#totalSupply()", function () {
      describe("(address)", function () {
        it("Reports total supply correctly", async function () {
          await token.initialize(tokenName, tokenSymbol);
          expect(await token.connect(deployer).totalSupply())
            .to.equal(tokenSupply);
        });
      });
    });
    describe("#balanceOf()", function () {
      describe("(address)", function () {
        it("Reports balance correctly", async function () {
          await token.initialize(tokenName, tokenSymbol);
          expect(await token.connect(deployer).balanceOf(deployer.address))
            .to.equal(tokenSupply);
        });
      });
    });
    describe("#transfer()", function () {
      describe("(address,uint256)", function () {
        it("Account can transfer tokens", async function () {
          await token.initialize(tokenName, tokenSymbol);
          await expect(() => token.connect(deployer)
            .transfer(
              spender.address,
              ethers.utils.parseUnits("100.0", "gwei")
            )
          ).to.changeTokenBalances(
            token,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "gwei"),
              ethers.utils.parseUnits("100.0", "gwei")
            ]
          )
        });
      });
    });
    describe("#transferFrom()", function () {
      describe("(address,address,uint256)", function () {
        it("Spender can transfer tokens for another account", async function () {
          await token.initialize(tokenName, tokenSymbol);
          await token.connect(deployer)
            .approve(spender.address, ethers.utils.parseUnits("100.0", "gwei"));
          expect(await token.allowance(deployer.address, spender.address))
            .to.equal(ethers.utils.parseUnits("100.0", "gwei"));
          await expect(() => token.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "gwei")
            )
          ).to.changeTokenBalances(
            token,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "gwei"),
              ethers.utils.parseUnits("100.0", "gwei")
            ]
          );
        });
        it("Spender can not transfer more tokens than approved for another account", async function () {
          await token.initialize(tokenName, tokenSymbol);
          await token.connect(deployer)
            .approve(spender.address, 100);
          expect(await token.allowance(deployer.address, spender.address))
            .to.equal(100);
          await expect(token.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "gwei")
            )
          ).to.be.revertedWith(
            "ERC20: msg.sender is not approved for transfer."
          );
        });
      });
    });
    describe("#rebase()", function () {
      describe("(address,uint256)", function () {
        it("Account can transfer tokens", async function () {
          await token.initialize(tokenName, tokenSymbol);
          await expect(() => token.connect(deployer)
            .rebase(
              ethers.utils.parseUnits(
                String(tokenSupply.sub(tokenSupply.sub(1))),
               "gwei")
            )
          ).to.changeTokenBalances(
            token,
            [
              deployer
            ],
            [
              ethers.utils.parseUnits(String(tokenSupply.sub(tokenSupply.sub(1))), "gwei")
            ]
          )
        });
      });
    });
  });

  /* -------------------------------------------------------------------------- */
  /*                      !SECTION Testing ERC20UFragments                      */
  /* -------------------------------------------------------------------------- */

});