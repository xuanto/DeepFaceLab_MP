#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

mkdir -p .dfl
mkdir -p workspace

conda () {
  if [ "$#" -lt 1 ]
  then
    "$CONDA_EXE" $_CE_M $_CE_CONDA
  else
    \local cmd="$1"
    shift
    case "$cmd" in
      (activate | deactivate) __conda_activate "$cmd" "$@" ;;
      (install | update | upgrade | remove | uninstall) CONDA_INTERNAL_OLDPATH="${PATH}"
        __add_sys_prefix_to_path
        "$CONDA_EXE" $_CE_M $_CE_CONDA "$cmd" "$@"
        \local t1=$?
        PATH="${CONDA_INTERNAL_OLDPATH}"
        if [ $t1 = 0 ]
        then
          __conda_reactivate
        else
          return $t1
        fi ;;
      (*) CONDA_INTERNAL_OLDPATH="${PATH}"
        __add_sys_prefix_to_path
        "$CONDA_EXE" $_CE_M $_CE_CONDA "$cmd" "$@"
        \local t1=$?
        PATH="${CONDA_INTERNAL_OLDPATH}"
        return $t1 ;;
    esac
  fi
}

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
python -m pip install -r ./DeepFaceLab/requirements-cuda.txt

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
