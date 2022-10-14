#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

if [ ! -n "$CONDA_EXE" ]; then
  echo "conda is not install! please install anaconda3!"
  exit 1
fi

echo "$CONDA_PREFIX"
conda info

if [ ! -n "$DFL_MAIN" ]; then
  sudo $CONDA_EXE env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
else
  echo "DFL_MAIN=$DFL_MAIN"
fi

if [ ! -n "$WORKSPACE" ]; then
  sudo $CONDA_EXE env config vars set WORKSPACE="workspace"
else
  echo "WORKSPACE=$WORKSPACE"
fi

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file="$(dirname $0)/requirements.txt"
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
