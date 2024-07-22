/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Master 
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

********************************************************************************
* To install if not already available: 
********************************************************************************

/*
ssc install fre, replace all
ssc install coefplot, replace all
ssc install blindschemes, replace all
ssc install grstyle, replace all
ssc install palettes, replace all
ssc install estout, replace all
ssc install reshape8, replace all 
ssc install mdesc, replace all
ssc install ebalance, replace all
ssc install egenmore, replace all
ssc install mipolate, replace all
ssc install palettes, replace
ssc install colrspace, replace
ssc install polychoricpca // otherwise findit 
ssc install grc1leg // otherwise findit 
ssc install sensemakr, replace all
ssc install unique, replace all
ssc install grstyle, replace all
*/

********************************************************************************
* Globals for Directories *
********************************************************************************

	global original_dataset "/Users/gaia/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/NTR/Project/Data/Original/DTA"
	global working_dataset "/Users/gaia/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/NTR/Project/Data/Working"	
	global dofile "/Users/gaia/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/NTR/Project/Replication_Package/Dofile"
	global output_tables "/Users/gaia/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/NTR/Project/Replication_Package/Output/TABLES"
	global output_figures "/Users/gaia/Library/CloudStorage/OneDrive-IstitutoUniversitarioEuropeo/NTR/Project/Replication_Package/Output/FIGURES" 
	
********************************************************************************
* Graphs scheme and graphs *
********************************************************************************

	set scheme white_tableau
	global note2 "Standard Errors in parentesis; P-values in brackets."

********************************************************************************
* Globals for controls *
********************************************************************************

* ---------------------------------------------------------------------------- *
* Between family analysis 
* ---------------------------------------------------------------------------- *

	* Main impact 
	global controlsBE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 

	* Interaction: PGI cognitive skills 
	#delimit ;
	global controlsBE_mod_Cog_edumax 
		PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform												
		c.CogPGS_sd#c.PC1 c.CogPGS_sd#c.PC2 c.CogPGS_sd#c.PC3 					 
		c.CogPGS_sd#c.PC4 c.CogPGS_sd#c.PC5 c.CogPGS_sd#c.PC6					 
		c.CogPGS_sd#c.PC7 c.CogPGS_sd#c.PC8 c.CogPGS_sd#c.PC9					 
		c.CogPGS_sd#c.PC10 c.CogPGS_sd#i.Platform 
		c.CogPGS_sd#c.NCogPGS_sd		 		 
		i.pedu_max_0#c.NCogPGS_sd 						 
		i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2									 
		i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5				 
		i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8				 
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#i.Platform
		;
	#delimit cr
	
	* Interaction: PGI noncognitive skills 	
	#delimit ;
	global controlsBE_mod_NCog_edumax 
		PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 												
		c.NCogPGS_sd#c.PC1 c.NCogPGS_sd#c.PC2 c.NCogPGS_sd#c.PC3 				
		c.NCogPGS_sd#c.PC4 c.NCogPGS_sd#c.PC5 c.NCogPGS_sd#c.PC6				
		c.NCogPGS_sd#c.PC7 c.NCogPGS_sd#c.PC8 c.NCogPGS_sd#c.PC9				
		c.NCogPGS_sd#c.PC10 c.NCogPGS_sd#i.Platform 
		c.NCogPGS_sd#c.CogPGS_sd 					
		i.pedu_max_0#c.CogPGS_sd 				    
		i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2									 
		i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5				 
		i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8				 
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#i.Platform
		;
	#delimit cr

* ---------------------------------------------------------------------------- *
* Trio design
* ---------------------------------------------------------------------------- *

	* Main impact 
	global controlsTRIO PC1 PC2 PC3 PC4 PC5 PC6 PC7 ///
	PC8 PC9 PC10 i.Platform MCogPGS_sd FCogPGS_sd FNCogPGS_sd MNCogPGS_sd

	* Interaction: PGI cognitive skills 
	#delimit ;
	global controlsTRIO_mod_Cog_edumax 
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
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#i.Platform
		;
	#delimit cr

	* Interaction: PGI noncognitive skills 	
	#delimit ;
	global controlsTRIO_mod_NCog_edumax
		PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 
		MCogPGS_sd FCogPGS_sd FNCogPGS_sd MNCogPGS_sd														 
		c.NCogPGS_sd#c.PC1 c.NCogPGS_sd#c.PC2 c.NCogPGS_sd#c.PC3				
		c.NCogPGS_sd#c.PC4 c.NCogPGS_sd#c.PC5 c.NCogPGS_sd#c.PC6				
		c.NCogPGS_sd#c.PC7 c.NCogPGS_sd#c.PC8 c.NCogPGS_sd#c.PC9				 
		c.NCogPGS_sd#c.PC10 c.NCogPGS_sd#i.Platform 
		c.NCogPGS_sd#c.CogPGS_sd 
		c.NCogPGS_sd#c.MCogPGS_sd c.NCogPGS_sd#c.FCogPGS_sd 
		c.NCogPGS_sd#c.MNCogPGS_sd c.NCogPGS_sd#c.FNCogPGS_sd
		i.pedu_max_0#c.CogPGS_sd	
		i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2 
		i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 
		i.pedu_max_0#c.PC5 i.pedu_max_0#c.PC6 
		i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8 
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 
		i.pedu_max_0#i.Platform 
		i.pedu_max_0#c.MCogPGS_sd i.pedu_max_0#c.FCogPGS_sd 
		i.pedu_max_0#c.FNCogPGS_sd i.pedu_max_0#c.MNCogPGS_sd		
		;
	#delimit cr	

* ---------------------------------------------------------------------------- *
* Within family analysis 	
* ---------------------------------------------------------------------------- *

	* Main impact 
	global controlsWI PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 

	* Interaction: PGI cognitive skills
	#delimit ;
	global controlsWI_mod_Cog_edumax PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 
		c.CogPGS_sd#c.NCogPGS_sd						   		
		c.CogPGS_sd#c.PC1 c.CogPGS_sd#c.PC2 c.CogPGS_sd#c.PC3					
		c.CogPGS_sd#c.PC4 c.CogPGS_sd#c.PC5 c.CogPGS_sd#c.PC6					 
		c.CogPGS_sd#c.PC7 c.CogPGS_sd#c.PC8 c.CogPGS_sd#c.PC9					 
		c.CogPGS_sd#c.PC10 c.CogPGS_sd#i.Platform								 
		i.pedu_max_0#c.NCogPGS_sd 
		i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2	
		i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5							 
		i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8							 
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#i.Platform 
		;
	#delimit cr

	* Interaction: PGI noncognitive skills	
	#delimit ;
	global controlsWI_mod_NCog_edumax PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 i.Platform 
		c.NCogPGS_sd#c.CogPGS_sd						     	 
		c.NCogPGS_sd#c.PC1 c.NCogPGS_sd#c.PC2 c.NCogPGS_sd#c.PC3				
		c.NCogPGS_sd#c.PC4 c.NCogPGS_sd#c.PC5 c.NCogPGS_sd#c.PC6				 
		c.NCogPGS_sd#c.PC7 c.NCogPGS_sd#c.PC8 c.NCogPGS_sd#c.PC9				 
		c.NCogPGS_sd#c.PC10 c.NCogPGS_sd#i.Platform								 
		i.pedu_max_0#c.CogPGS_sd 
		i.pedu_max_0#c.PC1 i.pedu_max_0#c.PC2 	
		i.pedu_max_0#c.PC3 i.pedu_max_0#c.PC4 i.pedu_max_0#c.PC5						 	 
		i.pedu_max_0#c.PC6 i.pedu_max_0#c.PC7 i.pedu_max_0#c.PC8						 	 
		i.pedu_max_0#c.PC9 i.pedu_max_0#c.PC10 i.pedu_max_0#i.Platform 
		;
	#delimit cr
		
********************************************************************************
* Replication analysis 
********************************************************************************
	
/**/
	cd $dofile
	
	set more off, perm
	
	do 1_merge
	do 2_data 		
	do 3A_samples_BE
	do 3B_samples_WI	
	do 3C_samples_TRIO
	do 4_samples_ALL
	do 5_tables
	do 6_graphs_M2_coefplot
	do 7_graphs_M3_coefplot
	do 7_graphs_M3_marginsplot
	//do 8_multiple_testing
	do 9A_power_analysis_R2_test	
	//do 9B_power_analysis_PGICOG
	//do 9B_power_analysis_PGINCOG

*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		


