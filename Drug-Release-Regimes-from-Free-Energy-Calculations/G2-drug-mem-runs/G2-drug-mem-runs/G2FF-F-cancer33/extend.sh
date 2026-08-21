#!/bin/bash -l

#SBATCH --job-name G2FF-F-cancer33
#SBATCH --gres gpu:a40:2
#SBATCH --cpus-per-task=32
#SBATCH --time 1-00:00:00

module load gromacs/2022.4-gcc11.2.0-mkl-cuda


gmx mdrun -s npt.tpr -cpi npt.cpt -deffnm npt

rm -r *#


