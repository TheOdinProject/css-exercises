## Disclaimer: Use of Unaudited Code for Educational Purposes Only
This code is provided strictly for educational purposes and has not undergone any formal security audit. 
It may contain errors, vulnerabilities, or other issues that could pose risks to the integrity of your system or data.

By using this code, you acknowledge and agree that:
- No Warranty: The code is provided "as is" without any warranty of any kind, either express or implied. The entire risk as to the quality and performance of the code is with you.
- Educational Use Only: This code is intended solely for educational and learning purposes. It is not intended for use in any mission-critical or production systems.
- No Liability: In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the use or performance of this code.
- Security Risks: The code may not have been tested for security vulnerabilities. It is your responsibility to conduct a thorough security review before using this code in any sensitive or production environment.
- No Support: The authors of this code may not provide any support, assistance, or updates. You are using the code at your own risk and discretion.

Before using this code, it is recommended to consult with a qualified professional and perform a comprehensive security assessment. By proceeding to use this code, you agree to assume all associated risks and responsibilities.

## Setup

### Prerequisites
Before we proceed, we should install a couple of things. Also, if you are using a Windows machine, it's recommended to use WSL2.

On Ubuntu/Debian/WSL2(Ubuntu):
```
sudo apt update
sudo apt install curl git-all cmake gcc libssl-dev pkg-config libclang-dev libpq-dev build-essential -y
```
On MacOs:
```
brew install curl cmake git libpq
```
If you don't have `brew` installed, run this:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Next, we need rust and cargo:
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
if you get an error like this:
```
error: could not amend shell profile: '/home/codespace/.config/fish/conf.d/rustup.fish': could not write rcfile file: '/home/codespace/.config/fish/conf.d/rustup.fish': No such file or directory (os error 2)
```
run these commands and re-run the rustup script:
```
mkdir -p /home/codespace/.config/fish/conf.d
touch /home/codespace/.config/fish/conf.d/rustup.fish
```

### Install Sui
If you are using Github codespaces, it's recommended to use pre-built binaries rather than building them from source.

To download pre-built binaries, you should run `download-sui-binaries.sh` in the terminal. 
This scripts takes three parameters (in this particular order) - `version`, `environment` and `os`:
- sui version, for example `1.15.0`. You can lookup a more up-to-date version available here [SUI Github releases](https://github.com/MystenLabs/sui/releases).
- `environment` - that's the environment that you are targeting, in our case it's `testnet`. Other available options are: `devnet` and `mainnet`.
- `os` - name of the os. If you are using Github codespaces, put `ubuntu-x86_64`. Other available options are: `macos-arm64`, `macos-x86_64`, `ubuntu-x86_64`, `windows-x86_64` (not for WSL).

To donwload SUI binaries for codespace, run this command:
```
./download-sui-binaries.sh "v1.21.1" "testnet" "ubuntu-x86_64"
```
and restart your terminal window.

If you prefer to build the binaries from source, run this command in your terminal:
```
cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui
```

### Install dev tools (not required, might take a while when installin in codespaces)
```
cargo install --git https://github.com/move-language/move move-analyzer --branch sui-move --features "address32"

```

### Run a local network
To run a local network with a pre-built binary (recommended way), run this command:
```
RUST_LOG="off,sui_node=info" sui-test-validator
```

Optionally, you can run it from sources.
```
git clone --branch testnet https://github.com/MystenLabs/sui.git

cd sui

RUST_LOG="off,sui_node=info" cargo run --bin sui-test-validator
```

### Install SUI Wallet (optionally)
```
https://chrome.google.com/webstore/detail/sui-wallet/opcgpfmipidbgpenhmajoajpbobppdil?hl=en-GB
```

### Configure connectivity to a local node
Once the local node is running (using `sui-test-validator`), you should the url of a local node - `http://127.0.0.1:9000` (or similar).
Also, another url in the output is the url of a local faucet - `http://127.0.0.1:9123`.

Next, we need to configure a local node. To initiate the configuration process, run this command in the terminal:
```
sui client active-address
```
The prompt should tell you that there is no configuration found:
```
Config file ["/home/codespace/.sui/sui_config/client.yaml"] doesn't exist, do you want to connect to a Sui Full node server [y/N]?
```
Type `y` and in the following prompts provide a full node url `http://127.0.0.1:9000` and a name for the config, for example, `localnet`.

On the last prompt you will be asked which key scheme to use, just pick the first one (`0` for `ed25519`).

After this, you should see the ouput with the wallet address and a mnemonic phrase to recover this wallet. You can save so later you can import this wallet into SUI Wallet.

Additionally, you can create more addresses and to do so, follow the next section - `Create addresses`.

### Testnet configuration

For the sake of this tutorial, let's add a testnet node:
```
sui client new-env --rpc https://fullnode.testnet.sui.io:443 --alias testnet
```
and switch to `testnet`:
```
sui client switch --env testnet
```

### Create addresses
For this tutorial we need two separate addresses. To create an address run this command in the terminal:
```
sui client new-address ed25519
```
where:
- `ed25519` is the key scheme (other available options are: `ed25519`, `secp256k1`, `secp256r1`)

And the output should be similar to this:
```
╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Created new keypair and saved it to keystore.                                                   │
├────────────────┬────────────────────────────────────────────────────────────────────────────────┤
│ address        │ 0x05db1e318f1e4bc19eb3f2fa407b3ebe1e7c3cd8147665aacf2595201f731519             │
│ keyScheme      │ ed25519                                                                        │
│ recoveryPhrase │ lava perfect chef million beef mean drama guide achieve garden umbrella second │
╰────────────────┴────────────────────────────────────────────────────────────────────────────────╯
```
Use `recoveryPhrase` words to import the address to the wallet app.


### Get localnet SUI tokens
```
curl --location --request POST 'http://127.0.0.1:9123/gas' --header 'Content-Type: application/json' \
--data-raw '{
    "FixedAmountRequest": {
        "recipient": "<ADDRESS>"
    }
}'
```
`<ADDRESS>` - replace this by the output of this command that returns the active address:
```
sui client active-address
```

You can switch to another address by running this command:
```
sui client switch --address <ADDRESS>
```
abd run the HTTP request to mint some SUI tokens to this account as well.

Also, you can top up the balance via the wallet app. To do that, you need to import an account to the wallet.

### Get testnet SUI tokens
After you switched to `testnet`, run this command to get 1 testnet SUI:
```
sui client faucet
```
it will use the the current active address and the current active network.

## Build and publish a smart contract

### Build package
To build tha package, you should run this command:
```
sui move build
```

If the package is built successfully, the next step is to publish the package:
### Publish package
```
sui client publish --gas-budget 100000000 --json
```
Here we do not specify the path to the package dir so it will use the current dir - `.`

After the contract is published we need to extract some object ids from the output. Here is the list of env variable that we source in the current shell and their values:
- `PACKAGE_ID` - the id of the published package. The json path to it is `.objectChanges[].packageId`
- `ORIGINAL_UPGRADE_CAP_ID` - the upgrade cap id that we might need if we find ourselves in the situation when we need to upgrade the contract. Path: `.objectChanges[].objectId` where `.objectChanges[].objectType` is  `0x2::package::UpgradeCap`
- `SUI_FEE_COIN_ID` the id of the SUI coin that we are going to use to pay the fee for the pool creation. Take any from the output of this command: `sui client gas --json`
- `ACCOUNT_ID1` - currently active address, assign the output of this command: `sui client active-address`. Repeat the same for the secondary account and assign the output to `ACCOUNT_ID1`
- `CLOCK_OBJECT_ID` - the id of the `Clock` object, default to `0x6`
- `BASE_COIN_TYPE` - the type of the SUI coin, default to `0x2::sui::SUI`
- `QUOTE_COIN_TYPE` - the type of the quote coin that we deployed for the sake of this tutorial. The coin is `WBTC` in the `wbtc` module in the `$PACKAGE_ID` package. So the value will look like this: `<PACKAGE_ID>::wbtc::WBTC`
- `WBTC_TREASURY_CAP_ID` it's the treasury cap id that is needed for token mint operations. In the publish output you should look for the object with `objectType` `0x2::coin::TreasuryCap<$PACKAGE_ID::wbtc::WBTC>` (replace `$PACKAGE_ID` with the actual package id) and this object also has `objectId` - that's the value that we are looking for.

## Interact with the contract

### Create pool

Now we create a pool:
```
sui client call --package $PACKAGE_ID  --module book --function new_pool --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --args $SUI_FEE_COIN_ID --gas-budget 10000000000 --json
```
After the pool is created, check the output and locate the object with the type `0xdee9::clob_v2::Pool<$BASE_COIN_TYPE, $QUOTE_COIN_TYPE>` (`$BASE_COIN_TYPE`, `$QUOTE_COIN_TYPE` - replace with the actual values) and assign the value from the `objectId` property to `$POOL_ID`.

In this case, the pool is created with the default values for `REFERENCE_TAKER_FEE_RATE` and `REFERENCE_MAKER_REBATE_RATE` where the former one is `2_500_000` (0.25%) and the latter one is `1_500_000` (0.15%).

In case you'd like to customize these values, you should use `create_customized_pool`:
```
public fun create_customized_pool<BaseAsset, QuoteAsset>(
        tick_size: u64,
        lot_size: u64,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        creation_fee: Coin<SUI>,
        ctx: &mut TxContext,
    )
```

### Create custodian account
For limit orders we need to have custodian accounts (more details [here](https://docs.sui-deepbook.com/deepbook-sdk/trade-and-swap#2.1.2-create-custodian-account)):
```
sui client call --package $PACKAGE_ID  --module book --function new_custodian_account  --gas-budget 10000000000
```
In the publish output you should look for the object with `objectType` `0xdee9::custodian_v2::AccountCap` and assign the value `objectId` to the env variable `ACCOUNT1_CAP`.
Repeat the same for the secondary account that we created previously (use `sui client switch --address <ADDRESS>`) and the output assign to ACCOUNT2_CAP.

### Mint WBTC token
Now we need to mint WBTC tokens. Switch to the address that you've used to publish the contract and run this command to mint tokens:
```
sui client call --function mint --module wbtc --package $PACKAGE_ID  --args $WBTC_TREASURY_CAP_ID "10000000000" $ACCOUNT_ID1 --gas-budget 10000000 --json
```
Re-run the same command but change `ACCOUNT_ID1` to `ACCOUNT_ID2`.
Check the output and look for an object with `objectType` that has a value like this `String("0x2::coin::Coin<$PACKAGE_ID::wbtc::WBTC>")` and get the value of `objectId` and assign it ot `ACCOUNT1_WBTC_OBJECT_ID`.

### Make deposits
Now we need to make deposits (both base and quote) to `ACCOUNT1_CAP_ID` (for limit orders).
First, prepare the `BASE_COIN_ID` variable by assigning the output of `sui client gas` (any of the values) and the run this command:
```
sui client call --package $PACKAGE_ID  --module book --function make_base_deposit  --args $POOL_ID $BASE_COIN_ID $ACCOUNT1_CAP_ID --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```

Now deposit the quote coin:
```
sui client call --package $PACKAGE_ID  --module book --function make_quote_deposit  --args $POOL_ID $ACCOUNT1_WBTC_OBJECT_ID $ACCOUNT1_CAP_ID --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```
The arguments strictly match the signature of the function that is called.

### Place limit orders
Let's place multiple limit orders:
```
 sui client call --package $PACKAGE_ID  --module book --function place_limit_order  --args "$POOL_ID" 42 5000000000 200 0 true 1888824053000 0 $CLOCK_OBJECT_ID "$ACCOUNT1_CAP" --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
 
 sui client call --package $PACKAGE_ID  --module book --function place_limit_order  --args "$POOL_ID" 42 5000000000 300 0 true 1888824053000 0 $CLOCK_OBJECT_ID "$ACCOUNT1_CAP" --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
 
 sui client call --package $PACKAGE_ID  --module book --function place_limit_order  --args "$POOL_ID" 42 2000000000 1000 0 true 1888824053000 0 $CLOCK_OBJECT_ID "$ACCOUNT1_CAP" --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
 
 sui client call --package $PACKAGE_ID  --module book --function place_limit_order  --args "$POOL_ID" 42 20000000000 1000 0 false 1888824053000 0 $CLOCK_OBJECT_ID "$ACCOUNT1_CAP" --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```
where:
- `1888824053000` is a timestamp somewhere in the future, to avoid order expiration for the sake of simplicity
- `42` is an id of the order, can be any number.

Notice that these commands are mostly the same except for the arguments for `priect`, `quantity` and `is_bid`.

`is_bid` indicated whether you want to sell or buy assets. More details here: [2.1.4 Place Limit Order](https://docs.sui-deepbook.com/deepbook-sdk/trade-and-swap).

### Place market order
Now we need to place a market order to buy/sell assets. We are going to do this using our secondary account.

First, switch to the secondary account:
```
sui client switch --address <ADDRESS>
```

Now place the order:
```
sui client call --package $PACKAGE_ID  --module book --function place_base_market_order  --args $POOL_ID $ACCOUNT2_CAP $SUI_COIN_ID 942 "false" $CLOCK_OBJECT_ID --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```
where:
- `942` is an id of the order, can be any number

Check the output of this command and find the `balanceChanges` array where the balance changes will be listed, you should see the exchanged assets. Also, you can double-check this in the wallet app.
The amount of tokens won't be precisly the number you expect because there is a deepbook fee, more details [here](https://docs.sui-deepbook.com/deepbook-fee-structure).

More info about the market orders can be found [here](https://docs.sui-deepbook.com/deepbook-sdk/trade-and-swap#2.2-place-market-order).

### Swap order
Now let's try to run a swap order. 
Re-run the commands the place limit orders (using the first account) and the switch back to the secondary account, and run the swap order:

```
sui client call --package $PACKAGE_ID  --module book --function swap_exact_base_for_quote  --args "$POOL_ID" 42 $ACCOUNT2_CAP 1500 $BASE_COIN_ID $CLOCK_OBJECT_ID --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```
where:
- `BASE_COIN_ID` is the id of the SUI coin, get the value from `sui client gas --json`
- `42` is an id of the order, can be any number

Check the output of this command and find the `balanceChanges` array where the balance changes will be listed, you should see the exchanged assets. Also, you can double-check this in the wallet app.

### Withdrap from the account cap

After you deposited either base or quote assets you can withdraw them back to your main address:

#### withdraw base
```
sui client call --package $PACKAGE_ID  --module book --function withdraw_base --args "$POOL_ID" 100 $ACCOUNT2_CAP --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```

#### withdraw quote
```
sui client call --package $PACKAGE_ID  --module book --function withdraw_quote --args "$POOL_ID" 100 $ACCOUNT2_CAP --type-args $BASE_COIN_TYPE $QUOTE_COIN_TYPE --gas-budget 10000000000 --json
```
