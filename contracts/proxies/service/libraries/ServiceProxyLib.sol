// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   ServiceProxyStorage,
//   Address,
//   AddressSet,
//   Bytes4,
//   Bytes4Set
// } from "../storage/ServiceProxyStorage.sol";

// library ServiceProxyLib {

//   using Address for AddressSet.Enumerable;
//   using Bytes4 for Bytes4Set.Enumerable;
//   using ServiceProxyLib for ServiceProxyStorage.Layout;

//   bytes32 constant private STORAGE_SLOT = keccak256(type(ServiceProxyStorage).creationCode);

//   function _getDefaultSlot() pure internal returns (bytes32 defaultSlot) {
//     defaultSlot = STORAGE_SLOT;
//   }

//   function _layout(bytes32 slot) pure internal returns (ServiceProxyStorage.Layout storage layout) {
//     layout = ServiceProxyStorage._layout(slot);
//   }

//   function _registerDelegateService(
//     ServiceProxyStorage.Layout storage layout,
//     address newDelegateService,
//     bytes4 newDelegateServiceInterfaceId,
//     bytes4[] memory newDelegateServiceFunctionSelectors
//   ) internal {
//     layout.allDelegateServices._add(newDelegateService);
//     layout
//       .delegateServiceForInterfaceId[newDelegateServiceInterfaceId] = newDelegateService;
//     layout
//       .interfaceIdsForDelegateService[newDelegateService]._add(newDelegateServiceInterfaceId);
//     for( uint16 iteration = 0; newDelegateServiceFunctionSelectors.length > iteration; iteration++) {
//       layout
//         .delegateServiceForFunctionSelector[
//           newDelegateServiceFunctionSelectors[iteration]
//         ] = newDelegateService;
//       layout
//         .delegateServiceInterfaceIdForFunctionSelector[
//           newDelegateServiceFunctionSelectors[iteration]
//         ] = newDelegateServiceInterfaceId;
//       layout
//         .delegateServiceFunctionSelectorsForInterfaceId[
//           newDelegateServiceInterfaceId
//         ]._add(newDelegateServiceFunctionSelectors[iteration]);
//     }
//   }

//   function _deregisterDelegateService(
//     ServiceProxyStorage.Layout storage layout,
//     address deprecatedDelegateService
//   ) internal {
//     layout.allDelegateServices._remove(deprecatedDelegateService);
//     bytes4[] memory interfaceIds = layout.interfaceIdsForDelegateService[deprecatedDelegateService]._getRawSet();
//     delete layout.interfaceIdsForDelegateService[deprecatedDelegateService];
//     for(uint16 iteration = 0; interfaceIds.length > iteration; iteration++) {
//       delete layout.delegateServiceForInterfaceId[interfaceIds[iteration]];
//       bytes4[] memory functionSelectors = layout.delegateServiceFunctionSelectorsForInterfaceId[interfaceIds[iteration]]._getRawSet();
//       delete layout.delegateServiceFunctionSelectorsForInterfaceId[interfaceIds[iteration]];
//       for(uint16 innerIteration = 0; functionSelectors.length > innerIteration; innerIteration++) {
//         delete layout.delegateServiceForFunctionSelector[functionSelectors[innerIteration]];
//         delete layout.delegateServiceInterfaceIdForFunctionSelector[functionSelectors[innerIteration]];
//       }
//     }
//   }

//   function _getDelegateService(
//     ServiceProxyStorage.Layout storage layout,
//     bytes4 functionSelector   
//   ) view internal returns (address delegateService) {
//     delegateService = layout.delegateServiceForFunctionSelector[functionSelector];
//   }

// }