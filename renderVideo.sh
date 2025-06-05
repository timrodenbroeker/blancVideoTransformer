#!/bin/bash

# Define input and output directories
INPUT_DIR="singleFrames"
OUTPUT_DIR="output"

# ------------------------------------------------
#
# PROCESS SUBFOLDERS
#
# ------------------------------------------------

# Loop through each subfolder in the singleFrames directory
for folder in "$INPUT_DIR"/*/; do
    # Extract the base name of the folder (without trailing slash)
    base_name=$(basename "$folder")

    # Create an mp4 video from the PNG files at 20fps (supporting leading zeros, e.g., 0001.png)
    ffmpeg -framerate 20 -i "$folder/%04d.png" -c:v libx264 -pix_fmt yuv420p "$OUTPUT_DIR/${base_name}.mp4"
done

# ------------------------------------------------
#
# SATURATE
#
# ------------------------------------------------

# Loop through all video files in the output directory
for video in "$OUTPUT_DIR"/*.mp4; do
    # Extract the base name of the video file (without extension)
    base_name=$(basename "$video" .mp4)

    # Apply saturation filter to the output video
    saturated_output="$OUTPUT_DIR/${base_name}_saturated.mp4"
    ffmpeg -i "$video" -vf "eq=saturation=3" "$saturated_output"
done
