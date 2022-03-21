// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {MessengerStorage} from "../storage/MessengerStorage.sol";

library MessengerLib {

  using MessengerLib for MessengerStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(MessengerStorage).creationCode);

  function _layout(bytes32 salt) view internal returns (MessengerStorage.Layout storage layout) {
    layout = MessengerStorage._layout(salt);
  }

  function _setMessage(
    MessengerStorage.Layout storage layout,
    string memory message
  ) internal {
    layout.message.value = message;
  }

  function _getMessage(
    MessengerStorage.Layout storage layout
  ) view internal returns (string memory message) {
    message = layout.message.value;
  }
}