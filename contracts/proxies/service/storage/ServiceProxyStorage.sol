// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   Address,
//   AddressSet
// } from "contracts/types/collections/sets/AddressSet.sol";
// import {
//   Bytes4,
//   Bytes4Set
// } from "contracts/types/collections/sets/Bytes4Set.sol";

// library ServiceProxyStorage {

//   struct Layout {
//     AddressSet.Enumerable allDelegateServices;
//     mapping(bytes4 => address) delegateServiceForInterfaceId;
//     mapping(address => Bytes4Set.Enumerable) interfaceIdsForDelegateService;
//     mapping(bytes4 => address) delegateServiceForFunctionSelector;
//     mapping(bytes4 => bytes4) delegateServiceInterfaceIdForFunctionSelector;
//     mapping(bytes4 => Bytes4Set.Enumerable) delegateServiceFunctionSelectorsForInterfaceId;
//   }

//   function _layout(bytes32 slot) pure internal returns (Layout storage layout) {
//     assembly{ layout.slot := slot }
//   }

// }