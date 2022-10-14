#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

if [ ! -n "$CONDA_EXE" ]; then
  echo "conda is not install! please install anaconda3!"
  exit 1
fi

echo "CONDA_DEFAULT_ENV=$CONDA_DEFAULT_ENV"
if [ "$CONDA_DEFAULT_ENV" != "dfl" ]; then
  echo "dfl env is not activated!"
  exit 1
fi

conda info

if [ ! -n "$DFL_MAIN" ]; then
  conda env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
  echo "set DFL_MAIN=.dfl/DeepFaceLab/main.py"
else
  echo "DFL_MAIN=$DFL_MAIN"
fi

if [ ! -n "$WORKSPACE" ]; then
  conda env config vars set WORKSPACE="workspace"
  echo "set WORKSPACE=workspace"
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
echo "good deepfacelabing ~"
