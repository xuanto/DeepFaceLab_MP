#!/usr/bin/env bash
# Please make sure to run this script on anaconda base env !!

cd "$(dirname $0)/.."
echo "Running on $(dirname $0)"

set -e

mkdir -p .dfl
mkdir -p workspace

if [ ! -n "$CONDA_EXE" ]; then
  echo "conda is not install! please install anaconda3!"
  exit 1
fi

conda info

if [ "$CONDA_DEFAULT_ENV" != "base" ]; then
  echo "base env is not activated! Please init base conda env!"
  exit 1
fi

if [ ! -e .dfl/DeepFaceLab/_success ]; then
  echo "Cloning DeepFaceLab..."
  rm -rf .dfl/DeepFaceLab
  git clone --no-single-branch --depth 1 "https://github.com/iperov/DeepFaceLab.git" .dfl/DeepFaceLab
  touch .dfl/DeepFaceLab/_success
  echo "DeepFaceLab clone success!!"
else
  echo "DeepFaceLab existed, skip cloning ..."
fi

if [ ! -n "$(conda info --envs | grep dfl)" ]; then
  echo "creating dfl env (using python verison=3.6) ..."
  conda create -n dfl python=3.6
  conda create -y -n deepfacelab python=3.6.6 cudatoolkit=9.0 cudnn=7.3.1
  echo "successfully create dfl env!!"
else
  echo "dfl env exists"
fi

source activate dfl

if [ "$CONDA_DEFAULT_ENV" != "dfl" ]; then
  echo "dfl env is not activated!"
  exit 1
else
  echo "======= dfl env ======="
fi

if [ ! -n "$DFL_MAIN" ]; then
  conda env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
  echo "successfully set DFL_MAIN=$DFL_MAIN"
else
  echo "DFL_MAIN=$DFL_MAIN"
fi

if [ ! -n "$WORKSPACE" ]; then
  conda env config vars set WORKSPACE="workspace"
  echo "successfully set WORKSPACE=$WORKSPACE"
else
  echo "WORKSPACE=$WORKSPACE"
fi

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file="$(dirname $0)/requirements.txt"
echo "Using $reqs_file to install packages.."

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r $reqs_file
echo "successfully install all packages !!"

if [ ! -d workspace ]; then
  mkdir -p workspace/data_src
  mkdir -p workspace/data_dst
  mkdir -p workspace/model
fi

echo "all works done!!"
echo "good deepfacelabing ~"
