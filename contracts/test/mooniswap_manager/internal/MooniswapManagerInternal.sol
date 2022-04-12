// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {IMooniswapManager} from "../interfaces/IMooniswapManager.sol";
import "../../protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "../../protocols/dexes/mooniswap/Mooniswap.sol";
import {MooniswapManagerStorage, MooniswapManagerStorageUtils} from "../storage/MooniswapManagerStorage.sol";

abstract contract MooniswapManagerInternal {
    using MooniswapManagerStorageUtils for MooniswapManagerStorage.Layout;

    event SwapExecution(
        Mooniswap indexed _mooniswapPool,
        address indexed _userAddress,
        IERC20 _fromToken,
        IERC20 _toToken,
        uint256 _fromAmount,
        uint256 _minReturn,
        address _referral
    );


    event Deposit(IERC20 aToken, uint256 amountDeposited);
    event Withdraw(IERC20 aToken, uint256 amountDeposited);

    function _getBalance(bytes32 storageSlotSalt, address usrAddr)
        internal
        view
        returns (uint256[2] memory balance)
    {
        balance = MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._getTokenWallet(usrAddr);
    }

    function _getPoolAddress(bytes32 storageSlotSalt)
        internal
        view
        returns (address poolAddress)
    {
        poolAddress = MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._getMooniswapPoolAddress();
    }

    function _setBalance(
        bytes32 storageSlotSalt,
        address usrAddr,
        uint256[2] memory tokenBalances
    ) internal {
        MooniswapManagerStorageUtils._layout(storageSlotSalt)._setTokenWallet(
            usrAddr,
            tokenBalances
        );
    }

    function _setMooniswapPoolAddress(
        bytes32 storageSlotSalt,
        address poolAddress
    ) internal {
        MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._setMooniswapPoolAddress(poolAddress);
    }

    function _deposit(
        bytes32 storageSlotSalt,
        IERC20 tkn,
        uint256 amount
    ) internal {
        // are we allowed to use the token?
        uint256 allowance = tkn.allowance(msg.sender, address(this));
        require(allowance >= amount, "Token allowance too low.");
        // is this token in the mooniswap pool?
        Mooniswap mooniswapContract = Mooniswap(
            _getPoolAddress(storageSlotSalt)
        );
        IERC20[] memory allowedTokens = mooniswapContract.getTokens();
        require(
            address(allowedTokens[0]) == address(tkn) ||
                address(allowedTokens[1]) == address(tkn),
            "Token not in Mooniswap pool."
        );
        // alright, complete the deposit
        tkn.transferFrom(msg.sender, address(this), amount);
        uint256[2] memory tokenWallet = _getBalance(
            storageSlotSalt,
            msg.sender
        );
        uint256 srcIdx = address(allowedTokens[0]) == address(tkn) ? 0 : 1;
        tokenWallet[srcIdx] += amount;
        _setBalance(storageSlotSalt, msg.sender, tokenWallet);
        emit Deposit(tkn, amount);
    }

    function _withdraw(bytes32 storageSlotSalt, IERC20 tkn, uint256 amount) internal {}

    function _swap(
        bytes32 storageSlotSalt,
        IERC20 src,
        uint256 amount,
        uint256 minReturn,
        address ref
    ) internal {
        Mooniswap mooniswapContract = Mooniswap(
            _getPoolAddress(storageSlotSalt)
        );
        IERC20[] memory allowedTokens = mooniswapContract.getTokens();
        uint256[2] memory tokenWallet = _getBalance(
            storageSlotSalt,
            msg.sender
        );

        // is the token in the pool?
        require(
            address(allowedTokens[0]) == address(src) ||
                address(allowedTokens[1]) == address(src),
            "Token not in Mooniswap pool."
        );
        // are we going from token A to B or B to A?
        uint256 srcIdx = address(allowedTokens[0]) == address(src) ? 0 : 1;
        // do we have enough in our pocket to complete a swap?
        require(tokenWallet[srcIdx] >= amount, "Insufficent pocket balance.");

        // are we estimated to get the minimum amount we specified?
        IERC20 dst = allowedTokens[(srcIdx + 1) % 2];
        if (minReturn != 0) {
            require(
                minReturn <= mooniswapContract.getReturn(src, dst, amount),
                "return below minReturn amount"
            );
        }

        // alright, do the swap...
        src.approve(address(mooniswapContract), amount);
        uint256 result = mooniswapContract.swap(
            src,
            dst,
            amount,
            minReturn,
            ref
        );

        // and update balances
        tokenWallet[srcIdx] -= amount;
        tokenWallet[(srcIdx + 1) % 2] += result;
        _setBalance(storageSlotSalt, msg.sender, tokenWallet);

        emit SwapExecution(
            mooniswapContract,
            msg.sender,
            src,
            dst,
            amount,
            minReturn,
            ref
        );
    }
}
