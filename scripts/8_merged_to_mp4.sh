#!/usr/bin/env bash
cd "$(dirname $0)/.."


# 解决mac无法确认开发者的问题
sudo spctl --master-disable

python "$DFL_MAIN" videoed video-from-sequence \
  --input-dir "$WORKSPACE/data_dst/merged" \
  --output-file "$WORKSPACE/result.mp4" \
  --reference-file "$WORKSPACE/data_dst.*" \
  --include-audio
