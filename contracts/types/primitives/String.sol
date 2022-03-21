// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;


/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4                                 */
/* -------------------------------------------------------------------------- */

library String {

  struct Layout {
    string value;
  }

  /*
  NOTE Implemented here as the binding of the Layout struct is tightly coupled
    to the binding of a storage slot.
   */
  function _layout( bytes32 slot ) pure internal returns ( String.Layout storage layout ) {
    assembly{ layout.slot := slot }
  }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes4                                */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4Utils                            */
/* -------------------------------------------------------------------------- */

library StringUtils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(String).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( String.Layout storage layout ) {
    layout = String._layout(slot);
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes4Utils                            */
/* -------------------------------------------------------------------------- */