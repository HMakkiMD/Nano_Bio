source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 24.62 -o box191.gro -nmol 191

gmx insert-molecules -f box191.gro -ci drug.gro -nmol 79 -o final.gro
gmx solvate -cp final.gro -cs water.gro -o solv-box191.gro -p topol.top

gmx grompp -f em.mdp -c solv-box191.gro -p topol.top -o em-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv191 -nt $1 

gmx grompp -f nvt.mdp -c em-solv191.gro -p topol.top -o nvt-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv191 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv191.gro -p topol.top -o npt1-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv191 -nt $1 

gmx grompp -f npt.mdp -c npt1-solv191.gro -p topol.top -o npt2-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv191 -nt $1

gmx grompp -f npt.mdp -c npt2-solv191.gro -p topol.top -o npt3-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv191 -nt $1

gmx grompp -f npt.mdp -c npt3-solv191.gro -p topol.top -o npt4-solv191.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv191 -nt $1

