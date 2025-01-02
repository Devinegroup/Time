// ----------------------------------------------------------------------------
// Devine - Time Unit Of Account Currency
// ----------------------------------------------------------------------------
// SPDX-License-Identifier: MIT
// ----------------------------------------------------------------------------
// Developed by: Devine Group
// Description: The global world reserve time unit of account currency
// ============================================================================

// Devine Group: https://github.com/Devinegroup

// Primary Author(s):
// Daniel Campbell

// Reviewer(s):

pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {TimeReserve} from "src/TimeReserve.sol";

contract Time is ERC20, Ownable {

    TimeReserve immutable i_timeReserve;

    error Time__MintAmountNeedsToBeMoreThanZero();
    error Time__BurnAmountNeedsToBeMoreThanZero();
    error Time__BurnAmountMustNotExceedCurrentBalance();
    error Time__DoNotMintToTheZeroAddress();

    constructor(address _timeReserve) ERC20("Time", "TIME") Ownable(_timeReserve) {
        i_timeReserve = TimeReserve(_timeReserve);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert Time__DoNotMintToTheZeroAddress();
        }
        if (_amount <= 0) {
            revert Time__MintAmountNeedsToBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}