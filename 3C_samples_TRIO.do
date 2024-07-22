/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Sample & Standardization (Trio sample)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

	clear all
	set more off, perm
	set cformat %3.2f

	* Excluding one random MZ-twin by family 

	u "$working_dataset/dataset_sample_1MZ_em.dta", clear

********************************************************************************
* Checking MZ-twins duplicates (should be 0)
********************************************************************************

	duplicates report FamilyNumber if Extension>=2 & Extension<=3 & mzm==1 & multiple_type==3 & N_mult_fam==1  
	tab dup2
	tab Extension dup2 

********************************************************************************
* Check multiple twin sets and triplets (should be 0)
********************************************************************************

	tab multiple_type N_mult_fam 

********************************************************************************
* Missing Values (adjust for Young or Adult Cohort)
********************************************************************************

	#delimit ;
	mdesc CogPGS NCogPGS MCogPGS FCogPGS FNCogPGS MNCogPGS mother_age sex yob	
	PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 Platform pedu_max_0 N_child		 
	CITO rekenm7 rekenm10 taalm7 taalm10 track edu4
	;
	#delimit cr

	save "$working_dataset/dataset_sampleBE_PGSparents_em.dta", replace


