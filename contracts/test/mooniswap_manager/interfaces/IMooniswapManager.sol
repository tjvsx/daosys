// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../../protocols/dexes/mooniswap/erc20/IERC20.sol";
import { Mooniswap } from "../../protocols/dexes/mooniswap/Mooniswap.sol";


interface IMooniswapManager {

    function getPoolAddress() external view returns(address poolAddress);
    function getBalance(address userAddress) external view returns(uint256[2] memory pairBalance);
    
    function swap(IERC20 srcToken, uint256 amountSwap, uint256 minAmount, address ref) external payable;
    function deposit(IERC20 aToken, uint256 amountDeposited) external payable;
    function withdraw(IERC20 aToken, uint256 amountDeposited) external;
}