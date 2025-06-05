#!/bin/bash

# Define input and output directories
INPUT_DIR="input"

# ------------------------------------------------
#
# GENERATE VIDEO
#
# ------------------------------------------------

# Loop through all video files in the input directory
for video in "$INPUT_DIR"/*.mp4; do
    # Extract the base name of the video file (without extension)
    base_name=$(basename "$video" .mp4)

    # Create a folder for the image series inside the input directory, named after the video
    output_folder="$INPUT_DIR/$base_name"
    mkdir -p "$output_folder"

    # Use ffmpeg to convert the video into an image series with simplified numbering
    ffmpeg -i "$video" "$output_folder/%d.png"
done

# ------------------------------------------------
#
# FINISH
#
# ------------------------------------------------

# Print completion message
