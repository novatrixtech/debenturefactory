// SPDX-License-Identifier: GPL-3
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DebentureX is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {

    string public issuer;
    uint256 public expirationDate;
    address public custodian;

    constructor(
      uint256 initialSupply_,
      string memory name_,
      string memory symbol_,
      string memory issuer_,
      uint256 expirationDate_,
      address custodian_
    )
        ERC20(name_, symbol_)
        Ownable(custodian_)
        ERC20Permit(name_)
    {
        _mint(msg.sender, initialSupply_ * 10 ** decimals());
        issuer = issuer_;
        expirationDate = expirationDate_;
        custodian = custodian_;        
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
