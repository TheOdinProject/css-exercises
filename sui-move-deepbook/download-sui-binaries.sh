#!/bin/bash

VERSION=$1
ENVIRONMENT=$2
OS=$3

curl -LJO "https://github.com/MystenLabs/sui/releases/download/${ENVIRONMENT}-${VERSION}/sui-${ENVIRONMENT}-${VERSION}-${OS}.tgz"
mkdir -p bin
echo "Extracting sui binaries"
tar -xf "sui-${ENVIRONMENT}-${VERSION}-${OS}.tgz" -C bin/
echo "Done"

rm "sui-${ENVIRONMENT}-${VERSION}-${OS}.tgz"

SUI_FAUCET=sui-faucet-${OS}
SUI_NODE=sui-node-${OS}
SUI_TOOL=sui-tool-${OS}
SUI_INDEXER=sui-indexer-${OS}
SUI_TEST_VALIDATOR=sui-test-validator-${OS}
SUI_BIN=sui-${OS}
DIR=$(pwd)
BIN_PATH=${DIR}/bin/target/release

MACOS_ARM="macos-arm64"
MACOS_INTEL="macos-x86_64"
UBUNTU="ubuntu-x86_64"
WINDOWS="windows-x86_64"

SHELL_CONFIG=""


case $SHELL in

  "/bin/zsh")
    SHELL_CONFIG=~/.zshrc
    ;;

  "/bin/bash")
    SHELL_CONFIG=~/.bashrc
    ;;

  *)
    echo "unknown shell"
    exit 1
    ;;
esac

echo "# SUI aliases" >> ${SHELL_CONFIG}
echo "alias sui-faucet=${BIN_PATH}/${SUI_FAUCET}" >> ${SHELL_CONFIG}
echo "alias sui-node=${BIN_PATH}/${SUI_NODE}" >> ${SHELL_CONFIG}
echo "alias sui-tool=${BIN_PATH}/${SUI_TOOL}" >> ${SHELL_CONFIG}
echo "alias sui-indexer=${BIN_PATH}/${SUI_INDEXER}" >> ${SHELL_CONFIG}
echo "alias sui-test-validator=${BIN_PATH}/${SUI_TEST_VALIDATOR}" >> ${SHELL_CONFIG}
echo "alias sui=${BIN_PATH}/${SUI_BIN}" >> ${SHELL_CONFIG}
echo "# SUI aliases" >> ${SHELL_CONFIG}

source ${SHELL_CONFIG}

echo "Installation completed. Open a new terminal window and verify installation by running sui --verion"
