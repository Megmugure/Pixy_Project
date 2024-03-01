#!/bin/bash
## This script is used to calculate pi across all the 100 diploid files, with no missing data

# Define the folder containing the files
folder=./diploid_missing_sites

# Loop through each file in the folder
for file in "$folder"/*.gz; do
    # Check if the item is a file
    if [ -f "$file" ]; then
        # Extract the directory part of the input file path
        output_folder=$(dirname "$file")

        # Define the output prefix
        output_prefix=$(basename "$file" .gz)

        # Define the command you want to run
        command_to_run="pixy --stats pi --vcf $file --populations populations.txt --window_size 10000 --n_cores 2 --bypass_invariant_check yes --output_prefix $output_prefix"

        # Run the command on the file and redirect the output to a separate file in the same folder
        output_file="./diploid_missing_sites/${output_prefix}_pi.txt"
    fi
done

