#!/bin/bash

# Ensure input arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: entrypoint.sh <input_file> [preset_name] [crf_value]"
    exit 1
fi

INPUT_FILE=$1
PRESET_NAME=$2 # Optional
CRF_VALUE=$3  # Optional

# Extract filename without extension
BASENAME=$(basename -- "$INPUT_FILE")
EXTENSION="${BASENAME##*.}"
FILENAME="${BASENAME%.*}"

# Ensure input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file not found: $INPUT_FILE"
    exit 1
fi

# Determine preset name based on presence. Default is 1080p
if [ -z "$PRESET_NAME" ]; then
    PRESET_NAME="1080p"
fi

# Determine output file name based on CRF value presence
if [ -n "$CRF_VALUE" ]; then
    OUTPUT_FILE="${FILENAME}-CRF${CRF_VALUE}.${EXTENSION}"
    CRF_OPTION="-q $CRF_VALUE"
else
    OUTPUT_FILE="${FILENAME}-CRF-default.${EXTENSION}"
    CRF_OPTION=""  # No CRF override, uses preset default
fi

# Run HandBrakeCLI with optional CRF value
HandBrakeCLI -i "$INPUT_FILE" -o "$OUTPUT_FILE" --preset-import-file /root/.config/HandBrake/"$PRESET_NAME".json $CRF_OPTION

# Inform user of output
echo "Encoding complete: $OUTPUT_FILE"