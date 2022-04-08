// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";

library ERC20UFragmentsStorage {

  struct Layout {
    UInt256.Layout baseAmountPerFragment;
  }

}

library ERC20UFragmentsUtils {

  using ERC20UFragmentsUtils for ERC20UFragmentsStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERC20UFragmentsStorage).creationCode);

  // Scaled tokens must use a decimals of 9 in order for the scaling formulas to not overflow.
  uint8 private constant SCALED_DECIMALS = 9;

  uint256 private constant MAX_UINT256 = type(uint256).max;
  // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
  uint256 private constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1
  // uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**uint256(DECIMALS);
  uint256 private constant INITIAL_FRAGMENTS_SUPPLY = MAX_SUPPLY;

  /*
   * TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment 
   *  is an integer.
   * Use the highest value that fits in a uint256 for max granularity.
   */
  uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERC20UFragmentsStorage.Layout storage layout) {
    bytes32 saltedSlot =
      salt
      ^ ERC20UFragmentsUtils._structSlot();
    assembly{ layout.slot := saltedSlot }
  }

  function _getScaledDecimals() pure internal returns (uint8 requiredDecimals) {
    requiredDecimals = SCALED_DECIMALS;
  }

  function _getBaseAmountPerFragment(
    ERC20UFragmentsStorage.Layout storage layout
  ) view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = layout.baseAmountPerFragment.value;
  }

  function _setBaseAmountPerFragment(
    ERC20UFragmentsStorage.Layout storage layout,
    uint256 newBaseAmountPerFragment
  ) internal {
    layout.baseAmountPerFragment.value = newBaseAmountPerFragment;
  }

}