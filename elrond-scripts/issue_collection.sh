#!/usr/bin/bash


WALLET_KEY=walletKey.pem
COLLECTION_ID_HEX="0x$(echo -n SerbyDId | xxd -p -u | tr -d '\n')"
TICKER_NAME_HEX="0x$(echo -n SERBDID | xxd -p -u | tr -d '\n')"
CAN_FREEZE="0x$(echo -n canFreeze | xxd -p -u | tr -d '\n')"
CAN_WIPE="0x$(echo -n canWipe | xxd -p -u | tr -d '\n')"
CAN_PAUSE="0x$(echo -n canPause | xxd -p -u | tr -d '\n')"
CAN_TRANSFER_CREATE_ROLE="0x$(echo -n canTransferNFTCreateRole | xxd -p -u | tr -d '\n')"
CAN_CHANGE_OWNER="0x$(echo -n canChangeOwner | xxd -p -u | tr -d '\n')"
CAN_UPGRADE="0x$(echo -n canUpgrade | xxd -p -u | tr -d '\n')"
CAN_ADD_SPECIAL_ROLES="0x$(echo -n canAddSpecialRoles | xxd -p -u | tr -d '\n')"
TRUE="0x$(echo -n true | xxd -p -u | tr -d '\n')"
FALSE="0x$(echo -n false | xxd -p -u | tr -d '\n')"

CONTRACT=erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u
GAS_LIMIT=100000000
ELROND_PROXY=https://gateway.elrond.com
ELROND_CHAIN=1

./erdpy --verbose contract call $CONTRACT --recall-nonce \
        --pem=${WALLET_KEY} \
        --gas-limit=${GAS_LIMIT} \
        --value=50000000000000000 \
        --proxy=${ELROND_PROXY} \
        --chain=${ELROND_CHAIN} \
        --function="issueNonFungible" \
        --arguments $COLLECTION_ID_HEX $TICKER_NAME_HEX \
        $CAN_FREEZE $FALSE  \
        $CAN_WIPE $TRUE  \
        $CAN_PAUSE $FALSE  \
        $CAN_TRANSFER_CREATE_ROLE $TRUE  \
        $CAN_CHANGE_OWNER $TRUE  \
        $CAN_UPGRADE $TRUE  \
        $CAN_ADD_SPECIAL_ROLES $TRUE  \
        --send