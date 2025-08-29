#!/bin/sh

#SBATCH --job-name=deploy_jupyter
#SBATCH --account=your_account_here
#SBATCH --qos=your_qos_here
#SBATCH --ntasks=1
#SBATCH --mem=2G
#SBATCH --partition=specify_partition_here
#SBATCH --nodelist=specify_node_here
#SBATCH --time=30:00
#SBATCH --gres=gpu:1
#SBATCH --error=./output/%x_%j.err
#SBATCH --output=./output/%x_%j.out

mkdir -p ./output

LOGIN_IP=$(hostname -I | awk '{print $1}')
NODE=$(scontrol show hostnames $SLURM_NODELIST | head -n1)
USER=$(whoami)
SPACK_ENV=your_spack_env
CONDA_ENV=your_conda_env

spack env activate /scratch/$USER/spack/$SPACK_ENV
spack load miniconda3

source activate $CONDA_ENV

JPORT=$(shuf -i 8400-8500 -n 1)

echo "JupyterLab starting on port $JPORT"
echo "Access via: ssh -N -L localhost:$JPORT:$NODE:$JPORT $USER@LOGIN_IP -vvv"

jupyter lab --no-browser --ip=$NODE --port=$JPORT --NotebookApp.token='your_custom_token_here'