// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "../UInt256.sol";

interface IUInt256{

  function setUint256(uint256 newValue) external returns (bool result);

  function getUint256() view external returns (uint256 value);

  function getStructSlot() pure external returns (bytes32 structSlot);

}

contract Uint256Mock {

  using UInt256Utils for UInt256.Layout;

  function setUint256(uint256 newValue) external returns (bool result) {
    UInt256Utils._layout(UInt256Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getUint256() view external returns (uint256 value) {
    value = UInt256Utils._layout(UInt256Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = UInt256Utils._structSlot();
  }

}