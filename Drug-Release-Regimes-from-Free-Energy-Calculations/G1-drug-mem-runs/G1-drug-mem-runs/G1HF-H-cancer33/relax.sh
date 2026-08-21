#!/bin/bash -l

#SBATCH --job-name G1HF-F-cancer33
#SBATCH --gres gpu:a40:2
#SBATCH --cpus-per-task=32
#SBATCH --time 1-00:00:00

module load gromacs/2022.4-gcc11.2.0-mkl-cuda



gmx grompp -f npt.mdp -c nvt.gro -p topol.top -o npt.tpr -maxwarn 1
gmx mdrun -v -deffnm npt 

rm -r *#


