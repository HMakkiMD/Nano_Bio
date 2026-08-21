source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 25.65 -o box216.gro -nmol 216

gmx insert-molecules -f box216.gro -ci drug.gro -nmol 71 -o final.gro

gmx solvate -cp final.gro -cs water.gro -o solv-box216.gro -p topol.top

gmx grompp -f em.mdp -c solv-box216.gro -p topol.top -o em-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv216 -nt $1 

gmx grompp -f nvt.mdp -c em-solv216.gro -p topol.top -o nvt-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv216 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv216.gro -p topol.top -o npt-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm npt-solv216 -nt $1 

gmx grompp -f npt.mdp -c npt-solv216.gro -p topol.top -o npt1-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv216 -nt $1 

gmx grompp -f npt.mdp -c npt1-solv216.gro -p topol.top -o npt2-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv216 -nt $1 

gmx grompp -f npt.mdp -c npt2-solv216.gro -p topol.top -o npt3-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv216 -nt $1 

gmx grompp -f npt.mdp -c npt3-solv216.gro -p topol.top -o npt4-solv216.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv216 -nt $1 