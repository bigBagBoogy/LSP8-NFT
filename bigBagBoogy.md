# instant push copy paste all below in one go:

git init
git branch -M main
git add .
git commit -m "amended code"
git push -u origin main

# remove: (for example node_modules)!

git rm -r --cached node_modules

# to do:

LuksoCloneX deployed to: 0xB840a9820e4dae24822De98B1d47e4Cc98946E4d
https://explorer.execution.testnet.lukso.network/address/0xB840a9820e4dae24822De98B1d47e4Cc98946E4d/transactions#address-tabs

write tests!

npx hardhat verify 0xB840a9820e4dae24822De98B1d47e4Cc98946E4d 0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f --network testnet
Nothing to compile
Successfully submitted source code for contract
contracts/LuksoCloneX.sol:LuksoCloneX at 0xB840a9820e4dae24822De98B1d47e4Cc98946E4d
for verification on the block explorer. Waiting for verification result...

Successfully verified contract LuksoCloneX on Etherscan.
https://explorer.execution.testnet.lukso.network/address/0xB840a9820e4dae24822De98B1d47e4Cc98946E4d#code

finish metadata.json the "hash" of icon and banner

for me to replicate this with 5 nft's, I need 5 images. Upload those to ipfs an get their ipfs urls. Embed those ipfs urls in token metadata to form 5 .json files. Name these files "1, 2, 3, 4 and 5", put these files in a folder (I guess this folder can have any name). Then upload this folder to IPFS also and then the url of this folder on ipfs will be my baseUrl

# LUKSO:

Network Parameters
Setting Value
Network Name Testnet
Fork Version 0x42010001
Chain ID / Network ID 4201
Currency Symbol LYXt
RPC URL https://rpc.testnet.lukso.network

# notes

Ok, so like the author, I will not be using a randomizer. The baseURI here however is not what I want to use. This is the firsts challenge for me. The author crafted this elaborate metadata object in JSON. I will also make use of the EXTRA content possibility within the metadata, because this is one of the defining improvements of the LSP8 over ERC721. However, the author includes some images that themselves in turn have been uploaded to IPFS and are referenced by their IPFS url in the metadata. I Could do this the same way and if it's way easier to do so, I will, but I'd prefer to work with very small SVG's, and Include those directly in the metadata. I must find out If the LSP8 protocol permits this approach. I know that EIP721 does.
Also The author has taken the entire metadata and stored that on IPFS as well, thus obtaining an IPFS URI.
With ERC721 I'm used to have this setup: 1. I Base64 an SVG image and prepend this with: "data:image/svg+xml;base64" To let others now what it is. 2. I concatenate this within all the other elements that make up th metadata object and that total object I Base64 encode and then prepend this with: "data:application/json;base64," so that others can know what it is and how to decode. This is how I would like to work and by doing so, having everything on-chain and not on ipfs. Are you able to make any educated guesses as to whether the LSP8 protocol will allow for this approach?

# OpenSea officially recommends a banner image size of 1400×400 pixels. These dimensions are considered to be optimal for most devices. OpenSea recommends 600×400 pixels for featured images and 350×350 for the logo image of your profile
