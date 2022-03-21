// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  MessengerLib,
  MessengerStorage
} from "../libraries/MessengerLib.sol";
import {IMessenger} from "../interfaces/IMessenger.sol";

abstract contract MessengerInternal {

  using MessengerLib for MessengerStorage.Layout;

  function _setMessage(
    string memory message
  ) internal {
    MessengerLib._layout(type(IMessenger).interfaceId)
      ._setMessage(message);
  }

  function _getMessage() view internal returns (string memory message) {
    message = MessengerLib._layout(type(IMessenger).interfaceId)
      ._getMessage();
  }
  
}