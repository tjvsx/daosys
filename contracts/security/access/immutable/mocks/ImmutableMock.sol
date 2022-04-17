// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  ImmutableModifiers,
  ImmutableStorage,
  ImmutableStorageUtils
} from "contracts/security/access/immutable/modifiers/ImmutableModifiers.sol";

contract ImmutableMock
  is
    ImmutableModifiers
{

  function testImmutable() external isNotImmutable( ImmutableStorageUtils._structSlot() ) returns (bool success) {
    success = true;
  }
}