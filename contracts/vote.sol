// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

contract Owned {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract SampleVote is Owned {
    using SafeMath for uint256;

    // 事件
    event VotingValidated();
    event VoteCasted(address voter, uint256 votes);

    // 參數
    uint256 public _currentVotes = 0; // 當前票數
    uint256 public _needVotes = 10; // 所需要的票數
    bool public passed = false; // 結果
    mapping(address => uint256) public votes;

    constructor() {}

    /*
    投票
    參數中的 _amount 代表票數
    */
    function vote(uint256 _amount) public virtual returns (bool) {
        require(passed != true, "Program passed"); // 檢查是否通過
        votes[msg.sender] = votes[msg.sender].add(_amount); // 地址投票數累加
        _currentVotes = _currentVotes.add(_amount); // 總票數累加
        emit VoteCasted(msg.sender, _amount); // 紀錄投票log
        return true;
    }

    /*
    指定地址票數
    參數中的 _address 代表地址
    */
    function addressVotes(address _address) public virtual view returns (uint256) {
        return votes[_address];
    }

    /*
    當前票數
    */
    function currentVotes() public virtual view returns (uint256) {
        return _currentVotes;
    }

    /*
    檢查是否通過方案
    備註：只有合約創造者才能使用此功能
    */
    function validate() onlyOwner public virtual {
        require(passed != true, "Program passed"); // 檢查是否通過
        require(_currentVotes >= _needVotes, "Not enough votes to pass."); // 檢查票數是否超過
        passed = true;
        emit VotingValidated(); // 紀錄驗證成功log
    }
}
