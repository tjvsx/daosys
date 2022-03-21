// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                             SECTION Address                                */
/* -------------------------------------------------------------------------- */

library Address {

  struct Layout {
    address value;
  }

  /*
  NOTE Implemented here as the binding of the Layout struct is tightly coupled
    to the binding of a storage slot.
   */
  function _layout( bytes32 slot ) pure internal returns ( Address.Layout storage layout ) {
    assembly{ layout.slot := slot }
  }
  
}

/* -------------------------------------------------------------------------- */
/*                             !SECTION Address                               */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION AddressUtils                            */
/* -------------------------------------------------------------------------- */

library AddressUtils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Address).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _layout( bytes32 slot ) pure internal returns ( Address.Layout storage layout ) {
    layout = Address._layout(slot);
  }

  function _toString(address account) internal pure returns (string memory) {
    bytes32 value = bytes32(uint256(uint160(account)));
    bytes memory alphabet = '0123456789abcdef';
    bytes memory chars = new bytes(42);

    chars[0] = '0';
    chars[1] = 'x';

    for (uint256 i = 0; i < 20; i++) {
      chars[2 + i * 2] = alphabet[uint8(value[i + 12] >> 4)];
      chars[3 + i * 2] = alphabet[uint8(value[i + 12] & 0x0f)];
    }

    return string(chars);
  }

  function _isContract(address account) internal view returns (bool) {
    uint size;
    assembly { size := extcodesize(account) }
    return size > 0;
  }

  function _sendValue(address payable account, uint amount) internal {
    (bool success, ) = account.call{ value: amount }('');
    require(success, 'AddressUtils: failed to send value');
  }

  function _functionCall(address target, bytes memory data) internal returns (bytes memory) {
    return _functionCallWithError(target, data, 'AddressUtils: failed low-level call');
  }

  function _functionCallWithError(address target, bytes memory data, string memory error) internal returns (bytes memory) {
    return __functionCallWithValue(target, data, 0, error);
  }

  function _functionCallWithValue(address target, bytes memory data, uint value) internal returns (bytes memory) {
    return __functionCallWithValue(target, data, value, 'AddressUtils: failed low-level call with value');
  }

  function _functionCallWithValue(address target, bytes memory data, uint value, string memory error) internal returns (bytes memory) {
    require(address(this).balance >= value, 'AddressUtils: insufficient balance for call');
    return __functionCallWithValue(target, data, value, error);
  }

  function __functionCallWithValue(address target, bytes memory data, uint value, string memory error) private returns (bytes memory) {
    require(_isContract(target), 'AddressUtils: function call to non-contract');

    (bool success, bytes memory returnData) = target.call{ value: value }(data);

    if (success) {
      return returnData;
    } else if (returnData.length > 0) {
      assembly {
        let returnData_size := mload(returnData)
        revert(add(32, returnData), returnData_size)
      }
    } else {
      revert(error);
    }
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION AddressUtils                           */
/* -------------------------------------------------------------------------- */
