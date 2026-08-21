source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 26.93 -o box250.gro -nmol 250
gmx solvate -cp box250.gro -cs water.gro -o solv-box250.gro -p topol.top

gmx grompp -f em.mdp -c solv-box250.gro -p topol.top -o em-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv250 -nt $1 

gmx grompp -f nvt.mdp -c em-solv250.gro -p topol.top -o nvt-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv250 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv250.gro -p topol.top -o npt1-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv250 -nt $1

gmx grompp -f npt.mdp -c npt1-solv250.gro -p topol.top -o npt2-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv250 -nt $1

gmx grompp -f npt.mdp -c npt2-solv250.gro -p topol.top -o npt3-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv250 -nt $1

gmx grompp -f npt.mdp -c npt3-solv250.gro -p topol.top -o npt4-solv250.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv250 -nt $1
