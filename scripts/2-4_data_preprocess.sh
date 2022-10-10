#!/usr/bin/env bash
cd "$(dirname $0)/.."
echo "$(dirname $0)/.."
source scripts/env.sh

# STEP2: extract_images_from_video_data_src
# python "$DFL_MAIN" videoed extract-video \
#   --input-file "$WORKSPACE/data_src.*" \
#   --output-dir "$WORKSPACE/data_src"

# STEP3: extract_images_from_video_data_dst
python "$DFL_MAIN" videoed extract-video \
  --input-file "$WORKSPACE/data_dst.*" \
  --output-dir "$WORKSPACE/data_dst"

# # STEP4:
# #   1) data_src_extract_faces_S3FD
# python "$DFL_MAIN" extract \
#   --input-dir "$WORKSPACE/data_src" \
#   --output-dir "$WORKSPACE/data_src/aligned" \
#   --detector s3fd
# #   2) data_src_sort
# python "$DFL_MAIN" sort --input-dir "$WORKSPACE/data_src/aligned"

# STEP5:
#   1) data_dst_extract_faces_S3FD
python "$DFL_MAIN" extract \
  --input-dir "$WORKSPACE/data_dst" \
  --output-dir "$WORKSPACE/data_dst/aligned" \
  --detector s3fd
#   2) data_dst_sort
python "$DFL_MAIN" sort --input-dir "$WORKSPACE/data_dst/aligned"



echo "preprocess is done !!!"
