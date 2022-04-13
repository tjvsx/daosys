// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

library UInt256 {

  struct Layout {
    uint256 value;
  }

}
/* -------------------------------------------------------------------------- */
/*                              !SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Uint256Utils                            */
/* -------------------------------------------------------------------------- */

library UInt256Utils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt256).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( UInt256.Layout storage layout ) {
    bytes32 saltedSlot = salt
      ^ UInt256Utils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _setValue(
    UInt256.Layout storage layout,
    uint256 newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    UInt256.Layout storage layout
  ) view internal returns (uint256 value) {
    value = layout.value;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Uint256Utils                           */
/* -------------------------------------------------------------------------- */
