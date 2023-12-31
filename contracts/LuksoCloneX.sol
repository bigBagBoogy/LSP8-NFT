//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {LSP8IdentifiableDigitalAsset} from
    "@lukso/lsp-smart-contracts/contracts/LSP8IdentifiableDigitalAsset/LSP8IdentifiableDigitalAsset.sol";
import {
    _LSP4_METADATA_KEY,
    _LSP4_CREATORS_ARRAY_KEY,
    _LSP4_CREATORS_MAP_KEY_PREFIX
} from "@lukso/lsp-smart-contracts/contracts/LSP4DigitalAssetMetadata/LSP4Constants.sol";

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//this _LSP8_TOKEN_ID_TYPE is the same for all NFT contracts using token id type uint2526.
bytes32 constant _LSP8_TOKEN_ID_TYPE = 0x715f248956de7ce65e94d9d836bfead479f7e70d69b718d47bfe7b00e05b4fe4;
// above is found at:   https://github.com/lukso-network/LIPs/blob/main/LSPs/LSP-8-IdentifiableDigitalAsset.md#lsp8tokenidtype
//this _LSP8_TOKEN_METADATA_BASE_URI is the same for all NFT contracts.
bytes32 constant _LSP8_TOKEN_METADATA_BASE_URI = 0x1a7628600c3bac7101f53697f48df381ddc36b9015e7d7c9c5633d1252aa2843;

uint256 constant PUBLIC_PRICE_PER_TOKEN = 0.1 ether;
uint256 constant MAX_SUPPLY = 5;

contract LuksoCloneX is LSP8IdentifiableDigitalAsset, ReentrancyGuard {
    //below LSP8IdentifiableDigitalAsset parent contract takes care of setting the name, symbol and owner. Here you would find the lines: super._setData(_LSP4_TOKEN_NAME_KEY, bytes(name_));  and:    super._setData(_LSP4_TOKEN_SYMBOL_KEY, bytes(symbol_));
    constructor(address owner_) LSP8IdentifiableDigitalAsset("LuksoButtons", "BTNS", owner_) {
        // c4f5c04d7a38e625bccf43ce710c72ce63a162fb507200d4ae684032b5109e4b is the hash of the URI JSON content obtained with the hasherOfString.ts running: ```npm run hasherOfString```
        bytes memory jsonUrl = abi.encodePacked(
            bytes4(keccak256("keccak256(utf8)")), // The expression bytes4(keccak256("keccak256(utf8)")) is used to compute the keccak256 hash of the string "keccak256(utf8)" and then convert the first 4 bytes of that hash into a bytes4 data type. This is often used in Ethereum smart contracts to generate function selectors for function calls.
            hex"c4f5c04d7a38e625bccf43ce710c72ce63a162fb507200d4ae684032b5109e4b",
            bytes("ipfs://QmQKhYpFUX3xKLkMHc1zfwBHxBafLXtvQnbHq4ATNk71cJ") // link to metadata of the contract
        );
        // _setData is an internal method that sets data key/value pairs in a ERC725Y store: a generic data storage standard, used to provide LSPs with dynamic on-chain data storage space, that can be read, decoded and interpreted.
        _setData(_LSP4_METADATA_KEY, jsonUrl);

        _setData(_LSP8_TOKEN_ID_TYPE, hex"02"); // 02 indicates uint256

        bytes memory zeroBytes = hex"00000000"; // here we are going to append the hex representation of 0 to the beginning of the bytes object of the ipfs TOKEN URI
        bytes memory baseURI =
            abi.encodePacked(zeroBytes, bytes("ipfs://QmfBbkqTqzVtA7Mkya9bRmKkWLbYZQ1kyHRJBL1eiw8vgj")); // folder on ipfs containing the metadata files of the nft's

        _setData(_LSP8_TOKEN_METADATA_BASE_URI, baseURI);

        // We set the length of the array to 1
        _setData(_LSP4_CREATORS_ARRAY_KEY, hex"01");

        // We set the first element of the array to the creator address
        _setData(
            0x114bd03b3a46d48759680d81ebb2b41400000000000000000000000000000000,
            hex"EC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f"
        );

        // Set the creator map with interfaceId=0x66767497 <-- but not this,
        // because this is from universal profile.  And creator index 0
        bytes32 creatorsMapKey =
            bytes32(abi.encodePacked(_LSP4_CREATORS_MAP_KEY_PREFIX, 0x5870dC9aEB06E26A0C8130eF2C6C12d80b1E0375));
        _setData(creatorsMapKey, hex"667674970000000000000000");
    }

    function publicMint(address to, uint256 amount, bool allowNonLSP1Recipient) external payable nonReentrant {
        require(msg.value == PUBLIC_PRICE_PER_TOKEN * amount, "Invalid LYX amount sent");
        uint256 tokenSupply = totalSupply(); // gas saving
        require(tokenSupply + amount <= MAX_SUPPLY, "Exceeds MAX_SUPPLY");
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = ++tokenSupply;
            _mint(to, bytes32(tokenId), allowNonLSP1Recipient, "");
            // the first NFT (non-fungible token) to be minted using this function will have tokenId equal to 1. This is because the tokenId is incremented (++tokenSupply) before the minting action inside the loop.
        }
    }
}
