#!/bin/bash

# Function to generate populations file
generate_populations_file() {
    # Define the header
    #echo "Sample_ID\tPopulation"
    
    # Extract sample IDs from VCF file
    awk 'BEGIN{OFS="\t"} /CHROM/ {for(i=10;i<=NF;i++) {gsub(/\./,"_",$i); print $i, "Pop" i-9}}' "$1"
}

# Check if VCF file provided as argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <vcf_file>"
    exit 1
fi

# Check if VCF file exists
if [ ! -f "$1" ]; then
    echo "Error: VCF file '$1' not found!"
    exit 1
fi

# Generate populations file
pop_file="populations.txt"
generate_populations_file "$1" > "$pop_file"
echo "Populations file created: $pop_file"
