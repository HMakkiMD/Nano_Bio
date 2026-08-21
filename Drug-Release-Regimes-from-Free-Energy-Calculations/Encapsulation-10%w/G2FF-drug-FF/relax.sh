source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 22.25 -o box141.gro -nmol 141

gmx insert-molecules -f box141.gro -ci drug.gro -nmol 74 -o final.gro

gmx solvate -cp final.gro -cs water.gro -o solv-box141.gro -p topol.top

gmx grompp -f em.mdp -c solv-box141.gro -p topol.top -o em-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv141 -nt $1

gmx grompp -f nvt.mdp -c em-solv141.gro -p topol.top -o nvt-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv141 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv141.gro -p topol.top -o npt-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt-solv141 -nt $1 

gmx grompp -f npt.mdp -c npt-solv141.gro -p topol.top -o npt1-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv141 -nt $1

gmx grompp -f npt.mdp -c npt1-solv141.gro -p topol.top -o npt2-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv141 -nt $1

gmx grompp -f npt.mdp -c npt2-solv141.gro -p topol.top -o npt3-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv141 -nt $1

gmx grompp -f npt.mdp -c npt3-solv141.gro -p topol.top -o npt4-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv141 -nt $1

gmx grompp -f npt.mdp -c npt4-solv141.gro -p topol.top -o npt5-solv141.tpr -maxwarn 1
gmx mdrun -v -deffnm npt5-solv141 -nt $1

