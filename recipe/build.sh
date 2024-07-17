#!/bin/bash

# install the CAPI
curl --proto '=https' --tlsv1.2 -sSf https://nnpdf.github.io/pineappl/install-capi.sh | sh -s -- --prefix ${PREFIX} --version ${PKG_VERSION}

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
