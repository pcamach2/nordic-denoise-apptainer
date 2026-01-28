#!/bin/bash
#
# This wrapper script runs NIFTI_NORDIC.m in an Apptainer container for Matlab
#
# Usage: nordic_denoise.sh -m <path_to_magnitude_nifti_file> -p <path_to_phase_nifti_file>

# Parse command line arguments
while getopts "m:p:" opt; do
    case $opt in
        m) MAGNITUDE_FILE="$OPTARG" ;;
        p) PHASE_FILE="$OPTARG" ;;
        *) echo "Usage: $0 -m <path_to_magnitude_nifti_file> -p <path_to_phase_nifti_file>" ;;
    esac
done

if [ -z "$MAGNITUDE_FILE" ] || [ -z "$PHASE_FILE" ]; then
    echo "Both magnitude and phase NIfTI files must be provided."
    echo "Usage: $0 -m <path_to_magnitude_nifti_file> -p <path_to_phase_nifti_file>"
    exit 1
fi

# Set data directory
DATA_DIR=$(dirname "$MAGNITUDE_FILE")
# Set output NORDIC-denoised file name
OUTPUT_FILE="${MAGNITUDE_FILE%.nii*}_nordic_denoised"

# Get just file names, without paths
MAGNITUDE_FILENAME="$(basename "$MAGNITUDE_FILE")"
PHASE_FILENAME="$(basename "$PHASE_FILE")"
OUTPUT_FILENAME="$(basename "$OUTPUT_FILE")"

# MAGNITUDE_FILE and PHASE_FILE inside container
MAGNITUDE_FILE="/data/$MAGNITUDE_FILENAME"
PHASE_FILE="/data/$PHASE_FILENAME"
OUTPUT_FILE="$OUTPUT_FILENAME"

# check for apptainer
if ! command -v apptainer &> /dev/null
then
    echo "Apptainer not found. Assuming script is running inside Apptainer container."
    matlab -nodisplay -nosplash -nodesktop -r "addpath('/data');addpath('/opt/nordic/NORDIC_Raw');cd('/data');NIFTI_NORDIC('$MAGNITUDE_FILE', '$PHASE_FILE', '$OUTPUT_FILE');exit;" | tail -n +11
else
    echo "Apptainer found. Running NIFTI_NORDIC.m inside Apptainer container."
    # Run Apptainer container with NIFTI_NORDIC.m
    export MLM_LICENSE_FILE=13501@10.168.83.190
    apptainer exec --bind "$DATA_DIR":"$DATA_DIR" nordic_denoise.sif matlab -nodisplay -nosplash -nodesktop -r "addpath("$DATA_DIR");addpath('/opt/nordic/NORDIC_Raw-main/');cd("$DATA_DIR");NIFTI_NORDIC('$MAGNITUDE_FILE', '$PHASE_FILE', '$OUTPUT_FILE');exit;" | tail -n +11
fi


