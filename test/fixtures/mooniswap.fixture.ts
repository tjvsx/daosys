import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

import {
    Mooniswap,
    MooniFactory,
    MooniFactory__factory,
    Mooniswap__factory,
    ERC20__factory,
    ERC20,
    ERC20Managed,
    ERC20Managed__factory,
    WETH9,
    WETH9__factory,
    IERC20
} from '../../typechain';
import { trace } from 'console';
import exp from 'constants';
import { BigNumber, ethers } from 'ethers';

export interface mooniswapInitializeArgs {
    deployer: SignerWithAddress
}


export const initializeMooniswap = async (params: mooniswapInitializeArgs) => {
    return await new MooniFactory__factory(params.deployer).deploy();
}

export interface mooniswapPairCreateArgs {
    factory: MooniFactory,
    token0: IERC20,
    token1: IERC20,
}

export const createMooniswapPair = async (params: mooniswapPairCreateArgs): Promise<Mooniswap> => {
    const tx = await params.factory.deploy(
        params.token0.address,
        params.token1.address
    )

    const pool = await params.factory.pools(params.token0.address, params.token1.address);

    return new Mooniswap__factory().attach(pool);
}


export interface addLiquidityArgs {
    sender: SignerWithAddress,
    mooniswap: Mooniswap,
    token0: IERC20,
    amount0: BigNumber,

}

export const addLiquidity = async (params: addLiquidityArgs) => {
    const mooni = params.mooniswap

    const approval = await params.token0.connect(params.sender).approve(mooni.address, params.amount0);

    const deposit = await mooni.deposit([params.amount0], [], {value: ethers.utils.parseEther("1")});

    console.log(approval, deposit)

}

export interface removeLiquidityArgs {}

export const removeLiquidity = () => {}
