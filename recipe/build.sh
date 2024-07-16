#!/bin/bash

# install CLI
cargo install --features=evolve,fktable --path pineappl_cli

cargo install cargo-c --version 0.9.14+cargo-0.66
cd pineappl_capi
# install the CAPI
cargo cinstall --release --prefix=$PREFIX
cd ..

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
