// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

// import {ImmutableStorage} from "../storage/ImmutableStorage.sol";

// library ImmutableLib {

//   using ImmutableLib for ImmutableStorage.Layout;

//   function _getDefaultSlot() internal pure returns ( bytes32 defaultSlot ) {
//     defaultSlot = keccak256(type(ImmutableStorage).creationCode);
//   }

//   /**
//    * @dev Used to encode a salt with the immutability storage slot modifier.
//    *  This is donee by passing the idenitifier for what is to immutable.
//    *  If a functrion is intended to be Immutable, the identifier is the function selector.
//    *  If a facet function is to be immutable, the identifier is the XOR (^) of the facet address and the function selector.
//    *  If an entire storage slot is to be immutable, the identifier is the sttorage slot being made immutable.
//    * @param identifier The identifier of the property being made immutable.
//    */
//   function _encodeImmutableStorage( bytes32 identifier ) internal pure returns ( bytes32 immutableSlot ) {
//     immutableSlot = ( identifier ^ _getDefaultSlot() );
//   }

//   function _layout( bytes32 slot ) internal pure returns (ImmutableStorage.Layout storage l) {
//     l = ImmutableStorage._layout( slot );
//   }

//   function _makeImmutable( ImmutableStorage.Layout storage l ) internal {
//     l.isImmutable = true;
//   }

//   function _isImmutable( ImmutableStorage.Layout storage l ) internal view returns ( bool isImmutablke ) { 
//     isImmutablke = l.isImmutable;
//   }

// }