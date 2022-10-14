#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

mkdir -p .dfl
mkdir -p workspace

if [ ! -n "$CONDA_EXE" ]; then
  echo "conda is not install! please install anaconda3!"
  exit 1
fi

conda info

echo "Running on $(dirname $0)"

if [ ! -d .dfl/DeepFaceLab ]; then
  echo "Cloning DeepFaceLab"
  git clone --no-single-branch --depth 1 "https://github.com/iperov/DeepFaceLab.git" .dfl/DeepFaceLab
  echo "DeepFaceLab clone success!!"
else
  echo "DeepFaceLab existed, skip cloning ..."
fi

echo "CONDA_DEFAULT_ENV=$CONDA_DEFAULT_ENV"
tmpv = `conda info --envs | grep dfl`
if [ ! -n $tmpv ]; then
  echo "creating dfl env (using python verison=3.9) ..."
  conda create -n dfl python=3.9
else
  echo "dfl env exists"
fi

conda activate dfl
echo "CONDA_DEFAULT_ENV=$CONDA_DEFAULT_ENV"

if [ ! -n "$DFL_MAIN" ]; then
  conda env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
else
  echo "DFL_MAIN=$DFL_MAIN"
fi

if [ ! -n "$WORKSPACE" ]; then
  conda env config vars set WORKSPACE="workspace"
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
