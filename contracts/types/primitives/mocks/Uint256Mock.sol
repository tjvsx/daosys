// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Uint256,
  Uint256Utils
} from "../Uint256.sol";

contract Uint256Mock {

  using Uint256Utils for Uint256.Layout;

  function setUint256(uint256 newValue) external returns (bool result) {
    Uint256Utils._layout(Uint256Utils._structSlot()).value = newValue;
    result = true;
  }

  function getUint256() view external returns (uint256 value) {
    value = Uint256Utils._layout(Uint256Utils._structSlot()).value;
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = Uint256Utils._structSlot();
  }

}