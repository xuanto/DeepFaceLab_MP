#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)"

set -e

rm -rf .dfl
rm -rf workspace

conda deactivate
conda remove -n dfl --all

echo "successfully uninstall deepfacelab!"
