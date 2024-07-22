/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Sample & Standardization
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f

********************************************************************************
* Between-family design
********************************************************************************

u "$working_dataset/dataset_sampleBE_NOPGSparents_em.dta", clear

* ---------------------------------------------------------------------------- *
* Analytical samples 
* ---------------------------------------------------------------------------- *

	* To create an analytical sample/dataset for each outcomes
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/dataset_sampleBE_NOPGSparents_em.dta", clear
	mark sample_`var' if !missing(CogPGS, NCogPGS, mother_age, sex, yob, PC1, PC2, ///
		PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child, `var')
	keep if sample_`var' == 1 
	drop sample_`var'
	save "$working_dataset/BE_`var'_em.dta", replace 
	}
  
* ---------------------------------------------------------------------------- *
* Standardization (CITO, CogPGS, NCogPGS)
* ---------------------------------------------------------------------------- *

	* To standardize CITO CogPGS NCogPGS in every dataset  
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/BE_`var'_em.dta", clear 
	foreach x of varlist CITO CogPGS NCogPGS {
	egen `x'_sd = std(`x')
	save "$working_dataset/BE_`var'_em.dta", replace 
	}
	}

	* Loop just for labels
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4  ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/BE_`var'_em.dta", clear 
	lab var CITO_sd "Test scores CITO (age 12)"
	lab var CogPGS_sd "Cognitive PGS"
	lab var NCogPGS_sd "NonCognitive PGS"
	save "$working_dataset/BE_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* PGI non-linearities
* ---------------------------------------------------------------------------- *

	* To create variables in each dataset/sample for non-linearities 
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/BE_`var'_em.dta", clear 
	foreach y of varlist CogPGS_sd NCogPGS_sd {
	xtile q3`y' = `y', nq(3)
	xtile q5`y' = `y', nq(5)
	xtile q10`y' = `y', nq(10)
	save "$working_dataset/BE_`var'_em.dta", replace 
	}
	}

	* Loop just for labels
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/BE_`var'_em.dta", clear 
	lab var q3CogPGS_sd "Q3 Cognitive PGI"
	lab var q5CogPGS_sd "Q5 Cognitive PGI"
	lab var q10CogPGS_sd "Q10 Cognitive PGI"
	lab var q3NCogPGS_sd "Q3 Noncognitive PGI"
	lab var q5NCogPGS_sd "Q5 Noncognitive PGI"
	lab var q10NCogPGS_sd "Q10 NonCognitive PGI"
	save "$working_dataset/BE_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* Rename only CITO dataset for models dofile/loop
* ---------------------------------------------------------------------------- *

	u "$working_dataset/BE_CITO_em.dta", clear 
	save "$working_dataset/BE_CITO_sd_em.dta", replace 

********************************************************************************
* Within-family design
********************************************************************************

	u "$working_dataset/dataset_sampleWT_randomsibling_em.dta", clear

* ---------------------------------------------------------------------------- *
* Analytical Sample 
* ---------------------------------------------------------------------------- *

	* To create an analytical sample/dataset for each outcomes
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4   ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/dataset_sampleWT_randomsibling_em.dta", clear
	mark sample_`var' if !missing(CogPGS, NCogPGS, sex, yob, PC1, PC2, PC3,	 ///
		PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child, `var') 
	keep if sample_`var' == 1 
	drop sample_`var'
	save "$working_dataset/WI_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* Standardization (CITO, CogPGS, NCogPGS)
* ---------------------------------------------------------------------------- *

	* To standardize CITO CogPGS NCogPGS in every dataset  
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/WI_`var'_em.dta", clear 
	foreach x of varlist CITO CogPGS NCogPGS {
	egen `x'_sd = std(`x')
	save "$working_dataset/WI_`var'_em.dta", replace 
	}
	}

	* Loop just for labels 
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/WI_`var'_em.dta", clear 
	lab var CITO_sd "Test scores CITO (age 12)"
	lab var CogPGS_sd "Cognitive PGI"
	lab var NCogPGS_sd "NonCognitive PGI"
	save "$working_dataset/WI_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* PGS non-linearities
* ---------------------------------------------------------------------------- *

	* To create variables in each dataset/sample for non-linearities 
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/WI_`var'_em.dta", clear 
	foreach y of varlist CogPGS_sd NCogPGS_sd {
	xtile q3`y' = `y', nq(3)
	xtile q5`y' = `y', nq(5)
	xtile q10`y' = `y', nq(10)
	save "$working_dataset/WI_`var'_em.dta", replace 
	}
	}

	* Loop just for lables
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/WI_`var'_em.dta", clear 
	lab var q3CogPGS_sd "Q3 Cognitive PGI"
	lab var q5CogPGS_sd "Q5 Cognitive PGI"
	lab var q10CogPGS_sd "Q10 Cognitive PGI"
	lab var q3NCogPGS_sd "Q3 Noncognitive PGI"
	lab var q5NCogPGS_sd "Q5 Noncognitive PGI"
	lab var q10NCogPGS_sd "Q10 Noncognitive PGI"
	save "$working_dataset/WI_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* Rename only CITO dataset for models dofile/loop
* ---------------------------------------------------------------------------- *

	u "$working_dataset/WI_CITO_em.dta", clear 
	save "$working_dataset/WI_CITO_sd_em.dta", replace 

********************************************************************************
* Trio design
********************************************************************************

* ---------------------------------------------------------------------------- *
* Analytical sample 
* ---------------------------------------------------------------------------- *

	* To create an analytical sample/dataset for each outcomes
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4   ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/dataset_sampleBE_PGSparents_em.dta", clear
	mark sample_`var' if !missing(CogPGS, NCogPGS, sex, PC1, PC2, PC3,		 ///
		PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child,	 ///
		mother_age, yob, MCogPGS, FCogPGS, FNCogPGS, MNCogPGS, `var')
	keep if sample_`var' == 1 
	drop sample_`var'
	save "$working_dataset/TRIO_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* Standardization (CITO, CogPGS, NCogPGS)
* ---------------------------------------------------------------------------- *

	* To standardize CITO CogPGS NCogPGS in every dataset  
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	 ///
			edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/TRIO_`var'_em.dta", clear 
	foreach x of varlist CITO CogPGS NCogPGS MCogPGS MNCogPGS FCogPGS FNCogPGS {
	egen `x'_sd = std(`x')
	save "$working_dataset/TRIO_`var'_em.dta", replace 
	}
	}

	* Loop just for labels 
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
			edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/TRIO_`var'_em.dta", clear 
	lab var CITO_sd "Test scores CITO (age 12)"
	lab var CogPGS_sd "Cognitive PGI"
	lab var NCogPGS_sd "Noncognitive PGI"
	lab var MCogPGS_sd "Cognitive PGI Mother"
	lab var MNCogPGS_sd "Noncognitive PGI Mother"
	lab var FCogPGS_sd "Cognitive PGI Father"
	lab var FNCogPGS_sd "Noncognitive PGI Father"
	save "$working_dataset/TRIO_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* PGS non-linearities
* ---------------------------------------------------------------------------- *

	* To create variables in each dataset/sample for non-linearities 
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4	 ///
			edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/TRIO_`var'_em.dta", clear 
	foreach y of varlist CogPGS_sd NCogPGS_sd {
	xtile q3`y' = `y', nq(3)
	xtile q5`y' = `y', nq(5)
	xtile q10`y' = `y', nq(10)
	save "$working_dataset/TRIO_`var'_em.dta", replace 
	}
	}

	* Loop just for labels
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4 	 ///
			edu4_after1980 track2 edu7 edu7_after1980 {
	u "$working_dataset/TRIO_`var'_em.dta", clear 
	lab var q3CogPGS_sd "Q3 Cognitive PGI"
	lab var q5CogPGS_sd "Q5 Cognitive PGI"
	lab var q10CogPGS_sd "Q10 Cognitive PGI"
	lab var q3NCogPGS_sd "Q3 NonCognitive PGI"
	lab var q5NCogPGS_sd "Q5 NonCognitive PGI"
	lab var q10NCogPGS_sd "Q10 NonCognitive PGI"
	save "$working_dataset/TRIO_`var'_em.dta", replace 
	}

* ---------------------------------------------------------------------------- *
* Rename only CITO dataset for models dofile/loop
* ---------------------------------------------------------------------------- *

	u "$working_dataset/TRIO_CITO_em.dta", clear 
	save "$working_dataset/TRIO_CITO_sd_em.dta", replace 

