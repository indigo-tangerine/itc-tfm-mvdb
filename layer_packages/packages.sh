#!/bin/bash
# Install dependencies
set -eo pipefail
PY_DIR='build/python'
mkdir -p "$PY_DIR"

pip3 install -r requirements.txt --no-deps --target "$PY_DIR"

# zip up dependencies
cd build
zip -r ../xray-packages.zip .

cd ..
mv -f xray-packages.zip ../artifacts/xray-packages.zip
