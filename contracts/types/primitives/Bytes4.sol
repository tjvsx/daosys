// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;


/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4                                 */
/* -------------------------------------------------------------------------- */

library Bytes4 {

  struct Layout {
    bytes4 value;
  }

  /*
  NOTE Implemented here as the binding of the Layout struct is tightly coupled
    to the binding of a storage slot.
   */
  function _layout( bytes32 slot ) pure internal returns ( Bytes4.Layout storage layout ) {
    assembly{ layout.slot := slot }
  }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes4                                */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4Utils                            */
/* -------------------------------------------------------------------------- */

library Bytes4Utils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( Bytes4.Layout storage layout ) {
    layout = Bytes4._layout(slot);
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes4Utils                            */
/* -------------------------------------------------------------------------- */