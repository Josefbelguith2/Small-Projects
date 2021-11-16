// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.4.0 <0.9.0;

import "https://github.com/Josefbelguith2/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/Josefbelguith2/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract PetGame is ERC721URIStorage, Ownable {
    
    constructor(string memory name, string memory symbol) ERC721(name,symbol) {
    }
    
    struct Pet{
        uint256 damage;
        uint256 endurance;
        uint256 magic;
        uint256 lastmeal;
    }
    
    mapping(uint256 => Pet) private _petDetails;
    
    uint256 public counter = 0;
    function petMinter(uint256 _damage, uint256 _endurance, uint256 _magic) public onlyOwner {
        uint256 newId = counter;
        _petDetails[newId] = Pet(_damage, _endurance, _magic, block.timestamp);
        _safeMint(msg.sender, newId);
        counter++;
    }
    
    function getTokensOfUser(address _user) public view returns(uint256[] memory){
        uint256 totalCount = balanceOf(_user);
        if(totalCount == 0)
        {
            return new uint256[](0);
        }
        else
        {
            uint256[] memory result = new uint256[](totalCount);
            uint256 totalPets = counter;
            uint256 i;
            uint256 resultIndex = 0;
            for(i=0;i<totalPets;i++)
            {
                if(ownerOf(i)==_user)
                {
                    result[resultIndex] = i;
                    resultIndex++;
                }
            }
            return result;
        }
    }
    
    function feed(uint256 _petId) public {
        Pet storage pet = _petDetails[_petId];
        require(pet.lastmeal + pet.endurance> block.timestamp);
        pet.lastmeal = block.timestamp;
    }
}