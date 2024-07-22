/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Power analysis  R2 test
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

********************************************************************************
* Between-family 
********************************************************************************

	use "$working_dataset/BE_rekenm7_em", clear 
	count // 3728
	use "$working_dataset/BE_taalm7_em", clear 
	count // 3756
	use "$working_dataset/BE_rekenm10_em", clear
	count // 3829
	use "$working_dataset/BE_taalm10_em", clear
	count // 3875
	use "$working_dataset/BE_CITO_sd_em", clear
	count // 2690
	use "$working_dataset/BE_track_em", clear
	count // 3318
	use "$working_dataset/BE_edu4_after1980_em", clear
	count // 1224
	
	power rsquared 0.05, ntested(1) ncontrol(11) n(3728 3756 3829 3875 2690 3318 1224) power(0.8)
	power rsquared 0.05, ntested(1) ncontrol(11) n(3728 3756 3829 3875 2690 3318 1224) power(0.8) graph

********************************************************************************
* Within-family 
********************************************************************************
	
	use "$working_dataset/WI_rekenm7_em", clear 
	count if dup_rekenm7==1 //  2124
	use "$working_dataset/WI_taalm7_em", clear 
	count if dup_taalm7==1 //  2130
	use "$working_dataset/WI_rekenm10_em", clear
	count if dup_rekenm10==1 // 2212
	use "$working_dataset/WI_taalm10_em", clear
	count if dup_taalm10==1 // 2236
	use "$working_dataset/WI_CITO_sd_em", clear
	count if dup_CITO_sd==1 // 1500
	use "$working_dataset/WI_track_em", clear
	count if dup_track==1 //  2004
	use "$working_dataset/WI_edu4_after1980_em", clear
	count if dup_edu4_after1980==1 // 426
	
	power rsquared 0.05, ntested(1) ncontrol(11) n(2124 2130 2212 2236 1500 2004 426) power(0.8)	
	power rsquared 0.05, ntested(1) ncontrol(11) n(2124 2130 2212 2236 1500 2004 426) power(0.8) graph	

********************************************************************************
* Trio
********************************************************************************
	
	use "$working_dataset/TRIO_rekenm7_em", clear 
	count // 1861
	use "$working_dataset/TRIO_taalm7_em", clear 
	count // 1869
	use "$working_dataset/TRIO_rekenm10_em", clear
	count // 2022
	use "$working_dataset/TRIO_taalm10_em", clear
	count // 2051
	use "$working_dataset/TRIO_CITO_sd_em", clear
	count // 1254
	use "$working_dataset/TRIO_track_em", clear
	count // 1500
	use "$working_dataset/TRIO_edu4_after1980_em", clear
	count // 576

	power rsquared 0.05, ntested(1) ncontrol(11) n(1861 1869 2022 2051 1254 1500 576) power(0.8) alpha(0.05) 
	power rsquared 0.05, ntested(1) ncontrol(11) n(1861 1869 2022 2051 1254 1500 576) power(0.8) alpha(0.05) graph
	power rsquared 0.05, ntested(1) ncontrol(11) n(1488) power(0.8)

	
	
	
	
	
	


