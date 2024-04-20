#!/bin/bash


sui move build
sui client publish --gas-budget 100000000 --force --json > sui-build.json

> .env
jq '.objectChanges[] |  select(.objectType=="0x2::package::UpgradeCap") | .objectId' sui-build.json | awk '{print "ORIGINAL_UPGRADE_CAP_ID="$1}' >> .env
jq '.objectChanges[].packageId | select( . != null )' sui-build.json | awk '{print "PACKAGE_ID="$1}' >> .env
sui client gas --json | jq '.[-1].gasCoinId' | awk '{printf "SUI_FEE_COIN_ID=%s\n",$1}' >> .env
sui client active-address | awk '{printf "ACCOUNT_ID1=\"%s\"\n",$1}' >> .env
jq '.objectChanges[].packageId | select( . != null )' sui-build.json -r | awk '{printf "QUOTE_COIN_TYPE=\"%s::wbtc::WBTC\"\n",$1}' >> .env
sui client gas --json | jq '.[-1].gasCoinId' | awk '{printf "SUI_FEE_COIN_ID=%s\n",$1}' >> .env

source .env
