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
set tmpv=`conda info --envs | grep dfl`
echo "tmpv=$tmpv"

if [ ! -n "$tmpv" ]; then
  echo "creating dfl env (using python verison=3.9) ..."
  conda create -n dfl python=3.9
  echo "successfully create dfl env!!"
else
  echo "dfl env exists"
fi

echo "successfully install deepfacelab and dfl env!"
echo "please init dfl env by command 'conda activate dfl' "
echo "then run step 2"
