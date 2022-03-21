// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {IMessenger} from "./interfaces/IMessenger.sol";
import {
  MessengerInternal,
  MessengerLib,
  MessengerStorage
} from "./internal/MessengerInternal.sol";

contract Messenger
  is
    IMessenger,
    MessengerInternal
{

  function setMessage(
    string memory message
  ) override(IMessenger) virtual external returns (bool success) {
    _setMessage(message);
    success = true;
  }

  function getMessage() override(IMessenger) view virtual external returns (string memory message) {
    message = _getMessage();
  }

  function IMessengerInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IMessenger).interfaceId;
  }

  function setMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IMessenger.setMessage.selector;
  }

  function getMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IMessenger.getMessage.selector;
  }

}