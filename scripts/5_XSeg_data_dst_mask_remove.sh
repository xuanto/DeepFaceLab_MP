#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" xseg remove_labels \
  --input-dir "$WORKSPACE/data_dst/aligned"
