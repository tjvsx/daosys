// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20UFragmentsStorage} from "../storage/ERC20UFragmentsStorage.sol";

/*
Scaled tokens are initialized with the maximum possible supply and scaled downwards to the desired supply.
This provides maximum granularity, and allows for easily begining with any initial supply.
*/
// library ERC20UFragmentsLib {

//   using ERC20UFragmentsLib for ERC20UFragmentsStorage.Layout;

//   bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20UFragmentsStorage).creationCode);

//   // Scaled tokens must use a decimals of 9 in order for the scaling formulas to not overflow.
//   uint8 private constant SCALED_DECIMALS = 9;

//   function _getDefaultSlot() pure internal returns (bytes32 defaultSlot) {
//     defaultSlot = STORAGE_SLOT;
//   }

//   function _getSacledDecimals() pure internal returns (uint8 requiredDecimals) {
//     requiredDecimals = SCALED_DECIMALS;
//   }

//   uint256 private constant MAX_UINT256 = type(uint256).max;
//   // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
//   uint256 private constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1
//   // uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**uint256(DECIMALS);
//   uint256 private constant INITIAL_FRAGMENTS_SUPPLY = MAX_SUPPLY;

//   // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.
//   // Use the highest value that fits in a uint256 for max granularity.
//   uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

//   function _layout(bytes32 slot) pure internal returns (ERC20UFragmentsStorage.Layout storage layout) {
//     layout = ERC20UFragmentsStorage._layout(slot);
//   }

//   function _getBaseAmountPerFragment(
//     ERC20UFragmentsStorage.Layout storage layout
//   ) view internal returns (uint256 baseAmountPerFragment) {
//     baseAmountPerFragment = layout.baseAmountPerFragment.value;
//   }

//   function _setBaseAmountPerFragment(
//     ERC20UFragmentsStorage.Layout storage layout,
//     uint256 newBaseAmountPerFragment
//   ) internal {
//     layout.baseAmountPerFragment.value = newBaseAmountPerFragment;
//   }

// }