#!/bin/bash

case $BUILD in
    arm64-apple*)
        target=aarch64-apple-darwin;;
    x86_64-apple*)
        target=x86_64-apple-darwin;;
    x86_64-*linux-gnu)
        target=x86_64-unknown-linux-gnu;;
    *)
        echo "Error: unknown target, BUILD = '$BUILD'"
        exit 1;;
esac

echo TARGET = ${target}

# install the CAPI
cd pineappl_capi
cargo cinstall --release --prefix=$PREFIX --target ${target}
cd ..

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON --target ${target}
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
