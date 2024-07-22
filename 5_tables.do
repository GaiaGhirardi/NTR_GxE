/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Models (Tables)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

********************************************************************************
* Trio
********************************************************************************

* ---------------------------------------------------------------------------- *
* Globals 
* ---------------------------------------------------------------------------- *

	#delimit ;
	global label_coefr 1.pedu_max_0 "SES (ref: Low-SES)"						 
	NCogPGS_sd "Non-Cognitive PGS" _cons "Constant" 
	1.pedu_max_0#c.CogPGS_sd "SES x PGS Cognitive"			
	1.pedu_max_0#c.NCogPGS_sd "SES x PGS Non-Cognitive"												
	CogPGS_sd "Cognitive PGS"	 
	;
	#delimit cr

	global TRIO_keep CogPGS_sd NCogPGS_sd 
		
	global TRIO_keep1 CogPGS_sd NCogPGS_sd 1.pedu_max_0

	#delimit ;
	global TRIO_keep2 CogPGS_sd NCogPGS_sd 1.pedu_max_0 MCogPGS_sd 
	FCogPGS_sd	FNCogPGS_sd MNCogPGS_sd
	;
	#delimit cr

	#delimit ;	
	global TRIO_COG_keep CogPGS_sd 1.pedu_max_0 1.pedu_max_0#c.CogPGS_sd		 
	CogPGS_sd  MCogPGS_sd   FCogPGS_sd	FNCogPGS_sd MNCogPGS_sd
	;
	#delimit cr
	
	#delimit ;	
	global TRIO_NCOG_keep NCogPGS_sd 1.pedu_max_0 1.pedu_max_0#c.NCogPGS_sd		 
	CogPGS_sd MCogPGS_sd   FCogPGS_sd	FNCogPGS_sd MNCogPGS_sd
	;
	#delimit cr
	
* ---------------------------------------------------------------------------- *
* M1: Main impact PGIs
* ---------------------------------------------------------------------------- *

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
		"edu4_after1980" {
		use "$working_dataset/TRIO_`var'_em", clear 
		eststo:  reg `var' c.CogPGS_sd c.NCogPGS_sd $controlsBE, vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/TRIO/M1_TRIO.rtf", replace label				 
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)								 
	keep($TRIO_keep)  varlabel($label_coefr) nogaps nonumbers				
	stats(N r2_a, label("Observations" "Adjusted R2")) 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/TRIO/M1_TRIO.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	reg `var' c.CogPGS_sd c.NCogPGS_sd $controlsBE, vce(cl FamilyNumber)
	outreg2 using "$output_tables/TRIO/M1_TRIO.xls",  label append nocons 
	}
	capture erase "$output_tables/TRIO/M1_TRIO.txt"
		  
* ---------------------------------------------------------------------------- *
* M2: Main impact PGIs and family SES
* ---------------------------------------------------------------------------- *

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	eststo:  reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0 $controlsBE, vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/TRIO/M2a_TRIO.rtf", replace label				
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)		
	stats(N r2_a, label("Observations" "Adjusted R2")) 
	keep($TRIO_keep1)  varlabel($label_coefr) nogaps nonumbers				 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/TRIO/M2a_TRIO.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0 $controlsBE, vce(cl FamilyNumber)
	outreg2 using "$output_tables/TRIO/M2a_TRIO.xls", label append nocons 
	}
	capture erase "$output_tables/TRIO/M2a_TRIO.txt"
	
* ---------------------------------------------------------------------------- *
* M2: as above but controlling for Parents PGI
* ---------------------------------------------------------------------------- *

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	eststo:  reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0 $controlsBE 	 ///
	MCogPGS_sd FCogPGS_sd FNCogPGS_sd MNCogPGS_s, vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/TRIO/M2b_TRIO.rtf", replace label				
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)		
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($TRIO_keep2)  varlabel($label_coefr) nogaps nonumbers				 	
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/TRIO/M2b_TRIO.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0 $controlsBE MCogPGS_sd   ///
	FCogPGS_sd FNCogPGS_sd MNCogPGS_s, vce(cl FamilyNumber)
	outreg2 using "$output_tables/TRIO/M2b_TRIO.xls", append label  nocons 
	}
	capture erase "$output_tables/TRIO/M2b_TRIO.txt"
	
* ---------------------------------------------------------------------------- *
* M3: Interaction PGIs x family SES
* ---------------------------------------------------------------------------- *

	* Cognitive 

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	if `var'== edu4_after1980 {
	eststo:  reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_COG, vce(cl FamilyNumber)
	}
	else {
	eststo:  reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber)
	}
	}
	#delimit ;
	esttab using "$output_tables/TRIO/M3_COG_TRIO.rtf", replace 				 
	nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)	label	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	varlabel($label_coefr) keep($TRIO_COG_keep)	nogaps nonumbers			 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/TRIO/M3_COG_TRIO.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	if `var'== edu4_after1980 {
	reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_COG, vce(cl FamilyNumber)
	}
	else {
	reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber)
	}	
	outreg2 using "$output_tables/TRIO/M3_COG_TRIO.xls", append label  nocons 
	}
	capture erase "$output_tables/TRIO/M3_COG_TRIO.txt"	

	* Non-Cognitive 

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	if `var'== edu4_after1980 {
	eststo:  reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_NCOG, vce(cl FamilyNumber)
	}
	else {
	eststo:  reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax, vce(cl FamilyNumber)
	}
	}
	#delimit ;
	esttab using "$output_tables/TRIO/M3_NCOG_TRIO.rtf", replace 				 
	nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)	label	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	varlabel($label_coefr) keep($TRIO_NCOG_keep)	nogaps nonumbers			 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/TRIO/M3_NCOG_TRIO.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/TRIO_`var'_em", clear 
	if `var'== edu4_after1980 {
	reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_NCOG, vce(cl FamilyNumber)
	}
	else {
	reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax, vce(cl FamilyNumber)
	}	
	outreg2 using "$output_tables/TRIO/M3_NCOG_TRIO.xls", append label  nocons 
	}
	capture erase "$output_tables/TRIO/M3_NCOG_TRIO.txt"	

********************************************************************************
* Within-family
********************************************************************************

* ---------------------------------------------------------------------------- *
* Globals 
* ---------------------------------------------------------------------------- *

	#delimit ;
	global label_coefr 1.pedu_max_0 "SES (ref: Low-SES)"					
	NCogPGS_sd "Non-Cognitive PGS" _cons "Constant" 	
	1.pedu_max_0#c.CogPGS_sd "SES x PGS Cognitive"			
	1.pedu_max_0#c.NCogPGS_sd "SES x PGS Non-Cognitive"					
	0.pedu_max_0#c.CogPGS_sd "SES (ref: Low)" 				
	0.pedu_max_0#c.NCogPGS_sd "SES (ref: Low)" 									
	CogPGS_sd "Cognitive PGS"	 
	;
	#delimit cr
					
	global WI_keep CogPGS_sd NCogPGS_sd 
	global WI_COG_keep CogPGS_sd 1.pedu_max_0#c.CogPGS_sd NCogPGS_sd 
	global WI_NCOG_keep NCogPGS_sd 1.pedu_max_0#c.NCogPGS_sd CogPGS_sd 
							
* ---------------------------------------------------------------------------- *
* M1: Main impact PGIs 
* ---------------------------------------------------------------------------- *

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber
	eststo: xtreg `var'  CogPGS_sd NCogPGS_sd $controlsWI if dup_`var'==1, fe vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/WI/M1_WI.rtf", replace label				 
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)	se(3)		
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($WI_keep)   varlabel($label_coefr) nogaps nonumbers			 
	addnote("PCs and Platform are included as controls" "Equation: reg outcomes CogPGS_sd NCogPGS_sd $controlsWI")
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/WI/M1_WI.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber
	xtreg `var'  CogPGS_sd NCogPGS_sd $controlsWI if dup_`var'==1, fe vce(cl FamilyNumber)
	outreg2 using "$output_tables/WI/M1_WI.xls", append label  nocons 	
	}	
	capture erase "$output_tables/WI/M1_WI.txt"	
	  
* ---------------------------------------------------------------------------- *
* M3: Interaction PGIs x family SES
* ---------------------------------------------------------------------------- *

	* Cognitive 

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber		
	eststo: xtreg `var'  CogPGS_sd NCogPGS_sd c.CogPGS_sd#i.pedu_max_0 $controlsWI_mod_Cog_edumax if dup_`var'==1, fe vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/WI/M3_COG_WI.rtf", replace					
	label nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001)	se(3)	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($WI_COG_keep)  varlabel($label_coefr) nogaps nonumbers 		 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/WI/M3_COG_WI.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber		
	xtreg `var'  CogPGS_sd NCogPGS_sd c.CogPGS_sd#i.pedu_max_0 $controlsWI_mod_Cog_edumax if dup_`var'==1, fe vce(cl FamilyNumber)
	outreg2 using "$output_tables/WI/M3_COG_WI.xls", append label  nocons 	
	local replace
	}	
	capture erase "$output_tables/WI/M3_COG_WI.txt"	
		
	* Non-Cognitive 

	* Word	
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber	
	eststo: xtreg `var'  NCogPGS_sd CogPGS_sd c.NCogPGS_sd#i.pedu_max_0 $controlsWI_mod_NCog_edumax if dup_`var'==1, fe vce(cl FamilyNumber)
	}
	#delimit ;
	esttab using "$output_tables/WI/M3_NCOG_WI.rtf", replace				
	label nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001)	se(3)	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($WI_NCOG_keep)  varlabel($label_coefr) nogaps nonumbers		
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/WI/M3_NCOG_WI_yob.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" "edu4_after1980" {
	use "$working_dataset/WI_`var'_em", clear 
	xtset FamilyNumber	
	xtreg `var'  NCogPGS_sd CogPGS_sd c.NCogPGS_sd#i.pedu_max_0 $controlsWI_mod_NCog_edumax if dup_`var'==1, fe vce(cl FamilyNumber)
	outreg2 using "$output_tables/WI/M3_NCOG_WI.xls", append label  nocons 
	}
	capture erase "$output_tables/WI/M3_NCOG_WI.txt"		

********************************************************************************
* Between-family 
********************************************************************************
	
* ---------------------------------------------------------------------------- *
* Globals 
* ---------------------------------------------------------------------------- *
	
	#delimit ;	
	global label_coefr 1.pedu_max_0 "SES (ref: Low-SES)" 					  
	NCogPGS_sd "Non-Cognitive PGS" _cons "Constant" 		
	1.pedu_max_0#c.CogPGS_sd "SES x PGS Cognitive"			 
	1.pedu_max_0#c.NCogPGS_sd "SES x PGS Non-Cognitive"		 					
	0.pedu_max_0#c.CogPGS_sd "SES (ref: Low)" 			
	0.pedu_max_0#c.NCogPGS_sd "SES (ref: Low)" 												 
	CogPGS_sd "Cognitive PGS" 
	;
	#delimit cr
	
	global BE_keep CogPGS_sd NCogPGS_sd

	global BE_keep1 CogPGS_sd NCogPGS_sd pedu_max_0 
	
	global BE_COG_keep CogPGS_sd 1.pedu_max_0 1.pedu_max_0#c.CogPGS_sd		 ///
	NCogPGS_sd 
	
	global BE_NCOG_keep NCogPGS_sd 1.pedu_max_0 1.pedu_max_0#c.NCogPGS_sd	 ///
	CogPGS_sd 
	
* ---------------------------------------------------------------------------- *
* M1: Main impact PGIs
* ---------------------------------------------------------------------------- *

	* Word 
	eststo clear	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	eststo:  reg `var' c.CogPGS_sd c.NCogPGS_sd  $controlsBE, vce(cl FamilyNumber) 
	}
	
	#delimit ;
	esttab using "$output_tables/BE/M1_BE.rtf",  replace label					
	varlabel($label_coefr) star(+ 0.10 * 0.05 ** 0.01 *** 0.001)	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($BE_keep)   nogaps nonumbers 										 	
	se(3) 
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/BE/M1_BE.xls"
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	reg `var' c.CogPGS_sd c.NCogPGS_sd  $controlsBE, vce(cl FamilyNumber) 
	outreg2 using "$output_tables/BE/M1_BE.xls", append label  nocons 	
	}	
	capture erase "$output_tables/BE/M1_BE.txt"	

* ---------------------------------------------------------------------------- *
* M2: Main impact PGIs and family SES
* ---------------------------------------------------------------------------- *

	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	eststo:  reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0   $controlsBE, vce(cl FamilyNumber) 
	}
	
	#delimit ;
	esttab using "$output_tables/BE/M2_BE.rtf", replace label					 
	keep($BE_keep 1.pedu_max_0)   nogaps nonumbers 			
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)	 varlabel($label_coefr)		
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/BE/M2_BE.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	reg `var' c.CogPGS_sd c.NCogPGS_sd i.pedu_max_0   $controlsBE, vce(cl FamilyNumber) 
	outreg2 using "$output_tables/BE/M2_BE.xls", append label  nocons
	}
	capture erase "$output_tables/BE/M2_BE.txt"		

* ---------------------------------------------------------------------------- *
* M3: Interaction PGIs x family SES
* ---------------------------------------------------------------------------- *

* Cognitive 
	
	* Word
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	eststo:  reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	
	#delimit ;
	esttab using "$output_tables/BE/M3_COG_BE.rtf",								 
	replace label varlabel($label_coefr)									 
	nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($BE_COG_keep)   nogaps nonumbers 		
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/BE/M3_COG_BE.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	reg `var' c.CogPGS_sd##i.pedu_max_0 NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	outreg2 using "$output_tables/BE/M3_COG_BE.xls", append label  nocons 	
	}
	capture erase "$output_tables/BE/M3_COG_BE.txt"

* Non-Cognitive 

	* Word	
	eststo clear
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	eststo:  reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax, vce(cl FamilyNumber)
	}
	
	#delimit ;
	esttab using "$output_tables/BE/M3_NCOG_BE.rtf",							 
	replace label varlabel($label_coefr)								     
	nocons star(+ 0.10 * 0.05 ** 0.01 *** 0.001) se(3)	
	stats(N r2_a, label("Observations" "Adjusted R2")) 	
	keep($BE_NCOG_keep)   nogaps nonumbers 	
	;
	#delimit cr

	* Excel 
	capture erase "$output_tables/BE/M3_NCOG_BE.xls"	
	foreach var in "rekenm7" "taalm7" "rekenm10" "taalm10" "CITO_sd" "track" ///
	"edu4_after1980" {
	use "$working_dataset/BE_`var'_em", clear 
	eststo:  reg `var' c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax, vce(cl FamilyNumber)
	outreg2 using "$output_tables/BE/M3_NCOG_BE.xls", append label  nocons 	
}
	capture erase "$output_tables/BE/M3_NCOG_BE.txt"








