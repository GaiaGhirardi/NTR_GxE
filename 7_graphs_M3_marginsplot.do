/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Models (Graphs M3: Marginsplot only for TRIO desing)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f

********************************************************************************
* Maths (age 7)
********************************************************************************

* ---------------------------------------------------------------------------- *
* PGI cognitive
* ---------------------------------------------------------------------------- *
 
	use "$working_dataset/TRIO_rekenm7_em", clear 
	reg rekenm7 c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 				
	ci1opt(color(navy%70))												
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))									
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI ", size(small))  											
	ytitle("", size(vsmall))											
	title("PGI cognitive skills", size(small)) 								
	legend(order(2 "High-SES" 1 "Low-SES") size(small) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 
	name(math7_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *	

	use "$working_dataset/TRIO_rekenm7_em", clear 
	reg rekenm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;		
	marginsplot, recast(line)  ciopts(recast(rarea)) 					
	ci1opt(color(navy%70))											
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										 
	plot2opts(lc(teal) lpattern("--"))										 
	xtitle("PGI ", size(small))  											 
	ytitle("", size(vsmall))												 	
	title("PGI noncognitive skills", size(small)) 							 
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		 
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 
	name(math7_margins_ncog, replace)
	;
	#delimit cr

********************************************************************************
* Reading (age 7)
********************************************************************************
	
* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_taalm7_em", clear 
	reg taalm7 c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1))
	#delimit ;		
	marginsplot, recast(line)  ciopts(recast(rarea)) 							
	ci1opt(color(navy%70))													 
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))									
	plot2opts(lc(teal) lpattern("--"))									
	xtitle("PGI ", size(small))  											
	ytitle("", size(vsmall))													
	title("PGI cognitive skills", size(small)) 								 
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	
	name(re7_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_taalm7_em", clear 
	reg taalm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1))
 	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))													 
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))								
	plot2opts(lc(teal) lpattern("--"))							
	xtitle("PGI ", size(small))  										
	ytitle("", size(vsmall))												
	title("PGI noncognitive skills", size(small)) 						
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 	
	name(re7_margins_ncog, replace)
	;
	#delimit cr
	
********************************************************************************
* Maths (age 10)
********************************************************************************

* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_rekenm10_em", clear 
	reg rekenm10 c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))									
	xtitle("PGI ", size(small))  											
	ytitle("", size(vsmall))												
	title("PGI cognitive skills", size(small)) 								
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 
	name(math10_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *
 
	use "$working_dataset/TRIO_rekenm10_em", clear 
	reg rekenm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea))
	ci1opt(color(navy%70))											
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))								
	plot2opts(lc(teal) lpattern("--"))								
	xtitle("PGI", size(small))  									
	ytitle("", size(vsmall))											
	title("PGI noncognitive skills", size(small)) 							 
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))		
	name(math10_margins_ncog, replace)
	;
	#delimit cr
	
********************************************************************************	
* Reading (age 10)
********************************************************************************

* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_taalm10_em", clear 
	reg taalm10 c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))												
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI ", size(small))  										
	ytitle("", size(vsmall))												
	title("PGI cognitive skills", size(small)) 								
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 
	name(re10_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_taalm10_em", clear 
	reg taalm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 							
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI", size(small))  										
	ytitle("", size(vsmall))												 
	title("PGI noncognitive skills", size(small)) 							
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 	
	name(re10_margins_ncog, replace)
	;
	#delimit cr
	
********************************************************************************	
* CITO
********************************************************************************

* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_CITO_sd_em", clear 
	reg CITO_sd c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd  $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) //$controlsTRIO_mod_Cog_edumax
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	 
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))									
	plot2opts(lc(teal) lpattern("--"))									
	xtitle("PGI", size(small))  											
	ytitle("", size(vsmall))											
	title("PGI cognitive skills", size(small)) 								
	legend(order(2 "High-SES" 1 "Low-SES") size(small) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))		
	name(citom3_margins_cog, replace) 	
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_CITO_sd_em", clear 
	reg CITO_sd c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd  $controlsTRIO_mod_NCog_edumax, vce(cl FamilyNumber) //$controlsTRIO_mod_Cog_edumax
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	 
	marginsplot, recast(line)  ciopts(recast(rarea)) 							
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))										
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI", size(small))  											
	ytitle("", size(vsmall))												
	title("PGI noncognitive skills", size(small)) 							
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	
	name(citom3_margins_ncog, replace) 	
	;
	#delimit cr
	
********************************************************************************	
* Tracking 
********************************************************************************

* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_track_em", clear 
	reg track c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 							
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI", size(small))  											 
	ytitle("", size(vsmall))												
	title("PGI cognitive skills", size(small)) 								
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	 
	name(trackm3_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_track_em", clear 
	reg track c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1))
	#delimit ;	 
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										
	plot2opts(lc(teal) lpattern("--"))									
	xtitle("PGI", size(small))  										
	ytitle("", size(vsmall))												
	title("PGI noncognitive skills", size(small)) 							
	legend(order(2 "High-SES" 1 "Low-SES") size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	
	name(trackm3_margins_ncog, replace)
	;
	#delimit cr
	
********************************************************************************	
* Educational attainment 
********************************************************************************

	* Globals 
	#delimit ;
	global controlsTRIO_COG
	PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 
	MCogPGS_sd FCogPGS_sd FNCogPGS_sd MNCogPGS_sd		
	c.CogPGS_sd#c.PC1 c.CogPGS_sd#c.PC2 c.CogPGS_sd#c.PC3					
	c.CogPGS_sd#c.PC4 c.CogPGS_sd#c.PC5 c.CogPGS_sd#c.PC6					
	c.CogPGS_sd#c.PC7 c.CogPGS_sd#c.PC8 c.CogPGS_sd#c.PC9				
	c.CogPGS_sd#c.PC10 c.CogPGS_sd#i.Platform 
	c.CogPGS_sd#c.NCogPGS_sd 
	c.CogPGS_sd#c.MCogPGS_sd c.CogPGS_sd#c.FCogPGS_sd						
	c.CogPGS_sd#c.MNCogPGS_sd c.CogPGS_sd#c.FNCogPGS_sd	
	i.pedu_max_0#c.NCogPGS_sd 	
	i.pedu_max_0#c.MCogPGS_sd i.pedu_max_0#c.FCogPGS_sd						
	i.pedu_max_0#c.MNCogPGS_sd i.pedu_max_0#c.FNCogPGS_sd		
	i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2	
	i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5
	i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8				 
	i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#1.Platform
	;
	#delimit cr

	#delimit ;
	global controlsTRIO_NCOG
	PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 
	MCogPGS_sd FCogPGS_sd FNCogPGS_sd MNCogPGS_sd		
	c.NCogPGS_sd#c.PC1 c.NCogPGS_sd#c.PC2 c.NCogPGS_sd#c.PC3					
	c.NCogPGS_sd#c.PC4 c.NCogPGS_sd#c.PC5 c.NCogPGS_sd#c.PC6					
	c.NCogPGS_sd#c.PC7 c.NCogPGS_sd#c.PC8 c.NCogPGS_sd#c.PC9				
	c.NCogPGS_sd#c.PC10 c.NCogPGS_sd#i.Platform 
	c.NCogPGS_sd#c.CogPGS_sd 
	c.NCogPGS_sd#c.MCogPGS_sd c.NCogPGS_sd#c.FCogPGS_sd						
	c.NCogPGS_sd#c.MNCogPGS_sd c.NCogPGS_sd#c.FNCogPGS_sd	
	i.pedu_max_0#c.NCogPGS_sd 	
	i.pedu_max_0#c.MCogPGS_sd i.pedu_max_0#c.FCogPGS_sd						
	i.pedu_max_0#c.MNCogPGS_sd i.pedu_max_0#c.FNCogPGS_sd		
	i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2	
	i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5
	i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8				 
	i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#1.Platform
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI cognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_edu4_after1980_em", clear 
	reg edu4_after1980 c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_COG , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.CogPGS_sd ]/_se[1.pedu_max_0#c.CogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(CogPGS_sd=(-2(1)2) pedu_max_0=(0, 1)) 
	#delimit ;	
	marginsplot, recast(line)  ciopts(recast(rarea)) 							
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											 
	plot1opts(lc(navy) lpattern(solid))										 
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI", size(small))  											 
	ytitle("", size(vsmall))												
	title("PGI cognitive skills ", size(small)) 							
	legend(order(2 "High-SES" 1 "Low-SES" ) size(medium) col(2) pos(6))		 
	note("CogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	
	name(edu_margins_cog, replace)
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *	
* PGI Noncognitive 
* ---------------------------------------------------------------------------- *

	use "$working_dataset/TRIO_edu4_after1980_em", clear 
	reg edu4_after1980 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_NCOG , vce(cl FamilyNumber)
	local t = _b[1.pedu_max_0#c.NCogPGS_sd ]/_se[1.pedu_max_0#c.NCogPGS_sd ]
	disp 2*ttail(e(df_r),abs(`t'))
	local x2_`var': disp %4.3f 2*ttail(e(df_r),abs(`t'))
	disp `x2_`var''
	matrix beta_`var' = e(b)
	disp beta_`var'[1,5]
	local ciao_`var' : di %4.3f beta_`var'[1,5] 
	margins, at(NCogPGS_sd=(-2(1)2) pedu_max_0=(0, 1))
	#delimit ;	 
	marginsplot, recast(line)  ciopts(recast(rarea)) 						
	ci1opt(color(navy%70))													
	ci2opt(color(olive_teal%70))											
	plot1opts(lc(navy) lpattern(solid))										 
	plot2opts(lc(teal) lpattern("--"))										
	xtitle("PGI ", size(small))  											
	ytitle("", size(vsmall))												 	
	title("PGI noncognitive skills ", size(small)) 							
	legend(order(2 "High-SES" 1 "Low-SES" ) size(medium) col(2) pos(6))		
	note("NonCogPGIxSES Coeff.: {bf:`ciao_`var''}" "p-value: {bf:`x2_`var''} ", size(vsmall))	
	name(edu_margins_ncog, replace)
	;
	#delimit cr
	
grc1leg math7_margins_cog math7_margins_ncog , col (4) ycom title("Mathematics" "(age 7)", size(vsmall)) name(gr1, replace )
grc1leg re7_margins_cog re7_margins_ncog , col (4) ycom title("Reading" "(age 7)", size(vsmall)) name(gr2, replace )
grc1leg math10_margins_cog math10_margins_ncog , col (4) ycom title("Mathematics" "(age 10)", size(vsmall)) name(gr3, replace )
grc1leg re10_margins_cog re10_margins_ncog , col (4) ycom title("Reading" "(age 10)", size(vsmall)) name(gr4, replace )
grc1leg citom3_margins_cog citom3_margins_ncog , col (4) ycom title("Test scores (CITO)" "(age 12)", size(vsmall)) name(gr5, replace )
grc1leg trackm3_margins_cog trackm3_margins_ncog , col (4) ycom title("Upper secondary tracks (VWO+HAVO)" "(age 12-18)", size(vsmall)) name(gr6, replace )
grc1leg edu_margins_cog edu_margins_ncog , col (4) ycom title("Higher educational attainment" "(age ≥ 25) ", size(vsmall)) name(gr7, replace )

grc1leg gr1 gr2 gr3 gr4 gr5 gr6 gr7, col (3) name(gr10, replace) 
gr_edit .legend.DragBy 21 0
//graph export "$output_figures/BE_WI_TRIO/TRIO_M3_margins_ALL.emf", replace // NO FOR MAC
graph export "$output_figures/BE_WI_TRIO/TRIO_M3_margins_ALL.svg", replace 
graph export "$output_figures/BE_WI_TRIO/TRIO_M3_margins_ALL.pdf", replace 
graph export "$output_figures/BE_WI_TRIO/TRIO_M3_margins_ALL.tif", width(4000) replace
	
	
	