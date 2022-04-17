// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

// import {
//   ImmutableLib,
//   ImmutableStorage
// } from "../libraries/ImmutableLib.sol";

// abstract contract ImmutableModifiers {
  
//   using ImmutableLib for ImmutableStorage.Layout;

//   modifier isNotImmutable( bytes32 identifier ) {
//     require( !ImmutableLib._layout( ImmutableLib._encodeImmutableStorage(identifier) )._isImmutable(), "Immutable:: This function is immutable." );
//     _;
//     ImmutableLib._layout( ImmutableLib._encodeImmutableStorage(identifier) )._makeImmutable();
//   }
  
// }