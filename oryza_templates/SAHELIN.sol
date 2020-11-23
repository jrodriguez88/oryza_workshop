*================================================================*
* SAHELIN.DAT. Soil data input file for DRSAHE (SAHEL water      *
* balance model) as implemented in ORYZA2000 version 3           *
*================================================================*

** Code to recognize correctness of data file: this file for
*  SAHEL water balance
SCODE = 'SAHEL'

*----------------------------------------------------------------
* 1. General meaning of the switches
*----------------------------------------------------------------
* ===============================================================

* SWIT9 = 1 ! Moisture characteristics defined by user parameters
*       = 2 ! as defined by soil type number

* SWIT8 = 1 ! Driessen moisture characteristic,
*       = 2 ! Van Genuchten moisture characteristic,
*       = 3 ! Linear interpolation on user-defined log scale
*       = 4 ! Use pF curve parameters

* SWIT6 = 1 ! Initial water content at field capacity
*       = 2 ! Initial water content at wilting point
*       = 3 ! Initial water content at observed values

* Compatibility of SWIT9 and SWIT8 switches
* ===============================================================

* SWIT9 | SWIT8 | Comment:
*   1   |   1   | requires WCST and MSWCA for each layer
*   1   |   2   | requires WCST, VGA, VGR and VGN for each layer
*   1   |   3   | requires WCST and PFWC00-PFWC10 for each layer
*   1   |   4   | requires WCST, WCFC, WCWP and WCAD for each layer
*   2   |   1   | requires TYL array for each layer
*   2   |   2   | requires TYL array for each layer
*   2   |   3   | incompatible
*   2   |   4   | incompatible

* Meaning of TYL soil type numbers
* ================================

* (Driessen moisture characteristic)
*      1. Coarse sand                11. Fine sandy loam
*      2. Medium coarse sand (mcs)   12. Silt loam
*      3. Medium fine sand           13. Loam
*      4. Fine sand                  14. Sandy clay loam
*      5. Humous loamy mcs           15. Silty clay loam
*      6. Light loamy mcs            16. Clay loam
*      7. Loamy mcs                  17. Light clay
*      8. loamy fine sand            18. Silty clay
*      9. Sandy loam                 19. Heavy clay
*     10. Loess loam                 20. Peat

* (Van Genuchten moisture characteristic)
*      1. Lovinkhoeve 12b
*      2. Lovinkhoeve 16a

* Switch settings (see above)
SWIT9 = 1 ; SWIT8 = 4

*-------------------------------------------------------------------
* 2. BASIC INFORMATION
*-------------------------------------------------------------------
* Number of soil layers (should not exceed 10.)
NL    = 10

* Array of thicknesses of the soil layers, m
TKL   = 10 * 0.10

* Number of soil type of which the characteristics are assigned
* to the soil layers, -
TYL = 10 * 19.

* Water retention parameters
WCST = 10*0.52
WCFC = 10*0.48
WCWP = 10*0.21
WCAD = 10*0.01

* Initialization of soil water content
* Switch setting
SWIT6 = 1

* User-defined initial water content, cm3/cm3
WCLQTM = 9 * 0.48

* Evaporation extinction coefficient, m-1
EES = 20.

* Maximum rooting depth soil (m)
ZRTMS = 10.

* Fraction runoff from rain (-)
FRNOF = 0.0

* Minimum amount of rain that will not runoff but will infiltrate (mm)
RAINMIN =  10.

*-------------------------------------------------------------------------------
* 3. ADDITIONAL INFORMATION FOR ROOTING AND C&N DYNAMICS
*-------------------------------------------------------------------------------
* SOIL TEXTURE AND BULK DENSITY, this section is need for actual root growth simulation
SANDX = 3*0.25, 3*0.20, 2*0.18, 0.15            !soil sand content
CLAYX = 3*0.35, 3*0.40, 2*0.50, 0.55            !soil clay content
BD    = 3*1.27, 3*1.19, 2*1.03, 0.95            !soil bulk densiTY

* Soil chemical properties needed soil C&N dynamicS, kg C or N/ha
SOC = 2*3831.,2044.,4529.,832.6,273.8,28.6,14.0,2.8      
SON = 2*191.6,113.6,283.,55.5,22.8,2.6,1.3,0.25      
SNH4X = 5.75,4.79,2.27,5.67,1.11,0.46,0.052,0.026,0.005 !*Soil ammonium content (kg N/ha)    
SNO3X = 2.9,2.4,1.3,2.8,0.55,0.23,0.026,0.013,0.0025    !*Soil nitrate content (kg N/ha)

*FORGANC =200.0,1000.0, 7*0.0   !* Fresh organic carbon (kg C/ha)
*FORGANN = 10.0,100.0,7*0.0     !* Fresh organic nitrogen (kg N/ha)
*FCarboh = 0.54                 !* Fraction of carbonhydrate in fresh organic matter (--)
*FCellulo = 0.38                !* Fraction of cellulose in fresh organic matter (--)

*------------------------------------------------------------------------------*
* Observations/measurements
* Switches to force observed water contents in water balance
*------------------------------------------------------------------------------*
*!* WCL1_OBS, WCL2_OBS,...WCL10_OBS: Observed soil water contents 
* in layer 1, 2, ..., 10. Format: year, day number, water content
* Not obligatory to give data

*WCL1_OBS =
* TO BE FILLED-IN (OPTIONAL)

** Parameter to set forcing of observed water content yes (2) or no (0)
** during simulation (instead of using simulated values)
*WCL1_FRC = 0 ! No forcing
*WCL1_FRC = 2 ! Forcing 

* Table for interpolation of water content between soil layers for
* those layers for which no observations were made: first number is
* the soil layer for which interpolation needs to be done, the second
* is the number of the underlying soil layer, the third is the number 
* of the overlying soil layer. No interpolation is performed when all 
* three numbers are the same: 
WCLINT  = 1, 1, 1,
          2, 2, 2,
          3, 3, 3,
          4, 4, 4,
          5, 5, 5,
          6, 6, 6,
          7, 7, 7,
          8, 8, 8,
          9, 9, 9,
         10, 10, 10

*!* MSKPA1_OBS, MSKPA2_OBS,...MSKPA10_OBS: Observed soil water contents 
* in layer 1, 2, ..., 10. Format: year, day number, water content
* Not obligatory to give data

*MSKPA1_OBS = 
* TO BE FILLED-IN (OPTIONAL)
