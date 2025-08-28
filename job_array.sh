#!/bin/bash
#SBATCH --job-name=task_array
#SBATCH --output=logs/output_%A_%a.out
#SBATCH --error=logs/error_%A_%a.err
#SBATCH --array=0-9
#SBATCH --ntasks=1
#SBATCH --time=00:01:00
#SBATCH --mem=512M
#SBATCH --partition=<partition>
#SBATCH --qos=<qos>
#SBATCH --requeue

spack env activate scratch/spack/hpc-tests
spack load miniconda3

source activate hpc-tests
python task.py