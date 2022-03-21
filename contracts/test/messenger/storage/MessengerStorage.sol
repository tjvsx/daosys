// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import {
  String,
  StringUtils
} from "../../../types/primitives/String.sol";

library MessengerStorage {

  struct Layout {
    String.Layout message;
  }

  function _layout(bytes32 salt) view internal returns (MessengerStorage.Layout storage layout) {
    console.log("MessengerStorage:_layout:: String Struct storage slot: ", address(bytes20(StringUtils._structSlot())));

    console.log("MessengerStorage:_layout:: Salting storage slot with: ", address(bytes20(salt)));
    bytes32 saltedSlot = salt ^ StringUtils._structSlot();
    
    console.log("MessengerStorage:_layout:: Using storage slot: ", address(bytes20(saltedSlot)));
    assembly{ layout.slot := saltedSlot }
  }
  
}