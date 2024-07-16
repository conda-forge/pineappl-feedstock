#!/bin/bash

# install the CAPI
cd pineappl_capi
cargo cinstall --release --prefix=$PREFIX

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
