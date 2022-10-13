#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" sort \
  --input-dir "$WORKSPACE/data_src/aligned"
