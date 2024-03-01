#!/bin/bash

# Define the folder containing the input files
input_folder="./triploid_files"

# Loop through each .txt file in the folder
for file in "$input_folder"/*.txt; do
    # Check if the file exists and is a regular file
    if [ -f "$file" ]; then
        # Output file with invariant sites
        output_file="${file%.txt}_invariant.txt"

        # Generate a temporary file for intermediate processing
        temp_file="$(dirname "$file")/temp_$(basename "$file").vcf"

        # Extract all sites from the input file
        zgrep -v "^#" "$file" > "$temp_file"

        # Identify sites with variant alleles
        grep -v "^#" "$temp_file" | awk '{print $1,$2,$5}' | sort -u > variant_sites.txt

        # Extract invariant sites by comparing all sites with variant sites
        grep -v "^#" "$temp_file" | awk '{print $1,$2}' | sort -u | \
            grep -v -f variant_sites.txt | awk '{print $1,$2,".","A",".",".",".",".","GT","0/0"}' | \
            sed 's/ /\t/g' > invariant_sites.txt

        # Store header lines
        grep "^#" "$file" > header.txt

        # Concatenate variant and invariant sites along with header to create the final VCF
        cat header.txt "$temp_file" > "$output_file"
        awk 'NR == FNR {variants[$1":"$2] = 1; next} !($1":"$2 in variants)' variant_sites.txt "$temp_file" >> "$output_file"

        # Clean up temporary files
        rm "$temp_file" variant_sites.txt header.txt

        echo "Invariant sites generated for $file and saved in $output_file"
    fi
done

