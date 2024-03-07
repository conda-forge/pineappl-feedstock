#!/bin/bash


if [[ $HOST == *arm64-apple* ]]; then

    curl --proto '=https' --tlsv1.2 -sSf https://nnpdf.github.io/pineappl/install-capi.sh | sh -s -- --prefix ${PREFIX} --target aarch64-apple-darwin

else
    # install pineappl rust library with c-api support
    cargo install cargo-c --version 0.9.14+cargo-0.66
    cd pineappl_capi
    cargo cinstall --release --prefix=$PREFIX
    cd ..
fi

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null pip install --isolated --ignore-installed --no-deps *.whl
