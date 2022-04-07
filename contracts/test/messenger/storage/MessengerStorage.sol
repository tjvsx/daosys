// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  String,
  StringUtils
} from "../../../types/primitives/String.sol";

library MessengerStorage {

  struct Layout {
    String.Layout message;
  }

  function _layout(bytes32 salt) pure internal returns (MessengerStorage.Layout storage layout) {
    bytes32 saltedSlot = salt ^ StringUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }
  
}