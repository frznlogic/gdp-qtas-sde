#!/bin/bash

machine=$1

rm -rf gdp-sdk
mkdir -p gdp-sdk

if [ $machine = "minnowboard" ]; then
    curl http://139.162.178.25/public/qtas_gdp-spin/sdk/minnowboard/oecore-x86_64-corei7-64-toolchain-nodistro.0.sh -o sdk-installer.sh
fi

if [ $machine = "porter" ]; then
    curl http://139.162.178.25/public/qtas_gdp-spin/sdk/portet/fix-me.sh -o sdk-installer.sh
fi

chmod +x sdk-installer.sh
./sdk-installer.sh -d ./gdp-sdk/ -y
