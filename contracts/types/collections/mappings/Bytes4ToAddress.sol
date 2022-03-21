// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

library Bytes4ToAddress {

  struct Layout {
    mapping(bytes4 => address) value;
  }

  /*
  NOTE Implemented here as the binding of the Layout struct is tightly coupled
    to the binding of a storage slot.
   */
  function _layout( bytes32 slot ) pure internal returns ( Bytes4ToAddress.Layout storage layout ) {
    assembly{ layout.slot := slot }
  }

}

library Bytes4ToAddressUtils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4ToAddress).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( Bytes4ToAddress.Layout storage layout ) {
    layout = Bytes4ToAddress._layout(slot);
  }

}