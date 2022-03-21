// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20UFragmentsLib,
  ERC20UFragmentsStorage
} from "../libraries/ERC20UFragmentsLib.sol";

abstract contract ERC20UFragmentsInternal {

  using ERC20UFragmentsLib for ERC20UFragmentsStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20UFragmentsStorage).creationCode);

  // uint256 private constant MAX_UINT256 = type(uint256).max;

  function _getDefaultSlot() pure internal returns (bytes32 defaultSlot) {
    defaultSlot = STORAGE_SLOT;
  }

  function _layout(bytes32 slot) pure internal returns (ERC20UFragmentsStorage.Layout storage layout) {
    layout = ERC20UFragmentsStorage._layout(slot);
  }

  function _getSacledDecimals() pure internal returns (uint8 scaledDecimals) {
    scaledDecimals = ERC20UFragmentsLib._getSacledDecimals();
  }

  function _getBaseAmountPerFragment(
  ) view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = ERC20UFragmentsLib._layout(ERC20UFragmentsLib._getDefaultSlot())
      ._getBaseAmountPerFragment();
  }

  function _setBaseAmountPerFragment(
    uint256 newBaseAmountPerFragment
  ) internal {
    ERC20UFragmentsLib._layout(ERC20UFragmentsLib._getDefaultSlot())
      ._setBaseAmountPerFragment(newBaseAmountPerFragment);
  }

}