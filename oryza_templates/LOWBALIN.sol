****************************************************************************************
* LOWBALIN.DAT: Soil parameters for the water balance LOWBAL                           *
*               for puddled, lowland rice soils.                                       *
****************************************************************************************
** Code to recognize correctness of data file: 
*  LOWBAL water balance
SCODE = 'LOWBAL'

WL0MXI = 100.00  ! Bundheight (mm)
TKLPI = 200.00   ! Thickness puddled layer (mm)

* Switch for percolation rate: 1 = fixed value; 2 = value changing in time
PSWITCH = 1

* If PSWITCH = 1: give fixed percolation rate FIXPERC
FIXPERC = 6.00   ! Fixed percolation rate (mm/d)

* If PSWITCH = 2; give percolation rate (mm/d) as function of calendar day
PTABLE =
1.,  6.0,        !First number is calendar day, second is percolation rate
26., 6.0,
100., 3.0,
366., 3.0

SSOILIN = 10.    ! Fixed seepage inflow rate (mm/d)
SSOILOUT = 5.    ! Fixed seepage outflow rate (mm/d)
DDR = 2000.00    ! Deep drainage rate of the subsoil (mm/d)

WL0I = 10.00     ! Initial depth of ponded water layer (mm)
SHRINK = 1.      ! Linear shrinkage factor (-)

WCCRAC = 0.01    ! Water content puddled layer at which cracks
                 ! penetrate the compacted (plough) layer (cm3/cm3)

* All water contents below are measured after drying out of puddled layer
* Data from Wopereis (1992 experiments at IRRI)
WCSTP = 0.52     ! Water content at saturation, puddled layer (cm3/cm3)
WCFCP = 0.48     ! Water content at field capacity, puddled layer (cm3/cm3)
WCWPP = 0.21     ! Water content at wilting point, puddled layer (cm3/cm3)
WCADP = 0.01     ! Water content at air-dryness, puddled layer (cm3/cm3)


*------------------------------------------------------------------------------------*
* Soil physics and chemical properties for root growth and dynamics
* Physics are the average of profile, chemical are the accumulation of profile
SANDX = 0.23            ! Fraction
CLAYX = 0.45            ! Fraction
BD = 1.21               ! g/cm3
SOC = 15386.8           ! kg C/ha		
SON = 862.25            ! kg N/ha
SNH4X = 20.133          !* kg N/ha
SNO3X = 10.22           !* kg/ha

* Fresh organic carbon and nitrogen input at soil layers
* FORGANC =350.0        !*Fresh organic residue carbon input from previous crop at kg C/ha
* FORGANN =4.0          !*Fresh organic residue nitrogen input from previous crop at kg N/ha

* Use if the carbonhydrate and cellulose fractions are available in soil residue carbon. 
* Otherwise, the default values will be used
*FCarboh = 0.45		!* Fraction of carbonhydrate in fresh organic fertilizer
*FCellulo = 0.38        !* Fraction of cellulose in fresh organic fertilizer


*-------------------------------------------------------------------------------------*
*  Observations/measurements
*  Switches to force observed water content in water balance
*-------------------------------------------------------------------------------------*
* WCL1_OBS, WCL2_OBS,...WCL10_OBS: Observed soil water contents 
* in layer 1, 2, ..., 10. Format: year, day number, water content
* Not obligatory to give data

WCL1_OBS =
1992.,  1.,  0.40,
1992.,  15., 0.40,
1992.,  75., 0.30,
1992., 366., 0.30

** Parameter to set forcing of observed water content YES (2) or NO (0)
** during simulation (instead of using simulated values)
WCL1_FRC = 0 ! No forcing
*WCL1_FRC = 2 ! Forcing 

* MSKPA1_OBS, MSKPA2_OBS,...MSKPA10_OBS: Observed soil water contents in layer 1, 2, ..., 10. 
* Format: year, day number, water content
* Not obligatory to give data

*MSKPA1_OBS = 
* TO BE FILLED-IN (OPTIONAL)
