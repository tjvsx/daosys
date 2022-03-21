// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

library Uint256 {

  struct Layout {
    uint256 value;
  }

  /*
  NOTE Implemented here as the binding of the Layout struct is tightly coupled
    to the binding of a storage slot.
   */
  function _layout( bytes32 slot ) pure internal returns ( Uint256.Layout storage layout ) {
    assembly{ layout.slot := slot }
  }

}
/* -------------------------------------------------------------------------- */
/*                              !SECTION UINT256                              */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Uint256Utils                            */
/* -------------------------------------------------------------------------- */

library Uint256Utils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Uint256).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( Uint256.Layout storage layout ) {
    layout = Uint256._layout(slot);
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Uint256Utils                           */
/* -------------------------------------------------------------------------- */
