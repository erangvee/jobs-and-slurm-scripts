#!/bin/sh

#SBATCH --account=hpcisd
#SBATCH --qos=research
#SBATCH --job-name=test_jupyter
#SBATCH --ntasks=1
#SBATCH --mem=2G
#SBATCH --partition=<partition>
#SBATCH --nodelist=<nodename>
#SBATCH --gres=gpu:1
#SBATCH --error=./error/jupyter_lab_error_%j
#SBATCH --output=./output/jupyter_lab_out_%j

spack env activate scratch/spack/testenv
spack load miniconda3

source activate testenv

JPORT=$(shuf -i 8400-8500 -n 1)

echo "JupyterLab starting on port $JPORT"
echo "Access via: ssh -N -L localhost:$JPORT:<nodename>:$JPORT your_username@10.10.1.1"

jupyter lab --no-browser --ip=orion-03 --port=$JPORT --NotebookApp.token='<yourtoken>'