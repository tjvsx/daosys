// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20UFragmentsInternal} from "./internal/ERC20UFragmentsInternal.sol";
import {ERC20Metadata} from "../../metadata/ERC20Metadata.sol";
import {ERC20Account} from "../../account/ERC20Account.sol";
import {IERC20} from "../../interfaces/IERC20.sol";
import {FullMath} from "../../../../math/FullMath.sol";

contract ERC20UFragments
  is
    IERC20,
    ERC20UFragmentsInternal,
    ERC20Account,
    ERC20Metadata
{

  using FullMath for int256;

  function name() override(IERC20) view external returns (string memory tokenName) {
    tokenName = _name();
  }

  function symbol() override(IERC20) view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol();
  }

  function decimals() override(IERC20) view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals();
  }

  function totalSupply() override(IERC20) external view returns (uint256 supply) {
    supply = _totalSupply();
  }

  function balanceOf(address account) external view override(IERC20) returns (uint256 balance) {
    balance = _balanceOf(account) / _getBaseAmountPerFragment();
  }

  function scaledBalanceOf(address account) external view returns (uint256 scaledBalance) {
    scaledBalance = _balanceOf(account);
  }

  function transfer(address recipient, uint256 amount)
    external override(IERC20) returns (bool result)
  {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment();

    _transfer(msg.sender, recipient, scaledAmount);
    emit Transfer(msg.sender, recipient, amount);
    result = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) external override(IERC20) returns (bool success) {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment();
    _transferFrom(account, recipient, scaledAmount);
    emit Transfer(account, recipient, amount);
    success = true;
  }

  function allowance(
    address holder,
    address spender
  ) override(IERC20) external view returns (uint256 limit) {

    limit = _allowance(holder, spender) / _getBaseAmountPerFragment();
  }

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment();
    _approve(spender, scaledAmount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  event LogRebase(uint256 totalSupply);

  uint8 private constant DECIMALS = 9;
  uint256 private constant MAX_UINT256 = type(uint256).max;
  // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
  uint256 private constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1
  // uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**uint256(DECIMALS);
  uint256 private constant INITIAL_FRAGMENTS_SUPPLY = MAX_SUPPLY;

  // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.
  // Use the highest value that fits in a uint256 for max granularity.
  uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

  function initialize(
    string memory newName,
    string memory newSymbol
  ) external {
    _setName(newName);
    _setSymbol(newSymbol);
    _setDecimals(DECIMALS);

    _setTotalSupply(INITIAL_FRAGMENTS_SUPPLY);
    _setBalance(msg.sender, TOTAL_GONS);
    _setBaseAmountPerFragment(TOTAL_GONS / _getTotalSupply() );

    emit Transfer(address(0), msg.sender, _getTotalSupply() );
  }

  function rebase(
    int256 supplyDelta
  ) external returns (uint256)
  {
    uint256 currentTotalSupply = _totalSupply();
    if (supplyDelta == 0) {
      emit LogRebase(currentTotalSupply);
      return currentTotalSupply;
    }

    if (supplyDelta < 0) {
      _setTotalSupply( currentTotalSupply - uint256(supplyDelta.abs() ) );
    } else {
      _setTotalSupply(currentTotalSupply + uint256(supplyDelta) );
    }

    if (currentTotalSupply > MAX_SUPPLY) {
      _setTotalSupply(MAX_SUPPLY);
    }

    _setBaseAmountPerFragment(TOTAL_GONS / _totalSupply() );

    // From this point forward, _gonsPerFragment is taken as the source of truth.
    // We recalculate a new _totalSupply to be in agreement with the _gonsPerFragment
    // conversion rate.
    // This means our applied supplyDelta can deviate from the requested supplyDelta,
    // but this deviation is guaranteed to be < (_totalSupply^2)/(TOTAL_GONS - _totalSupply).
    //
    // In the case of _totalSupply <= MAX_UINT128 (our current supply cap), this
    // deviation is guaranteed to be < 1, so we can omit this step. If the supply cap is
    // ever increased, it must be re-included.
    // _totalSupply = TOTAL_GONS.div(_gonsPerFragment)

    emit LogRebase(_totalSupply() );
    return _totalSupply();
  }

}