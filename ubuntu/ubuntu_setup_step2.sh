#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

if [ -n "$DFL_MAIN" ]; then
  conda env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
fi
if [ -n "$WORKSPACE" ]; then
  conda env config vars set WORKSPACE="workspace"
fi

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file='$(dirname $0)/requirements.txt'

echo "Using $reqs_file for $(python -V)"

pip --no-cache-dir install -r $reqs_file

if [ ! -d workspace ]; then
  mkdir -p workspace/data_src
  mkdir -p workspace/data_dst
  mkdir -p workspace/model
fi

echo "successfully install deepfacelab!"
echo "please init dfl env by command 'conda activate dfl' "
echo "good deepfacelabing ~"
