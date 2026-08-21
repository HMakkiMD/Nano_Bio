# Transfer Free Energies Predict Drug Release Regimes in Self-Assembled Nanocarriersn

**Author**

Mahsa Nami

## Introduction

This repository contains the input files, simulation workflows, and representative output structures used in a coarse-grained molecular dynamics (MD) study of drug co-assembly with amphiphilic nanoparticles (NPs) and of the interaction of the resulting drug-loaded nanoparticles with cancer-mimetic lipid membranes.

All simulations were performed with **GROMACS 2022** and the **Martini 3** coarse-grained force field. The amphiphile library and the membrane models are those validated in the companion study of the drug-free systems; this repository covers the drug-loaded systems reported in the associated manuscript. It is organized so that every simulation stage described in the manuscript can be reproduced from the files provided.

## Repository Structure

```
.
├── martini3.itp                 # Martini 3 force-field file (shared by all runs)
├── Encapsulation-10%w/          # Drug–amphiphile co-assembly, 10% w/w drug loading
├── G1-drug-mem-runs/            # Drug-loaded G1 nanoparticles in contact with membranes
└── G2-drug-mem-runs/            # Drug-loaded G2 nanoparticles in contact with membranes
```

The Martini 3 force-field file is kept at the top level rather than duplicated in every system folder, because of its size. Every `topol.top` in this repository includes it as

```
#include "martini3.itp"
```

so `martini3.itp` must be copied into (or symlinked from) the working directory of any run before `gmx grompp` is called.

## Naming Conventions

**Amphiphiles.** `G1` and `G2` denote the first- and second-generation oligoglycerol headgroups; `HH`, `HF` and `FF` denote fully hydrocarbon, semi-fluorinated and fully fluorinated tail pairs. Residue names in the topologies follow the pattern `G1FFOH`, `G2HFOH`, and so on.

**Drugs.** Two leflunomide analogues differing only by a CH₃ → CF₃ substitution:

| Residue | Manuscript name | Compound |
|---|---|---|
| `LEFLG` | H-Drug | leflunomide G (non-fluorinated) |
| `LEFL`  | F-Drug | leflunomide (fluorinated) |

**Co-assembly folders.** Folders in `Encapsulation-10%w/` are named `<amphiphile>-drug-<drug tail type>`, where the suffix indicates which drug was used: `-drug-HH` is the hydrocarbon drug (H-Drug, `LEFLG`) and `-drug-FF` is the fluorinated drug (F-Drug, `LEFL`). For example, `G1HF-drug-FF` is the G1HF amphiphile co-assembled with F-Drug, referred to in the manuscript as **G1HF-F**.

**Membrane models.** Because of file-naming constraints, the membrane models are labelled as follows, consistently throughout the repository:

| Folder name | Manuscript label | Description |
|---|---|---|
| `cancer0`  | M\*0  | Symmetric cancer-mimetic membrane, 0 mol% cholesterol |
| `cancer33` | M\*33 | Symmetric cancer-mimetic membrane, 33 mol% cholesterol |

---

## 1. Drug–Amphiphile Co-Assembly (`Encapsulation-10%w/`)

This directory contains one folder for each of the eight amphiphile–drug combinations studied. Each folder contains everything needed to run the co-assembly from scratch:

| File | Content |
|---|---|
| `1.gro` | Single coarse-grained amphiphile |
| `drug.gro` | Single coarse-grained drug molecule |
| `water.gro` | Martini water box used for solvation |
| `<amphiphile>-CG.itp` | Amphiphile topology |
| `leflunomide.itp` | Drug topology (both analogues) |
| `water.itp` | Water topology |
| `topol.top` | System topology, listing the amphiphile and drug counts |
| `em.mdp`, `nvt.mdp`, `npt.mdp` | Energy minimization, NVT and NPT parameters |
| `relax.sh` | Complete build-and-run script for the system |
| `<amphiphile>-<drug>.gro` | Final self-assembled drug-loaded nanoparticle |

### Simulation procedure

The workflow implemented in `relax.sh` is:

1. Insert the amphiphiles into a cubic box of the size given below, chosen so that the amphiphile concentration is **20 mM**.
2. Insert the drug molecules into the same box.
3. Solvate with Martini water.
4. Energy minimization → NVT → four successive NPT runs.
5. The drug-loaded nanoparticle assembles spontaneously during the NPT stage.

Production runs used a 15 fs time step at 350 K with isotropic pressure coupling. The final self-assembled structure of each system is provided as a representative `.gro` file; trajectories are not included.

### System compositions at 10% w/w loading

All counts below are those in the `topol.top` files of this directory, and correspond to Table 1 of the manuscript.

| Folder | Manuscript system | Amphiphile | N<sub>amph</sub> | Drug | N<sub>drug</sub> | Box (nm) |
|---|---|---|---|---|---|---|
| `G1HH-drug-HH` | G1HH-H | G1HHOH | 250 | LEFLG | 76 | 26.93 |
| `G2HH-drug-HH` | G2HH-H | G2HHOH | 171 | LEFLG | 75 | 23.73 |
| `G1HF-drug-HH` | G1HF-H | G1HFOH | 216 | LEFLG | 89 | 25.65 |
| `G2HF-drug-HH` | G2HF-H | G2HFOH | 155 | LEFLG | 85 | 22.96 |
| `G1FF-drug-FF` | G1FF-F | G1FFOH | 191 | LEFL  | 79 | 24.62 |
| `G2FF-drug-FF` | G2FF-F | G2FFOH | 141 | LEFL  | 74 | 22.25 |
| `G1HF-drug-FF` | G1HF-F | G1HFOH | 216 | LEFL  | 71 | 25.65 |
| `G2HF-drug-FF` | G2HF-F | G2HFOH | 155 | LEFL  | 68 | 22.96 |

### Reproducing the lower drug loadings (5% and 2.5% w/w)

Only the 10% w/w systems are provided, because the lower loadings differ from them in a single number. The amphiphile count, the box size and every `.mdp` file stay exactly as they are; only the drug count changes.

To build a **5% w/w** system, halve the number of drug molecules; to build a **2.5% w/w** system, take one quarter. Round to the nearest integer. Two edits are needed:

1. In `relax.sh`, change the drug count in the second command,
   `gmx insert-molecules -f box<N>.gro -ci drug.gro -nmol <N_drug> -o final.gro`
2. In `topol.top`, change the corresponding entry in the `[ molecules ]` section.

For example, for `G1FF-drug-FF`: 79 drug molecules at 10% w/w, 40 at 5% w/w, and 20 at 2.5% w/w. The resulting counts for all systems are the ones listed in Table 1 of the manuscript.

### Reproducing the concentration series

The concentration-dependent occupancy simulations (5–80 mM amphiphile) were not built from scratch. They were generated from the equilibrated 20 mM systems in this directory by changing the amount of water only:

1. Take the final equilibrated structure of the system of interest.
2. Rescale the box to the volume that gives the target amphiphile concentration — reduce it and delete the surplus water for higher concentrations, enlarge it and solvate the new volume for lower concentrations.
3. Update the water count in `topol.top` accordingly.
4. Re-run energy minimization → NVT → NPT with the `.mdp` files already provided in the folder.

The nanoparticle itself is not rebuilt at any point in this procedure, so the series probes the effect of the surrounding aqueous volume alone.

---

## 2. Nanoparticle–Membrane Interaction Runs (`G1-drug-mem-runs/`, `G2-drug-mem-runs/`)

These two directories contain the contact simulations between the drug-loaded nanoparticles and the two membrane models, separated by headgroup generation. Within each, one folder per nanoparticle–membrane pair is named `<system>-<membrane>`, for example `G1FF-F-cancer0`.

Each folder contains:

| File | Content |
|---|---|
| `nvt.gro` | Initial configuration: the drug-loaded nanoparticle positioned near the membrane, after the restrained approach and NVT equilibration. This is the starting point of the production run. |
| `topol.top` | Full system topology, including the leaflet-by-leaflet lipid composition |
| `<amphiphile>-CG-<drug>.itp` | Amphiphile topology for the loaded nanoparticle |
| `leflunomide.itp` | Drug topology |
| `DOPC.itp`, `DOPE.itp`, `DOPS.itp`, `POSM.itp`, `CHOL.itp` | Lipid topologies |
| `water.itp`, `ION.itp` | Water and ion topologies |
| `npt.mdp` | Production run parameters |
| `relax.sh` | Job script for the production run |

### Simulation procedure

The nanoparticle was placed roughly 6 nm from the equilibrated membrane surface, brought to about 1 nm separation by a brief restrained approach, and then released. The production run in `npt.mdp` is unrestrained, uses a 10 fs time step at 310 K with semi-isotropic pressure coupling, and is the trajectory analysed in the manuscript.

To run a system:

```bash
gmx grompp -f npt.mdp -c nvt.gro -p topol.top -o npt.tpr -maxwarn 1
gmx mdrun -v -deffnm npt
```

Note that the nanoparticle in these systems carries only its encapsulated drug; unencapsulated drug remaining in bulk water at the end of co-assembly was removed before the nanoparticle was brought into contact with the membrane. The drug count in `topol.top` is therefore the encapsulated number, which is smaller than the count in the corresponding co-assembly folder. For `G1FF-F-cancer0`, for instance, the topology lists 63 drug molecules against the 79 originally fed.

---

## Software Requirements

- GROMACS 2022
- Martini 3 force field (`martini3.itp`, provided at the top level of this repository)
- Bash shell environment
- VMD or an equivalent tool, for visualization

## Notes

- Trajectory files (`.xtc`, `.trr`) are excluded because of file-size limitations. The repository provides the input files and representative final structures needed to reproduce every simulation reported in the associated study.
- `martini3.itp` is stored once at the top level and must be made available in the working directory of each run, as described above.
- The `.mdp` files provided in each folder are those actually used for the runs reported in the manuscript, and require no modification for reproduction.
