#!/bin/bash

#SBATCH --job-name=task_array
#SBATCH --account=your_account_here
#SBATCH --qos=your_qos_here
#SBATCH --ntasks=1
#SBATCH --mem=512M
#SBATCH --array=0-4
#SBATCH --time=00:03:00
#SBATCH --output=./output/%x_%A_%a.out
#SBATCH --error=./output/%x_%A_%a.err
#SBATCH --requeue

mkdir -p ./output

USER=$(whoami)
SPACK_ENV=your_spack_env
CONDA_ENV=your_conda_env

spack env activate /scratch/$USER/spack/$SPACK_ENV
spack load miniconda3

source activate $CONDA_ENV

python job_array.py ${SLURM_ARRAY_TASK_ID}