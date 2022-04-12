// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {MooniswapManager, IMooniswapManager} from "../MooniswapManager.sol";

contract MooniswapManagerMock is MooniswapManager {

    function IMooniswapManagerInterfaceId()
        external
        pure
        returns (bytes4 interfaceId)
    {
        interfaceId = type(IMooniswapManager).interfaceId;
    }

    function getPoolAddressFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.getPoolAddress.selector;
    }

    function getBalanceFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.getBalance.selector;
    }

    function swapFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.swap.selector;
    }

    function depositFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.deposit.selector;
    }

    function withdrawFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.withdraw.selector;
    }
}
