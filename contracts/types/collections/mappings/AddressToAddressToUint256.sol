// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Uint256,
  Uint256Utils
} from "../../primitives/Uint256.sol";

library AddressToAddressToUint256 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => Uint256.Layout)) value;
  }

  function _layout(bytes32 slot) pure internal returns (AddressToAddressToUint256.Layout storage layout) {
    assembly{ layout.slot := slot }
  }
}

library AddressToAddressToUint256Utils {

  using AddressToAddressToUint256Utils for AddressToAddressToUint256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUint256).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( AddressToAddressToUint256.Layout storage layout ) {
    layout = AddressToAddressToUint256._layout(slot);
  }

}