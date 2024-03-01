#!/bin/bash

## This bash script generates VCF files with no missing data and with missing sites/missing genotypes

# Create output folders for each scenario
mkdir -p diploid_no_missing_data diploid_missing_sites diploid_missing_genotypes

# Specify the number of files to create
num_files=10
missing_step=1  # Stepwise iteration for missing data percentage

# Loop to create files with no missing data
#: <<'COMMENTED'
#for ((i=1; i<=$num_files; i++)); do
#    seed=$((246 + i))  # Increment seed for each iteration
#    python vcfsim --chromosome 3 --replicates 1 --sequence_length 1000 --ploidy 2 --Ne 1000000 --mu 1e-8 --seed $seed --percent_missing_sites 0 --percent_missing_genotypes 0 --sample_size 100 --output_file "./diploid_no_missing_data/file${i}_no_missing.vcf"
#    echo "Created file${i}_no_missing with seed $seed"
#done
#COMMENTED

# Loop to create files with missing sites
#missing_sites_seed_start=100
#missing_sites_percentage=1
#while (( $missing_sites_percentage <= 99 )); do
    #missing_sites_seed_end=$((missing_sites_seed_start + num_files - 1))  # End seed range
    #for ((seed=$missing_sites_seed_start; seed<=$missing_sites_seed_end; seed++)); do
     #   python vcfsim --chromosome 3 --replicates 1 --sequence_length 1000 --ploidy 2 --Ne 1000000 --mu 1e-8 --seed $seed --percent_missing_sites $missing_sites_percentage --percent_missing_genotypes 0 --sample_size 100 --output_file "./diploid_missing_sites/file$((seed - missing_sites_seed_start + 1))_missing_sites_$(bc <<< "scale=2; $missing_sites_percentage / 100").txt"
    #    echo "Created file$((seed - missing_sites_seed_start + 1))_missing_sites_${missing_sites_percentage} with seed $seed"
   # done
  #  ((missing_sites_seed_start += num_files))
 #   ((missing_sites_percentage += missing_step))
#done

# Loop to create files with missing genotypes
missing_genotypes_seed_start=20000
missing_genotypes_percentage=1
while (( $missing_genotypes_percentage <= 99 )); do
    missing_genotypes_seed_end=$((missing_genotypes_seed_start + num_files - 1))  # End seed range
    for ((seed=$missing_genotypes_seed_start; seed<=$missing_genotypes_seed_end; seed++)); do
        python vcfsim --chromosome 3 --replicates 1 --sequence_length 1000 --ploidy 2 --Ne 1000000 --mu 1e-8 --seed $seed --percent_missing_sites 0 --percent_missing_genotypes $missing_genotypes_percentage --sample_size 100 --output_file "./diploid_missing_genotypes/file$((seed - missing_genotypes_seed_start + 1))_missing_genotypes_$(bc <<< "scale=2; $missing_genotypes_percentage / 100").txt"
        echo "Created file$((seed - missing_genotypes_seed_start + 1))_missing_genotypes_${missing_genotypes_percentage} with seed $seed"
    done
    ((missing_genotypes_seed_start += num_files))
    ((missing_genotypes_percentage += missing_step))
done

echo "Files created successfully!"
