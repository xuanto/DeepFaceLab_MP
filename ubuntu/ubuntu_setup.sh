#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"
echo "$1"

set -e

mkdir -p .dfl
mkdir -p workspace

# init conda
__conda_setup="$('$1/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
echo "debug 1"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$1/etc/profile.d/conda.sh" ]; then
        . "$1/etc/profile.d/conda.sh"
    else
        echo "debug 2"
        export PATH="$1/bin:$PATH"
    fi
fi
unset __conda_setup

conda info

echo "Running on $(dirname $0)"

if [ ! -d .dfl/DeepFaceLab ]; then
  echo "Cloning DeepFaceLab"
  git clone --no-single-branch --depth 1 "https://github.com/iperov/DeepFaceLab.git" .dfl/DeepFaceLab
  echo "DeepFaceLab clone success!!"
else
  echo "DeepFaceLab existed, skip cloning ..."
fi

echo "creating dfl env (using python verison=3.9) ..."
conda create -n dfl python=3.9
conda activate dfl
conda env config vars set DFL_MAIN=".dfl/DeepFaceLab/main.py"
conda env config vars set WORKSPACE="workspace"

echo "upgrading pip ..."
python -m pip install --upgrade pip

reqs_file='$(dirname $0)/requirements.txt'

echo "Using $reqs_file for $(python -V)"

pip --no-cache-dir install -r $reqs_file

conda deactivate

if [ ! -d workspace ]; then
  mkdir -p workspace/data_src
  mkdir -p workspace/data_dst
  mkdir -p workspace/model
fi

echo "successfully install deepfacelab!"
echo "please init dfl env by command 'conda activate dfl' "
echo "good deepfacelabing ~"
