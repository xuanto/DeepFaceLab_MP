#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" xseg apply \
  --input-dir "$WORKSPACE/data_src/aligned" \
  --model-dir "$WORKSPACE/model"
