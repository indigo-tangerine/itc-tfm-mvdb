#!/bin/bash
# Install dependencies
set -eo pipefail
PY_DIR='packages'
FUNCTION='movies'
mkdir -p "$PY_DIR"


pip3 install -r requirements.txt --target "$PY_DIR"

# zip up dependencies
cd "$PY_DIR"
zip -rq ../"$FUNCTION.zip" .

cd ..
zip -g "$FUNCTION.zip" "$FUNCTION.py"

mv -f "$FUNCTION.zip" "../artifacts/$FUNCTION.zip"