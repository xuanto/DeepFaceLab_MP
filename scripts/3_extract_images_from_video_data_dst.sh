#!/usr/bin/env bash
cd "$(dirname $0)/.."


python "$DFL_MAIN" videoed extract-video \
  --input-file "$WORKSPACE/data_dst.*" \
  --output-dir "$WORKSPACE/data_dst"
