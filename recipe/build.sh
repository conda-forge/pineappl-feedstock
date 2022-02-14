#!/bin/bash

# install pineappl rust library with c-api support
cargo install cargo-c
cd pineappl_capi
cargo cinstall --release --prefix=$PREFIX
cd ..

# install the python bindings
cd pineappl_py
maturin build --release
cd target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
