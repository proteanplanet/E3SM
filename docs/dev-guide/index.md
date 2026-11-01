# Development Guide

Development of E3SM is carefully planned and tied to goals in the proposals that fund
work on E3SM.

## Code development

Most code development occurs within one component and developers should consult the
relevant component's development guide.

More information on code development.

+ [Development Big Picture](https://acme-climate.atlassian.net/wiki/spaces/DOC/pages/7997024/Development+Big+Picture)
+ [Getting Started](https://acme-climate.atlassian.net/wiki/spaces/DOC/pages/1868455/Development+Getting+Started+Guide)
+ [Development Reference](https://acme-climate.atlassian.net/wiki/spaces/DOC/pages/2523163/Development+Reference)

## Shared physical constants

E3SM's PhysicalConstantsDictionary (PCD) is stored in `share/pcd.yaml`.
Its generated Fortran module and C++ header are in
`share/util/pcd_const.F90` and `share/util_cxx/pcd_const.h`.
Regenerate both outputs with the PCD repository's `tools/generate_source.py`;
do not edit generated declarations manually.

`share/util/shr_const_mod.F90` maps matching PCD entries into the existing
`SHR_CONST_*` interface. Both MCT and MOAB drivers, including their shared
flux and diagnostic routines, receive these references through that interface.
PCD imports are private; the public names, real kinds, and parameter status
remain unchanged. This also affects components using the shared module, not
just the coupler. It does not migrate separate copies of the module in
component tools or external libraries.

PCD uses per-mole units, whereas the shared interface uses per-kilomole units
for Avogadro's number, molecular weights, and the universal gas constant.
Those mappings multiply by 1000. Specific gas constants remain in J/(kg K).
Use the atmospheric reference water-vapor molar mass, not the distinct
pure-water molar mass. Conventional seawater heat capacity and reference
salinity retain their meanings; they are not replaced by the TEOS-10 entries.

Gas constants and standard-temperature air density use PCD's derived
expressions. Other shared ratios and land-ice thermal diffusivity remain
derived from the mapped inputs. Gravity and the Boltzmann and Avogadro
constants change to PCD reference values; derived values and floating-point
rounding can also change. This migration is not BFB with the legacy revision.

The model's spherical Earth radius and paired sidereal day/rotation rate
remain unchanged: PCD's geometric radii and reference angular velocity are
not interchangeable with those model definitions. Von Karman, seawater
freezing relations, model depths, missing-value sentinels, numerical
tolerances, and isotope tuning values without corresponding PCD entries
also remain local. Empirical coefficients inside flux parameterizations are
not automatically replaced by dictionary values.

The fixed day unit is exactly 86400 SI seconds, following
[NIST SP 330 (2019), Section 4, Table 8](https://doi.org/10.6028/NIST.SP.330-2019).
This does not redefine model calendars, sidereal days, or historical UTC
leap-second days. Continuous UTC becomes effective on 20 May 2027 under
[CGPM Resolution 5 (2026)](https://doi.org/10.59161/CGPM2026RES5E).

CIME builds PCD and the shared constants module in the existing shared
library source list. Neither driver needs a second PCD source or a new
constant-selection namelist option. External MCT and MOAB libraries do not
need a direct PCD dependency.

Validate both drivers with restart and MPI/thread reproducibility tests
on a supported machine, and review coupled conservation diagnostics.
Because the shared module also supplies component constants, include
atmosphere, land, and ocean coverage before accepting this migration.

## Creating new input

E3SM's public input data directory contains initial and boundary conditions for many cases.
Creating new initial or boundary conditions typically starts with creating a new grid.

+ [Adding Support for New Grids](adding-grid-support/index.md)

## Testing

+ [Testing on GitHub-hosted runners](gh-hosted-testing.md)
