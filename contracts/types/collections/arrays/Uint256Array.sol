// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

library Uint256Array {
    struct Enumerable {
        uint256[] _values;
    }

    struct Layout {
        Uint256Array.Enumerable uint256Array;
    }
}

library Uint256ArrayUtils {
    using Uint256ArrayUtils for Uint256Array.Enumerable;

    bytes32 internal constant STRUCT_STORAGE_SLOT =
        keccak256(type(Uint256Array).creationCode);

    function _structSlot() internal pure returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    /**
     * @notice Could be optimized by having the exposing interface caclulate and store
     *  the storage slot as a constant.
     *  Storage slot is computed during runtime to facilitate development during
     *  standardization.
     */

    function _layout(bytes32 salt)
        internal
        pure
        returns (Uint256Array.Layout storage layout)
    {
        bytes32 saltedSlot = salt ^ Uint256ArrayUtils._structSlot();
        assembly {
            layout.slot := saltedSlot
        }
    }


}
