// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GiveIsBlessed is ERC20{

    constructor() ERC20("GiveIsBlessed", "GIB"){
        _mint(msg.sender, 100000000 * 10 ** decimals());
    }
    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}