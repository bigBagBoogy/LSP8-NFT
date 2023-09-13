Suppose you want to define a key-value pair for the "Token Name" of your NFT collection, which you've decided to name "GPTtoken." In a basic key-value structure, it might look like this:

Key: "Token Name"
Value: "GPTtoken"
This is a simple key-value pair where "Token Name" is the key, and "GPTtoken" is the corresponding value.

However, in the context of the LSP4 metadata standard, you have a more detailed structure for defining and interpreting keys. So, when you define "Token Name" using LSP4, you're not just saying "Token Name = 'GPTtoken'." Instead, you're providing a comprehensive description of what "Token Name" means in terms of its key properties, like this:

Key: "LSP4TokenName"
KeyType: Singleton (indicates it's a single, unique key)
ValueType: string (specifies the type of value it can hold, which is a string)
ValueContent: String (provides further details about the expected content, which is a string)
So, in this case, "LSP4TokenName" is a key that describes the name of the token collection. The key itself is made up of several key-value pairs that define its characteristics, including its type and the expected content type for its value.

This structured approach to defining keys is more detailed and allows for better standardization and interoperability when dealing with metadata in complex systems like NFT collections.

# creator attribution:

If you are the sole creator of a contract with the address `0xmaartensContract` and your Ethereum address is `0xmaarten`, you can follow the LSP4 standard to credit yourself as the creator. Here's how you would do it:

1. **Set the Length of the Creators Array**:

   - `_setData(_LSP4_CREATORS_ARRAY_KEY, hex"01");`

2. **Set the First Array Element**:

   - `_setData(0x114bd03b3a46d48759680d81ebb2b41400000000000000000000000000000000, hex"Your Ethereum Address");`
   - Replace `"Your Ethereum Address"` with your actual Ethereum address, which is `0xmaarten` in this case.

3. **Set the Creator Map**:
   - `bytes32 creatorsMapKey = bytes32(abi.encodePacked(_LSP4_CREATORS_MAP_KEY_PREFIX, "Your Ethereum Address"));`
   - Replace `"Your Ethereum Address"` with your actual Ethereum address, which is `0xmaarten` in this case.

Here's what the code would look like with your specific values:

```solidity
// Set the length of the creators array to 1
_setData(_LSP4_CREATORS_ARRAY_KEY, hex"01");

// Set the first element of the creators array with your Ethereum address
_setData(0x114bd03b3a46d48759680d81ebb2b41400000000000000000000000000000000, hex"0xmaarten");

// Set the creator map for your Ethereum address
bytes32 creatorsMapKey = bytes32(abi.encodePacked(_LSP4_CREATORS_MAP_KEY_PREFIX, "0xmaarten"));
```

This code will credit you as the sole creator of the contract with the address `0xmaartensContract`. It sets the length of the creators array to 1 and associates your Ethereum address with the creator index 0.

# User

So even when this: ```{
"name": "LSP4Creators[]",
"key": "0x114bd03b3a46d48759680d81ebb2b414fda7d030a7105a851867accf1c2352e7",
"keyType": "Array",
"valueType": "address",
"valueContent": "Address"
} is the LSP4Creators-key, I do not completely type out this object in my code, but rather generate this object through the \_setData function which in the above example we would call twice. Once to set the array length and again to append my name/identity. The type being an address is thus implied by means of the protocol?

ChatGPT

3 / 3

Yes, that's correct. In the LSP4 standard, the key 0x114bd03b3a46d48759680d81ebb2b414fda7d030a7105a851867accf1c2352e7 is defined as the key for the LSP4Creators[]. The fact that it has a valueType of address and a keyType of Array is part of the protocol's specification.

When you set this key using the \_setData function, you don't need to specify the valueType or keyType explicitly because these properties are defined by the standard. You simply use the \_setData function to set the data associated with this key, which in this case is the Ethereum address of the creator.

So, in your code, you use the \_setData function to set the creators array's length and append your Ethereum address. The type being an address is indeed implied by the valueType specified in the protocol's standard. This allows for consistency and interoperability among contracts that follow the LSP4 standard.

# still to submit:

so next the author writes: `_setData(_LSP8_TOKEN_ID_TYPE, hex"02");` which means "string" I'm confused why, because I understood he uses incremental numbers to pick a metadata file for a token. I found this in the docs about it: ```To add a baseURI on an LSP8 collection, we’re gonna use the LSP8TokenMetadataBaseURI key (detailed here). Let’s add the following lines in our code:

// Before the contract declaration
bytes32 constant \_LSP8_TOKEN_ID_TYPE = 0x715f248956de7ce65e94d9d836bfead479f7e70d69b718d47bfe7b00e05b4fe4;
bytes32 constant \_LSP8_TOKEN_METADATA_BASE_URI = 0x1a7628600c3bac7101f53697f48df381ddc36b9015e7d7c9c5633d1252aa2843;
...
// In the constructor
\_setData(\_LSP8_TOKEN_ID_TYPE, hex"02");

bytes memory zeroBytes = hex"00000000";
bytes memory baseURI = abi.encodePacked(zeroBytes, bytes('ipfs://QmZh7P3YZNxFZUiHkXLNgAtdk2T6PAza3S15Jjg1DzxVGf'));
\_setData(\_LSP8_TOKEN_METADATA_BASE_URI, baseURI);
So what did we do here ?

First, we declared the constants for the 2 bytes32 keys we’ll be using.

Then, we set the value of the first key, token id type, to 2, as this number represents a tokenId of type uint256. If you’re wondering why we’d need to specify the type of the tokenId, it’s because tokenIds’ are always stored as bytes32(hexadecimal values), so we need to know how to interpret them (e.g. 12 in hexadecimal is c). You can find all the different tokenId types there: LSP8 - TokenIdType

We’ve now added the baseURI to the store. You might have missed it, but we also added hex”00000000” in front of our URI: that’s a slot that can be used when we want to add verifiability to our metadata by using the tokenId as a hash (hashFunction(<metadataContent>)). This bytes4 slot tells us which hash function has been used to hash the token metadata content (e.g. keccak256 = 0x6f357c6a). In our case, we’re using an unhashed token id so we won’t hash the content. Since we don’t need to have a hash function, we’ll just fill this slot with zeros.```
