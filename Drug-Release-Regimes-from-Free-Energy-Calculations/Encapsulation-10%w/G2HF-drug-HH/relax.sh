source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 22.96 -o box155.gro -nmol 155

gmx insert-molecules -f box155.gro -ci drug.gro -nmol 85 -o final.gro

gmx solvate -cp final.gro -cs water.gro -o solv-box155.gro -p topol.top


gmx grompp -f em.mdp -c solv-box155.gro -p topol.top -o em-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv155 -nt $1 

gmx grompp -f nvt.mdp -c em-solv155.gro -p topol.top -o nvt-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv155 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv155.gro -p topol.top -o npt-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm npt-solv155 -nt $1 

gmx grompp -f npt.mdp -c npt-solv155.gro -p topol.top -o npt1-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv155 -nt $1 

gmx grompp -f npt.mdp -c npt1-solv155.gro -p topol.top -o npt2-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv155 -nt $1

gmx grompp -f npt.mdp -c npt2-solv155.gro -p topol.top -o npt3-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv155 -nt $1

gmx grompp -f npt.mdp -c npt3-solv155.gro -p topol.top -o npt4-solv155.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv155 -nt $1