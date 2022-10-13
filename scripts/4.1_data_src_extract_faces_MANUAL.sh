#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" extract \
  --input-dir "$WORKSPACE/data_src" \
  --output-dir "$WORKSPACE/data_src/aligned" \
  --detector manual
