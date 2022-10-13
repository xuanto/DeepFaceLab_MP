#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" xseg remove \
  --input-dir "$WORKSPACE/data_src/aligned"
