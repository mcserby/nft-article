#!/usr/bin/bash

WALLET_KEY=walletKey.pem
TOKEN_IDENTIFIER=$1
COLLECTION_IDENTIFIER="0x$(echo -n ${TOKEN_IDENTIFIER} | xxd -p -u | tr -d '\n')"
WALLET_ADDRESS="0x$(echo -n <your_wallet_address> | xxd -p -u | tr -d '\n')"

ESDT_ROLE_NFT_CREATE="0x$(echo -n ESDTRoleNFTCreate | xxd -p -u | tr -d '\n')"
ESDT_ROLE_NFT_ADD_URI="0x$(echo -n ESDTRoleNFTAddURI | xxd -p -u | tr -d '\n')"

CONTRACT=erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u
GAS_LIMIT=100000000
ELROND_PROXY=https://gateway.elrond.com
ELROND_CHAIN=1

./erdpy --verbose contract call $CONTRACT --recall-nonce \
        --pem=${WALLET_KEY} \
        --gas-limit=${GAS_LIMIT} \
        --value=0 \
        --proxy=${ELROND_PROXY} \
        --chain=${ELROND_CHAIN} \
        --function="setSpecialRole" \
        --arguments $COLLECTION_IDENTIFIER $WALLET_ADDRESS $ESDT_ROLE_NFT_CREATE $ESDT_ROLE_NFT_ADD_URI \
        --send