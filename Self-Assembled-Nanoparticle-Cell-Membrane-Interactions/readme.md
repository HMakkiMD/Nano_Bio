## Author

Mahsa Nami

## Introduction

This repository contains all input files, simulation workflows, and representative
output structures used in a multiscale molecular dynamics (MD) study of
self-assembled amphiphilic nanoparticles (NPs) and their interactions with
biomimetic lipid membranes.

Simulations were performed using **GROMACS 2022**, employing the **Martini 3**
coarse-grained (CG) force field and the **CHARMM36** force field for atomistic
(AA) simulations. Reverse mapping from CG to AA resolution was carried out
following published methodologies referenced in the associated manuscript.
The repository is organized to ensure reproducibility of all major simulation
stages reported in the study.

---

## Repository Structure


---

## Simulation Workflow

### 1. Atomistic Amphiphile Models

The directory `atomistic-amphiphiles/` contains atomistic structures and
force-field files generated using **CHARMM-GUI**. These systems were used as
reference models for coarse-graining and validation of the CG parameters.

---

### 2. Nanoparticle Self-Assembly (CG)

The directory `self-assembly/` contains:
- Martini 3 force-field files
- MDP files for energy minimization (EM), NVT, and NPT simulations
- Input structures of individual amphiphiles
- Topology files required for nanoparticle formation

Simulation procedure:
1. Amphiphiles were inserted into a cubic simulation box.
2. The system was solvated to achieve a concentration of **20 mM**.
3. EM → NVT → NPT simulations were performed.
4. Self-assembled nanoparticles formed spontaneously during NPT simulations.

The final self-assembled nanoparticle for each system is provided as a
representative structure (`centerx.gro`).

---

### 3. Reverse Mapping (CG → AA)

The directory `reverse-mapping/` contains reverse-mapped atomistic nanoparticle
models for all six systems.

Reverse mapping was performed following the protocol described in the manuscript
using the **Initram / Backward** approach. The final atomistic structure was
generated using the following command:

bash initram-v5-gmx.sh \
 -f product_modified.gro \
 -o AA.gro \
 -from martini \
 -to charmm36 \
 -p topol.top \

Each reverse-mapped system was subsequently relaxed using successive
energy minimization, NVT, and NPT simulations with the provided MDP files.


### 4. Nanoparticle–Membrane Interaction Simulations

The directory nano-membrane-runs/ contains all files required to simulate
interactions between self-assembled nanoparticles and lipid membranes.

This directory includes:

-Force-field files
-ITP files for water, ions, lipids, and nanoparticles
-MDP files for EM, NVT, and NPT simulations

Within nano-membrane-runs/, each nanoparticle has its own folder. Inside each
nanoparticle folder, separate subfolders correspond to different membrane models.
Each membrane-specific folder contains:

The initial configuration of the nanoparticle positioned near the membrane (initial.gro)

-Nanoparticle ITP file
-System topology file

All nanoparticle–membrane systems were simulated using
EM → NVT → NPT protocols.

For selected systems, a representative final configuration after 1500 ns
is provided as a .gro file. Only final structure files are included; full
trajectory files are not provided.

Membrane Model Naming Convention:
Due to file-naming constraints, membrane models are labeled as follows:

Folder name	Corresponding model	Description

- cancer0		M*0			symmetric membrane, 0% CHOL
- cancer33	M*33			symmetric membrane, 33% CHOL
- normal0		M0			Asymmetric membrane, 0% CHOL
- normal33	M33			Asymmetric membrane, 33% CHOL

These labels are used consistently throughout the repository.


---------

Software Requirements

GROMACS 2022

Martini 3 force field

CHARMM36 force field

VMD (for visualization)

Bash shell environment
----------

Notes

Large trajectory files (e.g., .xtc, .trr) are excluded due to file size
limitations.

The repository contains all input files and representative final structures
required to reproduce the simulations reported in the associated study.
