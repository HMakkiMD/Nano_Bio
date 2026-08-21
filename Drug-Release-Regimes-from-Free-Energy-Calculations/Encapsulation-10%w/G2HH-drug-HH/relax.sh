source /usr/local/gromacs-2022/bin/GMXRC

gmx insert-molecules -ci 1.gro -box 23.73 -o box171.gro -nmol 171
gmx solvate -cp box171.gro -cs water.gro -o solv-box171.gro -p topol.top

gmx grompp -f em.mdp -c solv-box171.gro -p topol.top -o em-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm em-solv171 -nt $1 

gmx grompp -f nvt.mdp -c em-solv171.gro -p topol.top -o nvt-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt-solv171 -nt $1 

gmx grompp -f npt.mdp -c nvt-solv171.gro -p topol.top -o npt-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt-solv171 -nt $1

gmx grompp -f npt.mdp -c npt-solv171.gro -p topol.top -o npt1-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt1-solv171 -nt $1

gmx grompp -f npt.mdp -c npt1-solv171.gro -p topol.top -o npt2-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt2-solv171 -nt $1

gmx grompp -f npt.mdp -c npt2-solv171.gro -p topol.top -o npt3-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt3-solv171 -nt $1

gmx grompp -f npt.mdp -c npt3-solv171.gro -p topol.top -o npt4-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt4-solv171 -nt $1

gmx grompp -f npt.mdp -c npt4-solv171.gro -p topol.top -o npt5-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt5-solv171 -nt $1

gmx grompp -f npt.mdp -c npt5-solv171.gro -p topol.top -o npt6-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt6-solv171 -nt $1

gmx grompp -f npt.mdp -c npt6-solv171.gro -p topol.top -o npt7-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt7-solv171 -nt $1

gmx grompp -f npt.mdp -c npt7-solv171.gro -p topol.top -o npt8-solv171.tpr -maxwarn 1
gmx mdrun -v -deffnm npt8-solv171 -nt $1
