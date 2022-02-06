#!/usr/bin/bash

WALLET_KEY=walletKey.pem

IPFS_CID=$1
TOKEN_IDENTIFIER=$2
TOKEN_IDENTIFIER_HEX="0x$(echo -n ${TOKEN_IDENTIFIER} | xxd -p -u | tr -d '\n')"

function generate_nft(){
	NFT_NAME=$1
	NFT_NAME_HEX="0x$(echo -n ${NFT_NAME} | xxd -p -u | tr -d '\n')"

	GATEWAY_1_URL=https://dweb.link/ipfs/${IPFS_CID}/${NFT_NAME}.png
	GATEWAY_2_URL=https://ipfs.cf-ipfs.com/ipfs/${IPFS_CID}/${NFT_NAME}.png
	GATEWAY_3_URL=https://cloudflare-ipfs.com/ipfs/${IPFS_CID}/${NFT_NAME}.png

	IPFS_URL_HEX="0x$(echo -n ${IPFS_URL} | xxd -p -u | tr -d '\n')"
	GATEWAY_1_URL_HEX="0x$(echo -n ${GATEWAY_1_URL} | xxd -p -u | tr -d '\n')"
	GATEWAY_2_URL_HEX="0x$(echo -n ${GATEWAY_2_URL} | xxd -p -u | tr -d '\n')"
	GATEWAY_3_URL_HEX="0x$(echo -n ${GATEWAY_3_URL} | xxd -p -u | tr -d '\n')"

	
	#contract is your address
	WALLET_ADDRESS=<your_wallet_adress>
	GAS_LIMIT=2805501
	ELROND_PROXY=https://gateway.elrond.com
	ELROND_CHAIN=1

	./erdpy --verbose contract call $WALLET_ADDRESS --recall-nonce \
			--pem=${WALLET_KEY} \
			--gas-limit=${GAS_LIMIT} \
			--value=0 \
			--proxy=${ELROND_PROXY} \
			--chain=${ELROND_CHAIN} \
			--function="ESDTNFTCreate" \
			--arguments $TOKEN_IDENTIFIER_HEX \
			01  \
			$NFT_NAME_HEX  \
			00  \
			00  \
			00  \
			$GATEWAY_2_URL_HEX  \
			$GATEWAY_3_URL_HEX  \
			--send
}


FILES="/files/00978.pn*"
for f in $FILES
do
  echo "Processing $f file..."
  NFT_NAME_1="$(echo $f | sed 's/\/files\///' | sed 's/.png//')"
  echo $NFT_NAME_1
  generate_nft $NFT_NAME_1
  sleep 20  
done

#generate_nft 
