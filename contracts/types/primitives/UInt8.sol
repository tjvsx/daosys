// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

library UInt8 {

  struct Layout {
    uint8 value;
  }

}
/* -------------------------------------------------------------------------- */
/*                              !SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Uint256Utils                            */
/* -------------------------------------------------------------------------- */

library UInt8Utils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt8).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( UInt8.Layout storage layout ) {
    bytes32 saltedSlot = salt
      ^ UInt8Utils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Uint256Utils                           */
/* -------------------------------------------------------------------------- */