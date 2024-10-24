## Project pINSR

### Data 
* Crystal structure 1 (2 bound Insulin)
* Crystal structure 2 (3 bouund insulin)

---

### Steps

1. ProteinMPNN from insulin chains
2. AF2 monomer for sanity check on preserving structure
3. Docking (FRODOCK) OR AF3 multimer pred
4. MD simulation on docked candidates (OpenMM w/ GPU)

v0: MPNN --> AF sanity check for monomer --> AF2 multimer --> Docking --> MD Sim.

---

### Future
1. Check what residues are involved in insulin binds
2. RF for side chain modeling into the INSR binding pocket. This acts as an MPO is there are different parts of the Insulin helix that interact w/ the different pockets (Minimze RMSD)
3. Add cell membranes to simulation?
4. RFDiffusion to make cyclic peptides? ProteinMPNN from cyclic peptides