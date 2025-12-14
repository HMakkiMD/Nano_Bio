#!/bin/bash -l

#SBATCH --job-name G1HHOH
#SBATCH -p gputroisi
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --gres gpu:1
#SBATCH --time 5-00:00:00
#SBATCH --mail-type END
#SBATCH --mail-user h.makki@liverpool.ac.uk

#module load apps/gromacs_cuda/2024.1
#module load apps/anaconda3/2022.10
#source activate myenv

#python3 aa_itp_gen.py
bash initram-v5-gmx.sh -f product_modified.gro -o AA.gro -from martini -to charmm36 -p topol.top -np 18
یادت باشه وقتی ران رو به دکتر میدی اسم ها رو هد و تیل و لینک بزاری