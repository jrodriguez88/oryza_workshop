**********************************************************************
* Template soil data file for SOILPF soil water balance model.       *
* File name   : SOILPFIN.DAT                                         *
*                                                                    *
**********************************************************************

* Give code name of soil data file to match the water balance PFSOIL:
SCODE = 'SOILPF'

*--------------------------------------------------------------------*
* 1. Soil moisture tension
* Tension data in kPa as function of development stage (DVS) or
* tension data in kPa as function of day of year (DOY)
*--------------------------------------------------------------------*
*STYPE = 'SDVS' ! Tension data in kPa as function of development stage (DVS)
STYPE = 'SDAY' ! Tension data in kPa as function of day (DOY)  

* If STYPE = 'SDVS', give tension data as PFDVS table: 
* first column is DVS (-), second column is tension (kPa)
PFDVS =
0., 10.,
0.8, 10.,
0.81, 0.,
1.20, 0.,
1.21, 10.,
2.5, 10.

* If STYPE = 'SDAY', give tension data as PFDAY table: 
* first column is day (-), second column is tension (kPa)
PFDAY =
0., 100.,
50., 100.,
51., 100.,
365., 100.


*---------------------------------------------------------------*
* 2. Soil water retention curve
* These data will be used to calculate soil water content from 
* the soil water tension data supplied above
*---------------------------------------------------------------*
* Soil water retention data as table PFCURVE
* first column is water content (m3 m-3), second column is tension (kPa)
* Note: first row should give values at saturation (0 kPa)
* Note: last row should give values at complete dryness (1500 kPa)
PFCURVE = 
0.,    0.52,
10.,   0.48,
100.,  0.21,
1500., 0.0001

*---------------------------------------------------------------
*3. Soil Physical Properties
*---------------------------------------------------------------
NL    = 9    ! Number of soil layers (maximum is 10) (-)
TKL   = 3*0.05, 3*0.05, 0.10, 0.20, 0.20     ! Thickness of each soil layer (m)
CLAYX = 0.55,0.55,0.55,0.55,0.53,0.5,3*0.45  ! soil clay contents, fraction
SANDX = 0.08,0.08,0.08,0.08,0.1,0.13,3*0.18  ! soil sand contents, fraction
BD = 1.17894,1.17894,1.17911,1.42734,1.2695,1.31061,3*1.37562      !g/cm3

WL0I = 0.   ! Initial ponded water depth at start of simulation (mm)

* Initial volumetric water content at the start of simulation,
* for each soil layer (m3 m-3):
WCLI = 3*0.52, 3*0.47, 2*0.52, 0.58

*---------------------------------------------------------------
*4. Soil chemical Properties
*---------------------------------------------------------------
* Soil organic carbon and nitrogen content in kg C or N/ha
SOC = 31831.64999,31831.64999,20044.87,48529.56,8632.66799,2673.6648,280.62648,28.063,2.8063      
SON = 2829.48,2829.48,1886.576,4567.488,812.4864,251.639039,26.411903,2.64, 0.264      
SNH4X = 28.295,28.295,18.87,45.67,8.12,2.50,0.26,0.026,0.00264 !*Soil NH4-N (kg N/ha)     
SNO3X = 5.66,5.66,3.774,9.134,1.624,0.5,0.052,0.0052,0.00052   !* Soil NO3-N (kg N/ha)

*FORGANC =200.0,1000.0, 7*0.0   !* Fresh organic carbon (kg C/ha)
*FORGANN = 10.0,100.0,7*0.0     !* Fresh organic nitrogen (kg N/ha)
*FCarboh = 0.54                 !* Fraction of carbonhydrate in fresh organic matter (--)
*FCellulo = 0.38                !* Fraction of cellulos in fresh organic matter (--)

