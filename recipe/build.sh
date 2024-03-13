#!/bin/bash


if [[ $HOST == *arm64-apple* ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://nnpdf.github.io/pineappl/install-capi.sh | sh -s -- --prefix ${PREFIX} --target aarch64-apple-darwin
else
    curl --proto '=https' --tlsv1.2 -sSf https://nnpdf.github.io/pineappl/install-capi.sh | sh -s -- --prefix ${PREFIX}
fi

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
