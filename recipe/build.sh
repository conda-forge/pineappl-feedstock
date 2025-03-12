#!/bin/bash

owd=${PWD}

# install the CAPI
curl --proto '=https' --tlsv1.2 -sSf https://nnpdf.github.io/pineappl/install-capi.sh | sh -s -- --prefix ${PREFIX} --version ${PKG_VERSION}

# install the python bindings
cd pineappl_py
maturin build --release --interpreter $PYTHON
cd ../target/wheels/
PYTHONDONTWRITEBYTECODE=1 PIP_CONFIG_FILE=/dev/null $PYTHON -m pip install --isolated --ignore-installed --no-deps *.whl

# install the CLI
cd ${owd}
if [[ $HOST == *arm64-apple* ]]; then
    export PKG_CONFIG_SYSROOT_DIR=${CONDA_BUILD_SYSROOT}/
    #export PKG_CONFIG_PATH=${PREFIX}/lib/pkg_config/:${PKG_CONFIG_PATH}
    export RUSTFLAGS="$(lhapdf-config --libs)"
    $BUILD_PREFIX/bin/cargo install --features=evolve,fktable --path pineappl_cli --target=aarch64-apple-darwin
    pineappl --help
else
    $BUILD_PREFIX/bin/cargo install --features=evolve,fktable --path pineappl_cli
fi
