#!/usr/bin/env bash
# Please make sure to run this script on anaconda base env !!

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
tmpv=$(conda info --envs | grep dfl)
echo "tmpv=$tmpv"

if [ ! -n "$tmpv" ]; then
  echo "creating dfl env (using python verison=3.6) ..."
  conda create -n dfl python=3.6
  echo "successfully create dfl env!!"
else
  echo "dfl env exists"
fi

source activate dfl

echo "CONDA_DEFAULT_ENV=$CONDA_DEFAULT_ENV"
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

pip --no-cache-dir install -r $reqs_file
echo "successfully install all packages !!"

if [ ! -d workspace ]; then
  mkdir -p workspace/data_src
  mkdir -p workspace/data_dst
  mkdir -p workspace/model
fi

echo "all works done!!"
echo "good deepfacelabing ~"
