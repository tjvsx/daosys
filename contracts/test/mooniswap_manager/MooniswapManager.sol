// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./interfaces/IMooniswapManager.sol";
import "./internal/MooniswapManagerInternal.sol";
import "../protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "../protocols/dexes/mooniswap/Mooniswap.sol";

contract MooniswapManager is IMooniswapManager, MooniswapManagerInternal {

    function getBalance(address usrAddr)
        external
        view
        virtual
        override(IMooniswapManager)
        returns (uint256[2] memory balance)
    {
        balance = _getBalance(type(IMooniswapManager).interfaceId, usrAddr);
    }

    function getPoolAddress()
        external
        view
        virtual
        override(IMooniswapManager)
        returns (address poolAddress)
    {
        poolAddress = _getPoolAddress(type(IMooniswapManager).interfaceId);
    }

    function deposit(IERC20 tkn, uint256 amount)
        external
        payable
        override(IMooniswapManager)
    {
        _deposit(type(IMooniswapManager).interfaceId, tkn, amount);
    }

    function withdraw(IERC20 tkn, uint256 amount)
        external
        override(IMooniswapManager)
    {
        _withdraw(type(IMooniswapManager).interfaceId, tkn, amount);
    }

    function swap(
        IERC20 src,
        uint256 amount,
        uint256 minReturn,
        address ref
    ) external payable override(IMooniswapManager) {
        _swap(type(IMooniswapManager).interfaceId, src, amount, minReturn, ref);
    }
}
