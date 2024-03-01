#!/bin/bash

## This bash script generates 100 vcf triploid files with no missing data using vcf simulator

# Create a directory to store the triploid files
#mkdir -p triploid_files

# Specify the number of files to create
num_files=1000

# Loop to create files
for ((i=1; i<=$num_files; i++)); do
    seed=$((123 + i))  # Increment seed for each iteration
    python vcfsim --chromosome 3 --replicates 1 --sequence_length 1000 --ploidy 3 --Ne 3000000 --mu 1e-8 --seed $seed --percent_missing_sites 0 --percent_missing_genotypes 0 --sample_size 100 --output_file "./triploid_files/file$i.vcf"
    echo "Created file$i with seed $seed"
done

echo "Files created successfully!"

