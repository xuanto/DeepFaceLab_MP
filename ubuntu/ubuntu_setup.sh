#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

mkdir -p .dfl
mkdir -p workspace

echo "Running on $(dirname $0)"

if [ ! -d .dfl/DeepFaceLab ]; then
  echo "Cloning DeepFaceLab"
  git clone --no-single-branch --depth 1 "https://github.com/chychkan/DeepFaceLab.git" .dfl/DeepFaceLab
  echo "DeepFaceLab clone success!!"
else
  echo "DeepFaceLab existed, skip cloning ..."
fi

# if [ ! -d .dfl/env ]; then
#   echo "creating virtualenv ..."
#   virtualenv -p python3 .dfl/env
#   echo "virtualenv successfully create!!"
# fi

# chmod 777 .dfl/env/bin/activate
# source .dfl/env/bin/activate
# echo ".dfl/env/bin/activate activate success !!!"

echo "creating dfl env ..."
conda create -n dfl python=3.6

echo "upgrading pip ..."
python -m pip install --upgrade pip

version=$(python -V | cut -f 2 -d ' ' | cut -f 1,2 -d .)
reqs_file='$(dirname $0)/requirements.txt'

version_suffix=''
if [[ ! -z "$version" && -f "$(dirname $0)/requirements_$version.txt" ]]; then
  version_suffix="_$version"
fi

reqs_file="$(dirname $0)/requirements${version_suffix}.txt"

echo "Using $reqs_file for $(python -V)"

if [ "$version" == "3.10" ]; then
  (cd .dfl/DeepFaceLab; git checkout support-opencv45)

  numpy_pkg="$(cat $reqs_file | grep -E 'numpy==.+')"
  pip install "$numpy_pkg"
fi

pip --no-cache-dir install -r $reqs_file

echo "Done."
