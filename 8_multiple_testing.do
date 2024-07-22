/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Romano-Wolf correction
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

* More info: rwolf2 =  https://www.damianclarke.net/computation/rwolf2.pdf 

	//ssc install rwolf2, replace

********************************************************************************
* Datasets construction: 
// to have only one dataset for every outcome, we take the datasets we have 
// before creating one dataset for each outcome (see 4_samples_ALL)
********************************************************************************
	
* ---------------------------------------------------------------------------- *	
* BE
* ---------------------------------------------------------------------------- *

	u "$working_dataset/dataset_sampleBE_NOPGSparents_em.dta", clear
	mark sample_1 if !missing(CogPGS, NCogPGS, mother_age, sex, yob, PC1,    ///
	PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child)
	keep if sample_1 == 1 
	drop sample_1
	
	foreach x of varlist CITO CogPGS NCogPGS {
	egen `x'_sd = std(`x')
}
	save "$working_dataset/BE_data_join.dta", replace
	
* ---------------------------------------------------------------------------- *	
* WI 
* ---------------------------------------------------------------------------- *

	u "$working_dataset/dataset_sampleWT_randomsibling_em.dta", clear
	mark sample_1 if !missing(CogPGS, NCogPGS, sex, yob, PC1, PC2, PC3,		 ///
		PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child) 
	keep if sample_1== 1 
	drop sample_1
	
	foreach x of varlist CITO CogPGS NCogPGS {
	egen `x'_sd = std(`x')
	}	
	
	save "$working_dataset/WI_data_join.dta", replace 

* ---------------------------------------------------------------------------- *	
* TRIO
* ---------------------------------------------------------------------------- *

	u "$working_dataset/dataset_sampleBE_PGSparents_em.dta", clear
	mark sample_1 if !missing(CogPGS, NCogPGS, sex, PC1, PC2, PC3,			 ///
		PC4, PC5, PC6, PC7, PC8, PC9, PC10, Platform, pedu_max_0, N_child,	 ///
		mother_age, yob, MCogPGS, FCogPGS, FNCogPGS, MNCogPGS)
	keep if sample_1 == 1 
	drop sample_1
	
	foreach x of varlist CITO CogPGS NCogPGS MCogPGS MNCogPGS FCogPGS FNCogPGS {
	egen `x'_sd = std(`x')	
	}

	save "$working_dataset/TRIO_data_join.dta", replace 
			
********************************************************************************
* Multiple testing command
********************************************************************************
	
* ---------------------------------------------------------------------------- *
* Cognitive 
* ---------------------------------------------------------------------------- *

	* BE
	use "$working_dataset/BE_data_join", clear 	
	gen interaction = CogPGS_sd*pedu_max_0
	#delimit ;		
	rwolf2 (reg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg taalm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))	
	(reg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))	
	(reg edu4_after1980 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_Cog_edumax , vce(cl FamilyNumber))		, 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) reps(1000) seed(121316) nodots 
	;
	#delimit cr		
		
	* WI 
	use "$working_dataset/WI_data_join", clear 
	gen interaction = CogPGS_sd*pedu_max_0
	xtset FamilyNumber		
	#delimit ;		
	rwolf2 (xtreg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_rekenm7==1 , fe vce(cl FamilyNumber))
	(xtreg taalm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_taalm7==1 , fe vce(cl FamilyNumber))
	(xtreg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_rekenm10==1 , fe vce(cl FamilyNumber))
	(xtreg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_taalm10==1 , fe vce(cl FamilyNumber))
	(xtreg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_CITO_sd==1 , fe vce(cl FamilyNumber))
	(xtreg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_track==1 , fe vce(cl FamilyNumber))
	(xtreg edu4_after1980 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_Cog_edumax 
		if dup_edu4_after1980==1 , fe vce(cl FamilyNumber)), 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) 
	reps(1000) seed(121316) nodots 
	;
	#delimit cr		
	
	* TRIO
	use "$working_dataset/TRIO_data_join", clear 
	gen interaction = CogPGS_sd*pedu_max_0
	#delimit ;		
	rwolf2 (reg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg taalm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))
	(reg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))	
	(reg edu4_after1980 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_Cog_edumax , vce(cl FamilyNumber))	, 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) reps(1000) seed(121316) nodots 
	;
	#delimit cr	
	
* ---------------------------------------------------------------------------- *
* Noncognitive 
* ---------------------------------------------------------------------------- *	

	* BE 	
	use "$working_dataset/BE_data_join", clear 
	gen interaction = NCogPGS_sd*pedu_max_0
	#delimit ;		
	rwolf2 (reg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg taalm7  CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))	
	(reg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))	
	(reg edu4_after1980  CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber))	, 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) reps(1000) 
	seed(121316) nodots 
	;
	#delimit cr	
	
	* WI 
	use "$working_dataset/WI_data_join", clear 
	gen interaction = NCogPGS_sd*pedu_max_0
	xtset FamilyNumber		
	#delimit ;		
	rwolf2 (xtreg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_rekenm7==1 , fe vce(cl FamilyNumber))
	(xtreg taalm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_taalm7==1 , fe vce(cl FamilyNumber))
	(xtreg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_rekenm10==1 , fe vce(cl FamilyNumber))
	(xtreg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_taalm10==1 , fe vce(cl FamilyNumber))
	(xtreg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_CITO_sd==1 , fe vce(cl FamilyNumber))
	(xtreg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_track==1 , fe vce(cl FamilyNumber))
	(xtreg edu4_after1980 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsWI_mod_NCog_edumax 
		if dup_edu4_after1980==1 , fe vce(cl FamilyNumber)), 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) 
	reps(1000) seed(121316) nodots 
	;
	#delimit cr		

	* TRIO
	use "$working_dataset/TRIO_data_join", clear 
	gen interaction = NCogPGS_sd*pedu_max_0
	#delimit ;		
	rwolf2 (reg rekenm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg taalm7 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg rekenm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg taalm10 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg CITO_sd CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))
	(reg track CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))	
	(reg edu4_after1980 CogPGS_sd NCogPGS_sd pedu_max_0 interaction $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber))	, 
	indepvars(interaction, interaction, interaction, interaction, interaction, interaction, interaction) reps(1000) seed(121316) nodots 
	;
	#delimit cr	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	