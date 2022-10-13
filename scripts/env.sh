DFL_MAIN=.dfl/DeepFaceLab/main.py
WORKSPACE=workspace

source .dfl/env/bin/activate

set -e


#!/usr/bin/env bash
conda activate deepfacelab
cd ..
export DFL_PYTHON="python3.7"
export DFL_WORKSPACE="workspace/"

export DFL_ROOT="./"
export DFL_SRC="./DeepFaceLab"


export DFL_MAIN=".dfl/DeepFaceLab/main.py"
export WORKSPACE="workspace"