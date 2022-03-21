import { expect } from 'chai';
import { ethers, tracer } from 'hardhat';

import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

import {
    Mooniswap,
    MooniFactory,
    MooniFactory__factory,
    Mooniswap__factory,
    // ERC20__factory,
    // ERC20,
    MooniMockERC20,
    MooniMockERC20__factory,
    ERC20Managed,
    ERC20Managed__factory,
    WETH9,
    WETH9__factory,
    IERC20
} from '../../../../../typechain';
import { trace } from 'console';
import exp from 'constants';

import { initializeMooniswap, createMooniswapPair, mooniswapPairCreateArgs } from '../../../../fixtures/mooniswap.fixture'



describe("Mooniswap", () => {


    let deployer: SignerWithAddress;
    let tek: ERC20Managed;
    let weth: WETH9;
    let stablecoin: MooniMockERC20;
    let mooniswap: MooniFactory;
    let tekStablePair: Mooniswap;
    let pairAddressTekWeth: string;
    let pairAddressTekStablecoin: string;
    let pairAddressWethStablecoin: string;


    beforeEach(async () => {
        [deployer] = await ethers.getSigners();

        tek = await new ERC20Managed__factory(deployer).deploy(
            "TEK",
            "TEK",
            9,
            ethers.utils.parseEther("100")
        );

        tracer.nameTags[tek.address] = "TEK"

        weth = await new WETH9__factory(deployer).deploy();

        tracer.nameTags[weth.address] = "WETH"

      stablecoin = await new MooniMockERC20__factory(deployer).deploy(
            ethers.utils.parseEther("1000000000")
        );

        tracer.nameTags[stablecoin.address] = 'StableCoin'

        mooniswap = await initializeMooniswap({ deployer });

        tracer.nameTags[mooniswap.address] = "MooniswapFactory"

        tekStablePair = await createMooniswapPair({ factory: mooniswap, token0: tek as unknown as IERC20, token1: stablecoin as unknown as IERC20 });

        tracer.nameTags[tekStablePair.address] = "TEK/STABLE"
    });

    it("deployed contracts has proper address", async () => {
        expect(tek.address).to.be.properAddress;
        expect(weth.address).to.be.properAddress;
        expect(stablecoin.address).to.be.properAddress;
        expect(mooniswap.address).to.be.properAddress;
        expect(tekStablePair.address).to.be.properAddress;
    })

    // it("mint lp tokens work correctly", async () => {
    //     await expect(tek.approve(tekStablePair.address, ethers.utils.parseUnits("5", 9))).not.reverted;
    //     await expect(stablecoin.approve(tekStablePair.address, ethers.utils.parseUnits("10000", await stablecoin.decimals()))).not.reverted;


    //     expect((await tek.allowance(deployer.address, tekStablePair.address)).toString() === ethers.utils.parseUnits("5", 9).toString()).is.true;

    //     expect((await stablecoin.allowance(deployer.address, tekStablePair.address)).toString() === ethers.utils.parseUnits("10000", await stablecoin.decimals()).toString()).is.true;

    //     const tx = await tekStablePair.connect(deployer).deposit([
    //         ethers.utils.parseUnits("5", await tek.decimals()),
    //         ethers.utils.parseUnits("5", await stablecoin.decimals())
    //     ], [
    //         ethers.utils.parseUnits("0", await tek.decimals()),
    //         ethers.utils.parseUnits("0", await stablecoin.decimals())
    //     ]);

    //     const lpBalanceOf = await tekStablePair.connect(deployer).balanceOf(deployer.address);

    //     expect(lpBalanceOf.toString()).to.be.equal(ethers.utils.parseUnits("5", await tekStablePair.connect(deployer).decimals()));
    // })

})