!===============================================================================
! SVN $Id: shr_const_mod.F90 61510 2014-06-26 21:58:56Z tcraig $
! SVN $URL: https://svn-ccsm-models.cgd.ucar.edu/csm_share/trunk_tags/share3_150116/shr/shr_const_mod.F90 $
!===============================================================================

MODULE shr_const_mod

   use shr_kind_mod, only : R8 => shr_kind_r8
   use pcd, only : pcd_pi => pi, pcd_cday => seconds_per_day, &
        pcd_g => standard_acceleration_of_gravity, &
        pcd_stebol => stefan_boltzmann_constant, pcd_boltz => boltzmann_constant, &
        pcd_avogad => avogadro_constant, pcd_rgas => molar_gas_constant, &
        pcd_mwdair => dry_air_molar_mass_reference, &
        pcd_mwwv => water_vapor_molar_mass_reference, &
        pcd_mwc => carbon_molar_mass_reference, pcd_mwo => oxygen_molar_mass_reference, &
        pcd_mwco2 => carbon_dioxide_molar_mass_reference, pcd_mwfe => iron_molar_mass_reference, &
        pcd_rdair => dry_air_specific_gas_constant_reference, &
        pcd_rwv => water_vapor_specific_gas_constant_reference, &
        pcd_pstd => standard_atmosphere, pcd_pdb => pee_dee_belemnite_ratio_13c_to_12c, &
        pcd_tktrip => water_triple_point_temperature, &
        pcd_tkfrz => pure_water_freezing_temperature_reference, &
        pcd_rhodair => dry_air_density_at_standard_temperature_and_pressure, &
        pcd_rhofw => pure_water_density_reference, pcd_rhosw => seawater_density_reference, &
        pcd_rhoice => sea_ice_density_reference, &
        pcd_cpdair => dry_air_specific_heat_capacity_reference, &
        pcd_cpwv => water_vapor_specific_heat_capacity_reference, &
        pcd_cpfw => pure_water_specific_heat_capacity_reference, &
        pcd_cpsw => seawater_specific_heat_capacity_reference, &
        pcd_cpice => sea_ice_specific_heat_capacity_reference, &
        pcd_latice => latent_heat_of_fusion_reference, pcd_latvap => latent_heat_of_vaporization_reference, &
        pcd_latsub => latent_heat_of_sublimation_reference, &
        pcd_condice => sea_ice_thermal_conductivity_reference, &
        pcd_ocn_ref_sal => ocean_reference_salinity, pcd_ice_ref_sal => sea_ice_reference_salinity, &
        pcd_vsmow_18o => vsmow_ratio_18o_to_16o, pcd_vsmow_17o => vsmow_ratio_17o_to_16o, &
        pcd_vsmow_16o => vsmow_fraction_16o_of_total_oxygen, &
        pcd_vsmow_d => vsmow_ratio_2h_to_1h, pcd_vsmow_t => vsmow_ratio_3h_to_1h, &
        pcd_vsmow_h => vsmow_fraction_1h_of_total_hydrogen

   !----------------------------------------------------------------------------
   ! physical constants (all data public)
   !----------------------------------------------------------------------------
   private :: R8
   private :: pcd_pi, pcd_cday, pcd_g, pcd_stebol, pcd_boltz, pcd_avogad, pcd_rgas, &
        pcd_mwdair, pcd_mwwv, pcd_mwc, pcd_mwo, pcd_mwco2, pcd_mwfe, pcd_rdair, pcd_rwv, &
        pcd_pstd, pcd_pdb, pcd_tktrip, pcd_tkfrz, pcd_rhodair, pcd_rhofw, pcd_rhosw, pcd_rhoice, &
        pcd_cpdair, pcd_cpwv, pcd_cpfw, pcd_cpsw, pcd_cpice, pcd_latice, pcd_latvap, pcd_latsub, &
        pcd_condice, pcd_ocn_ref_sal, pcd_ice_ref_sal, pcd_vsmow_18o, pcd_vsmow_17o, &
        pcd_vsmow_16o, pcd_vsmow_d, pcd_vsmow_t, pcd_vsmow_h
   public

   ! Preserve the public API; convert PCD's per-mole units to per-kilomole units.
   real(R8),parameter :: SHR_CONST_PI      = pcd_pi         ! pi
   real(R8),parameter :: SHR_CONST_CDAY    = pcd_cday       ! fixed day unit ~ sec
   ! Keep the model's paired rotation period/rate and spherical radius.
   ! PCD's reference rotation rate and geometric radii are not equivalent.
   real(R8),parameter :: SHR_CONST_SDAY    = 86164.0_R8      ! sec in siderial day ~ sec
   real(R8),parameter :: SHR_CONST_OMEGA   = 2.0_R8*SHR_CONST_PI/SHR_CONST_SDAY ! earth rot ~ rad/sec
   real(R8),parameter :: SHR_CONST_REARTH  = 6.37122e6_R8    ! radius of earth ~ m
   real(R8),parameter :: SHR_CONST_G       = pcd_g          ! standard acceleration of gravity ~ m/s^2

   real(R8),parameter :: SHR_CONST_STEBOL  = pcd_stebol     ! Stefan-Boltzmann constant ~ W/m^2/K^4
   real(R8),parameter :: SHR_CONST_BOLTZ   = pcd_boltz      ! Boltzmann's constant ~ J/K/molecule
   real(R8),parameter :: SHR_CONST_AVOGAD  = pcd_avogad*1.0e3_R8 ! Avogadro's number ~ molecules/kmole
   real(R8),parameter :: SHR_CONST_RGAS    = pcd_rgas*1.0e3_R8 ! Universal gas constant ~ J/K/kmole
   real(R8),parameter :: SHR_CONST_MWDAIR  = pcd_mwdair*1.0e3_R8 ! molecular weight dry air ~ kg/kmole
   real(R8),parameter :: SHR_CONST_MWWV    = pcd_mwwv*1.0e3_R8 ! molecular weight water vapor ~ kg/kmole
   real(R8),parameter :: SHR_CONST_MWC     = pcd_mwc*1.0e3_R8 ! molecular weight carbon ~ kg/kmole
   real(R8),parameter :: SHR_CONST_MWO     = pcd_mwo*1.0e3_R8 ! molecular weight oxygen ~ kg/kmole
   real(R8),parameter :: SHR_CONST_MWCO2   = pcd_mwco2*1.0e3_R8 ! molecular weight carbon dioxide ~ kg/kmole
   real(R8),parameter :: SHR_CONST_MWFE    = pcd_mwfe*1.0e3_R8 ! molecular weight iron ~ kg/kmole
   real(R8),parameter :: SHR_CONST_RDAIR   = pcd_rdair       ! Dry air gas constant     ~ J/K/kg
   real(R8),parameter :: SHR_CONST_RWV     = pcd_rwv         ! Water vapor gas constant ~ J/K/kg
   real(R8),parameter :: SHR_CONST_ZVIR    = (SHR_CONST_RWV/SHR_CONST_RDAIR)-1.0_R8 ! RWV/RDAIR - 1.0
   real(R8),parameter :: SHR_CONST_KARMAN  = 0.4_R8          ! empirical Von Karman constant; not standardized in PCD
   real(R8),parameter :: SHR_CONST_PSTD    = pcd_pstd        ! standard pressure ~ pascals
   real(R8),parameter :: SHR_CONST_PDB     = pcd_pdb         ! ratio of 13C/12C in Pee Dee Belemnite (C isotope standard)

   real(R8),parameter :: SHR_CONST_TKTRIP  = pcd_tktrip      ! triple point of fresh water        ~ K
   real(R8),parameter :: SHR_CONST_TKFRZ   = pcd_tkfrz        ! freezing T of fresh water          ~ K
   ! Freezing relations and model depths remain formulation-specific.
   real(R8),parameter :: SHR_CONST_TKFRZSW = SHR_CONST_TKFRZ - 1.8_R8 ! freezing T of salt water  ~ K
   real(R8),parameter :: SHR_CONST_ZSRFLYR = 3.0_R8          ! ocn surf layer depth for diurnal SST cal ~ m

   real(R8),parameter :: SHR_CONST_RHODAIR = pcd_rhodair     ! density of dry air at STP  ~ kg/m^3
   real(R8),parameter :: SHR_CONST_RHOFW   = pcd_rhofw       ! density of fresh water     ~ kg/m^3
   real(R8),parameter :: SHR_CONST_RHOSW   = pcd_rhosw       ! density of sea water       ~ kg/m^3
   real(R8),parameter :: SHR_CONST_RHOICE  = pcd_rhoice      ! density of ice             ~ kg/m^3
   real(R8),parameter :: SHR_CONST_CPDAIR  = pcd_cpdair      ! specific heat of dry air   ~ J/kg/K
   real(R8),parameter :: SHR_CONST_CPWV    = pcd_cpwv        ! specific heat of water vap ~ J/kg/K
   real(R8),parameter :: SHR_CONST_CPVIR   = (SHR_CONST_CPWV/SHR_CONST_CPDAIR)-1.0_R8 ! CPWV/CPDAIR - 1.0
   real(R8),parameter :: SHR_CONST_CPFW    = pcd_cpfw        ! specific heat of fresh h2o ~ J/kg/K
   real(R8),parameter :: SHR_CONST_CPSW    = pcd_cpsw        ! specific heat of sea h2o   ~ J/kg/K
   real(R8),parameter :: SHR_CONST_CPICE   = pcd_cpice       ! specific heat of fresh ice ~ J/kg/K
   real(R8),parameter :: SHR_CONST_LATICE  = pcd_latice      ! latent heat of fusion      ~ J/kg
   real(R8),parameter :: SHR_CONST_LATVAP  = pcd_latvap      ! latent heat of evaporation ~ J/kg
   real(R8),parameter :: SHR_CONST_LATSUB  = pcd_latsub      ! latent heat of sublimation ~ J/kg
   real(R8),parameter :: SHR_CONST_CONDICE = pcd_condice     ! thermal conductivity of ice ~ W/m/K
   real(R8),parameter :: SHR_CONST_KAPPA_LAND_ICE = &        ! Diffusivity of heat in land ice ~
                         SHR_CONST_CONDICE / (SHR_CONST_RHOICE*SHR_CONST_CPICE)
   real(R8),parameter :: SHR_CONST_TF0    = 6.22e-2_R8       ! The freezing temperature at zero pressure in
   ! sub-ice-shelf ocean cavities ~ C
   real(R8),parameter :: SHR_CONST_DTF_DP = -7.43e-8_R8      ! The coefficient for the term proportional to the (limited)
   ! pressure in the freezing temperature in sub-ice-shelf ocean cavities. ~ C Pa^{-1}
   real(R8),parameter :: SHR_CONST_DTF_DS = -5.63e-2_R8      !The coefficient for the term proportional to salinity in
   ! the freezing temperature in sub-ice-ice ocean cavities ~ C PSU^{-1}
   real(R8),parameter :: SHR_CONST_DTF_DPDS = -1.74e-10_R8   ! The coefficient for the term proportional to salinity times
   ! pressure in the freezing temperature in sub-ice-shelf ocean cavities ~ C PSU^{-1} Pa^{-1}
   real(R8),parameter :: SHR_CONST_OCN_REF_SAL = pcd_ocn_ref_sal ! ocn ref salinity (psu)
   real(R8),parameter :: SHR_CONST_ICE_REF_SAL = pcd_ice_ref_sal ! ice ref salinity (psu)

   real(R8),parameter :: SHR_CONST_SPVAL        = 1.0e30_R8                 ! special missing value
   real(R8),parameter :: SHR_CONST_SPVAL_TOLMIN = 0.99_R8 * SHR_CONST_SPVAL ! min spval tolerance
   real(R8),parameter :: SHR_CONST_SPVAL_TOLMAX = 1.01_R8 * SHR_CONST_SPVAL ! max spval tolerance
   real(R8),parameter :: SHR_CONST_SPVAL_AERODEP= 1.e29_r8                  ! special aerosol deposition

   !Water Isotope Ratios in Vienna Standard Mean Ocean Water (VSMOW):
   real(R8),parameter :: SHR_CONST_VSMOW_18O   = pcd_vsmow_18o ! 18O/16O in VMSOW
   real(R8),parameter :: SHR_CONST_VSMOW_17O   = pcd_vsmow_17o ! 17O/16O in VMSOW
   real(R8),parameter :: SHR_CONST_VSMOW_16O   = pcd_vsmow_16o ! 16O/Tot in VMSOW
   real(R8),parameter :: SHR_CONST_VSMOW_D   = pcd_vsmow_d    ! 2H/1H in VMSOW
   real(R8),parameter :: SHR_CONST_VSMOW_T   = pcd_vsmow_t    ! 3H/1H in VMSOW
   real(R8),parameter :: SHR_CONST_VSMOW_H   = pcd_vsmow_h    ! 1H/Tot in VMSOW
   ! For best numerics in CAM5
   real(R8),parameter :: SHR_CONST_RSTD_H2ODEV   = 1.0_R8      ! Rstd Dev Use

contains

!-----------------------------------------------------------------------------

  elemental logical function shr_const_isspval(rval)
!$omp declare simd(shr_const_isspval)

     real(r8), intent(in) :: rval

     if (rval > SHR_CONST_SPVAL_TOLMIN .and. &
         rval < SHR_CONST_SPVAL_TOLMAX) then
        shr_const_isspval = .true.
     else
        shr_const_isspval = .false.
     endif

  end function shr_const_isspval

!-----------------------------------------------------------------------------

END MODULE shr_const_mod
