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

$CONDA_EXE info

echo "Running on $(dirname $0)"

if [ ! -d .dfl/DeepFaceLab ]; then
  echo "Cloning DeepFaceLab"
  git clone --no-single-branch --depth 1 "https://github.com/iperov/DeepFaceLab.git" .dfl/DeepFaceLab
  echo "DeepFaceLab clone success!!"
else
  echo "DeepFaceLab existed, skip cloning ..."
fi

if [ ! -d /home/ubuntu/anaconda3/envs/dfl ]; then
  echo "creating dfl env (using python verison=3.9) ..."
  $CONDA_EXE create -n dfl python=3.9
else
  echo "dfl env exists"
fi

$CONDA_EXE activate dfl

if [ -n "$DFL_MAIN" ]; then
  $CONDA_EXE env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
fi
if [ -n "$WORKSPACE" ]; then
  $CONDA_EXE env config vars set WORKSPACE="workspace"
fi

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file='$(dirname $0)/requirements.txt'

echo "Using $reqs_file for $(python -V)"

pip --no-cache-dir install -r $reqs_file

$CONDA_EXE deactivate

if [ ! -d workspace ]; then
  mkdir -p workspace/data_src
  mkdir -p workspace/data_dst
  mkdir -p workspace/model
fi

echo "successfully install deepfacelab!"
echo "please init dfl env by command 'conda activate dfl' "
echo "good deepfacelabing ~"
