*****************************************************************
*                       SAWAIN.DAT                              *
*                                                               *
* INPUT DATA FILE FOR SOIL WATER BALANCE MODEL SAWAH            *
*                                                               *
*****************************************************************

** Code to recognize correctness of data file: this file for
*  SAHEL water balance
SCODE = 'SAWAH'

*****************************************************************
* User defined OPTION switches; all integers; dimensionless
* NB !!!!  Switches SWIT1, SWIT2, SWIT4 are not user-defined;
*          there are assigned values at lower level CALLs 
*****************************************************************

*----------------------------------------------------------------
* SWIT3  : conductivity function option switch
* NB !     at SWIT9=2, not all combinations of SWIT3 and SWIT8
*          are allowed; see comments at SWIT9
* SWIT3=1: simple Rijtema
* SWIT3=2: extended Rijtema
* SWIT3=3: Van Genuchten
* SWIT3=4: Power function
*----------------------------------------------------------------
SWIT3=3   

*----------------------------------------------------------------
* SWIT5  : time step option switch 
* SWIT5=1: Variable time step
* SWIT5=2: Fixed time step; DTFX must be specified
*----------------------------------------------------------------
SWIT5 = 1  

*----------------------------------------------------------------
* SWIT6  : soil moisture initialization option switch 
* SWIT6=1: initial soil moisture in hydrostatic equilibrium 
*          with groundwater
* SWIT6=2: initial soil moisture entered as specified values;
*          WCLQTM must be specified
* SWIT6=3: initial soil moisture at wilting point
*----------------------------------------------------------------
SWIT6 = 2  

*----------------------------------------------------------------
* SWIT7  : lower boundary condition option switch: 
* SWIT7=1: pressure head at lower boundary derived from 
*          groundwater level (specified in ZWTB)
* SWIT7=2: free drainage
*----------------------------------------------------------------
SWIT7 = 1

*----------------------------------------------------------------
* SWIT8  : moisture characteristic option switch; active at 
*          both values of SWIT9
* NB !     at SWIT9=2, not all combinations of SWIT3 and SWIT8 
*          are allowed; see comments at SWIT9
* SWIT8=1: Driessen
* SWIT8=2: Van Genuchten
* SWIT8=3: linear interpolation on log scale 
*----------------------------------------------------------------
SWIT8=2    

*----------------------------------------------------------------
* SWIT9  : soil characterization option switch
* SWIT9=1: conductivity and moisture characteristic specified 
*          by user through parameter values in this file;
*          all combinations of SWIT3 and SWIT8 are allowed
* SWIT9=2: conductivity and moisture characteristic derived by 
*          SAWAH from soil type number only; soil type number 
*          to be specified in TYL. 
*          Only certain combinations of SWIT3 and SWIT8 are 
*          allowed at this value of SWIT9:
*             SWIT3=1 and SWIT8=1 (simple Rijtema conductivity 
*                  combined with Driessen moisture characteristic)
*             SWIT3=2 and SWIT8=1 (extended Rijtema conductivity
*                  combined with Driessen moisture characteristic)
*             SWIT3=3 and SWIT8=2 (Van Genuchten conductivity 
*                  combined with Van Genuchten moisture characterisic)
* NB1 !    for SWIT9=2, SWIT3=4/5 cannot be used 
* NB2 !    for SWIT9=2, SWIT8=3/4 cannot be used
*----------------------------------------------------------------
SWIT9=1    


******************* TIME DISCRETIZATION **********************
* fixed time step; DTFX is only active when SWIT5=2:
  DTFX = 0.1                                        ! units: d
* relative minimum; active in all options:
  DTMIN = 0.0005                                    ! units: d
* absolute maximum; active in all options:
  DTMX1 = 0.1                                       ! units: d
* Warning: too large DTFX (at SWIT5=2) and too large 
*          DTMIN (SWIT5=1) will lead to oscillations
*          in simulated water contents. Both can be 
*          0.01 d or larger for 'slow' soils (KST<10 
*          cm/d), but should be decreased to 0.001 d
*          or lower for highly permeable soil (KST>
*          100 cm/d). (Values are based on TKL=0.1 m 
*          for all compartments; for smaller TKL, 
*          smaller DTFX and DTMIN are needed.
*          Check temporal behaviour of output water 
*          contents. 
**************************************************************

***************** SPACE DISCRETIZATION ***********************
* number of compartments; maximum is 10; active in all options
NL=9    

* Thickness of soil compartments; the dimension of TKL in this
* data file should be equal to NL; active in all options:
TKL = 9*0.10 !  units: m
**************************************************************

***************** INITIALIZATION OF STATE ********************
* initial depth of surface water layer; active in all options
WL0QTI = 0.10  !  units: m

* initial depth of evaporation front; active in all options
ZEQTI = 0.0   !  units: m

* initial moisture content; active only at SWIT6=2; 
* NB ! values should not exceed WCST as specified in this file 
* (for SWIT9=1) or in data base (for SWIT9=2); the dimension 
* of WCLQTM should be equal to NL
WCLQTM = 3*0.52, 3*0.55, 2*0.61, 0.64 !  units: - 
**************************************************************

***********  this section can be ignored if SWIT9=2  *********
*************** SOIL HYDRAULIC CONDUCTIVITY  *****************
********* 'PARAMETER' section: active only for SWIT9=1 *******
* NB ! The dimension of all parameters in this section should 
*      be equal to NL; 

* active for all options SWIT3=1/2/3/4/5: 
* saturated hydraulic conductivity
KST = 2*127.0, 0.03, 3*35.0, 2*103.0, 42.0

* active for options SWIT3=1/2: simple and extended Rijtema 
KMSA1 = 9*0.03           ! units: 1/cm

* active only for option SWIT3=2: extended Rijtema
KMSA2 = 9*3.6            ! units: (cm**2.4)/d
KMSMX = 9*300.           ! units: cm

* active only for option SWIT3=3: parameter for Van Genuchten 
VGN = 3*1.119, 3*1.095, 2*1.076, 1.073    ! n parameter (-)

* active only for option SWIT3=4: parameter for power function 
PN  = 9*-2.              ! units: -

********** end of conductivity 'parameter' section ***********
**************************************************************


************* this section can be ignored if SWIT9=2  ********
**************** SOIL MOISTURE CHARACTERISTIC ****************
****** 'PARAMETER' section: active only for SWIT9=1 **********

* active for all options SWIT8=1/2/3/4: 
* water content at saturation; volume fraction
WCST = 3*0.52, 3*0.55, 2*0.61, 0.64        ! TEMPORAL USE
WCFC = 3*0.35, 3*0.36, 2*0.40, 0.43
WCWP = 3*0.19, 3*0.20, 2*0.23, 0.25
WCAD = 9*0.10

* SOIL TEXTURE AND BULK DENSITY, this section is need for actual root growth simulation
SANDX = 3*0.25, 3*0.20, 2*0.18, 0.15            ! soil sand content
CLAYX = 3*0.35, 3*0.40, 2*0.50, 0.55            ! soil clay content
BD    = 3*1.27, 3*1.19, 2*1.03, 0.95            ! soil bulk densiTY
PLOWPAN= 30.0    ! THE DEPTH OF PLOWPAN (CM), NEGATIVE VALUE INDICATES NO PLOWPAN

* Soil chemical properties needed soil C&N dynamics
SOC = 2*3831.,2044.,4529.,832.6,273.8,28.6,14.0,2.8      
SON = 2*191.6,113.6,283.,55.5,22.8,2.6,1.3,0.25      
SNH4X = 5.75,4.79,2.27,5.67,1.11,0.46,0.052,0.026,0.005  !* Soil NH4-N (kg N/ha)   
SNO3X = 2.9,2.4,1.3,2.8,0.55,0.23,0.026,0.013,0.0025     !* Soil NO3-N (kg N/ha)

*FORGANC =200.0,1000.0, 7*0.0   !* Fresh organic carbon (kg C/ha)
*FORGANN = 10.0,100.0,7*0.0     !* Fresh organic nitrogen (kg N/ha)
*FCarboh = 0.54                 !* Fraction of carbonhydrate in fresh organic matter (--)
*FCellulo = 0.38                !* Fraction of cellulose in fresh organic matter (--)


* active only for option SWIT8=1: parameter for Driessen 
MSWCA = 9*0.01 ! units -

* active only for option SWIT8=2: parameters for Van Genuchten
VGA = 3*0.127, 3*0.047, 2*0.078, 0.032 ! a parameter (cm-1)
VGL = 3*-6.2, 3*-0.6, 2*-4.9, -11.1    ! l parameter (-)
VGR = 9*0.01                           ! residual water content (-)

* active only for option SWIT8=3: parameters for 
* interpolation. To be specified: the pF values corresponding 
* to eleven given values of relative moisture content: 
* PFWC00 for relative moisture content 0.0
* PFWC01 for relative moisture content 0.1, .... etc
* PFWC10 for relative moisture content 1.0
* NB1 ! Each line contains NL positions, one for each 
*       compartment
* NB2 ! All values in the first line (PFWC00) should be 7.0
*       All values in the last line (PFWC10) should be 0.0
*       For any given position (=compartment), all values 
*       should decrease monotonically from PFWC00 down to 
*       PFWC10
PFWC00=9*7.
PFWC01=5*6.3,  2*6.4, 2*6.5
PFWC02=5*5.5,  2*5.8, 2*6.0
PFWC03=5*4.8,  2*5.3, 2*5.5
PFWC04=5*4.1,  2*4.8, 2*5.0
PFWC05=5*3.3,  2*4.0, 2*4.4
PFWC06=5*2.48, 2*3.90, 2*3.9
PFWC07=5*1.70, 2*3.33, 2*3.4
PFWC08=5*1.27, 2*2.76, 2*2.82
PFWC09=5*0.76, 2*1.48, 2*2.05
PFWC10=9*0.0
***** end of moisture characteristic 'parameter' section *****
**************************************************************


********** this section can be ignored if SWIT9=1  ***********
************ HYDRAULIC SOIL PROPERTIES BY SOIL TYPE **********
******** 'soil type' section: active only for SWIT9=2  *******
* If SWIT9=2, physical soil characteristics are assigned to 
* each compartment by only defining the soil type in each 
* compartment. SAWAH makes use of a small data base, 
* containing consistent sets of parameter values, tabulated in 
* DRSAWA. See above comments at SWIT3, SWIT8 and SWIT9 in this 
* file. For available types, see listing DRSAWA in manual .
* The dimension of TYL in this data file should be equal to NL
TYL = 1, 1, 2, 2, 6*2                              !  units: -
***************** end  of 'soil type' section ****************
**************************************************************


****************** OTHER SOIL PARAMETERS *********************
*****************  active in all options *********************
* effective soil vapor diffusivity:
CSC2 = 0.1 ! units: cm2/d

* soil evaporation parameters:
CSA = 0.005 ! units: cm2/d
CSB = 1.0  ! units:  -

* maximum layer of surface water WL0
WL0MX = 0.25  !  units: m

* index of compartment containing drain tubes/moles
* NB ! If no artificial drainage, set to zero !!!
IDRAIN = 0  !  units: -

* Maximum rooting depth                            
ZRTMS = 1.00 ! units: m
**************************************************************


******************** GROUNDWATER DEPTH ***********************
****************** active in all options *********************
* Groundwater will be ignored only at the simultaneous 
* occurrence of two conditions:
*  (1)  SWIT7=2
*  (2)  groundwater depth as specified here is deeper than
*       the lower profile boundary (=sum of TKL)
* If SWIT7=2, it is possible that groundwater is ignored only 
* part of the simulated time due to part-time fulfillment of 
* condition (2).
* The groundwater level is prescribed by means of a table
* containing datapoints in the form (DAY,LEVEL)
* The maximum number of datapairs is 365. If not all 
* daynumbers are entered, SAWAH will interpolate between data
* points - linear.

ZWTB =   1.,0.20,
       366.,0.20

*---------------------------------------------------------------*
* 10. Re-initialization
*---------------------------------------------------------------*
* Initial ponded water depth and water contents may be reset:
* Ponded water depth: to minimum of WL0I and WL0MX
* Water contents in all soil layers: to saturation value
* For direct seeded rice, this happens at emergence, for transplanted
* rice, this happens at transplanting (see TIMER.DAT file)
* Re-initialize switch RIWCLI is YES or NO
RIWCLI = 'NO'
*RIWCLI = 'YES'

*---------------------------------------------------------------*
* 11. Observations/Measurements
*     Switches to force observed water contents in water balance
*---------------------------------------------------------------*
* WCL1_OBS, WCL2_OBS,...WCL10_OBS: Observed soil water contents 
* in layer 1, 2, ..., 10. Format: year, day number, water content
* Not obligatory to give data

*WCL1_OBS =
* TO BE FILLED-IN (OPTIONAL)

** Parameter to set forcing of observed water content YES (2) or NO (0)
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
          9, 9, 9

* MSKPA1_OBS, MSKPA2_OBS,...MSKPA10_OBS: Observed soil water contents 
* in layer 1, 2, ..., 10. Format: year, day number, water content
* Not obligatory to give data

*MSKPA1_OBS = 
* TO BE FILLED-IN (OPTIONAL)

