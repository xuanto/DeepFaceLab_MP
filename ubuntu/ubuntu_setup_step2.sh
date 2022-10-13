#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file='$(dirname $0)/requirements.txt'

echo "Using $reqs_file for $(python -V)"

pip --no-cache-dir install -r $reqs_file

echo "Step 2 done."