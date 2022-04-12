// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import {Address, AddressUtils} from "../../../types/primitives/Address.sol";

import {Uint256Array, Uint256ArrayUtils} from "../../../types/collections/arrays/Uint256Array.sol";

library MooniswapManagerStorage {
    struct Layout {
        Address.Layout mooniswapPairAddress;
        mapping(address => uint256[2]) tokenWallet;
    }
}

library MooniswapManagerStorageUtils {
    using MooniswapManagerStorageUtils for MooniswapManagerStorage.Layout;
    using AddressUtils for Address.Layout;

    bytes32 private constant STRUCT_STORAGE_SLOT =
        keccak256(type(MooniswapManagerStorage).creationCode);

    function _structSlot() internal pure returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    function _layout(bytes32 salt)
        internal
        view
        returns (MooniswapManagerStorage.Layout storage layout)
    {
        console.log(
            "MooniswapManagerStorage:_layout:: tokenWallet storage slot: ",
            address(bytes20(Uint256ArrayUtils._structSlot()))
        );

        console.log(
            "MooniswapManagerStorage:_layout:: mooniswapPairAddress storage slot: ",
            address(bytes20(AddressUtils._structSlot()))
        );

        console.log(
            "MooniswapManagerStorage:_layout:: Salting storage slot with: ",
            address(bytes20(salt))
        );
        bytes32 saltedSlot = salt ^
            MooniswapManagerStorageUtils._structSlot() ^
            AddressUtils._structSlot() ^
            Uint256ArrayUtils._structSlot();

        console.log(
            "MooniswapManagerStorage:_layout:: Using storage slot: ",
            address(bytes20(saltedSlot))
        );
        assembly {
            layout.slot := saltedSlot
        }
    }

    function _setMooniswapPoolAddress(
        MooniswapManagerStorage.Layout storage layout,
        address mooniPoolAddr
    ) internal {
        layout.mooniswapPairAddress._setValue(mooniPoolAddr);
    }

    function _setTokenWallet(
        MooniswapManagerStorage.Layout storage layout,
        address usrAddr,
        uint256[2] memory tokenBalances
    ) internal {
        layout.tokenWallet[usrAddr] = tokenBalances;
    }

    function _getTokenWallet(
        MooniswapManagerStorage.Layout storage layout,
        address usrAddr
    ) internal view returns (uint256[2] memory tokenPair) {
        if (layout.tokenWallet[usrAddr].length == 0) {
            uint256[2] memory newUsrBalances;
            tokenPair = newUsrBalances;
        } else {
            tokenPair = layout.tokenWallet[usrAddr];
        }
    }

    function _getMooniswapPoolAddress(
        MooniswapManagerStorage.Layout storage layout
    ) internal view returns (address poolAddress) {
        poolAddress = layout.mooniswapPairAddress._getValue();
    }
}
