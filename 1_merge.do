/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Data preparation & merge 
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

/*
Four datasets: 
1. Phenotypes (PHE_20220215_2952_TVB_GaiaGhirardi_CNN_FIS)
2. PCs (PRS_MRG10_Pedigree_V2_NTR_only)
3. PGS Cog (MRG10_ALL_COG_CEULDpred_inf)
4. PGS NonCog (MRG10_ALL_NONCOG_CEULDpred_inf)
*/

********************************************************************************
* Phenotypes data *
********************************************************************************

	clear all
	set more off, perm
	set cformat %3.2f

	u "$original_dataset/pheno.dta"
	unique FISNumber 

	* Id for merge
	rename FISNumber ID

	* var labels
	lab var FamilyNumber "(nuclear) family number, NC_IDALL"
	lab var Extension "main role in family, not necessarily biological, NC_IDALL"
	lab var role "participant's main role (summary of extension variable), NC_IDALL"
	lab var multiple_type "Type of multiple, NC_IDALL"
	lab var birthorder "birth order according to panter, NC_IDALL"
	lab var sex "sex, NC_IDALL"
	lab var yob "year of birth, NC_IDALL"
	lab var twzyg "zygosity twin 1 vs twin 2, 6 categories, NC_IDALL"
	lab var mult_ext "person extension within a set of multiples, equal to birth order if known, NC_ID"
	lab var N_mult_fam "# sets of multiples within nuclear family, NC_IDALL"
	lab var mult_id_fam "multiple ID to distinguish multiple pairs within the same nuclear family, NC_IDA"

	lab var bioprnt "biological parent of twin, NC_IDALL"
	lab var biosib "biological sibling of twin, NC_IDALL"
	lab var CoB_16cat_agg "Country of birth, old 16 category ANTR coding, NA_AGG"
	lab var CoBm_16cat_agg "Mother's country of birth, old 16 category ANTR coding, NA_AGG"
	lab var CoBv_16cat_agg "Father's country of birth, old 16 category ANTR coding, NA_AGG"

	lab var ses3_agg "SES family age 3"
	lab var ses7_agg "SES family age 7"
	lab var ses10_agg "SES family age 10"
	lab var educat_a_agg "educational attainment, 4 categories, NA_AGG"
	lab var age_a_agg "age educational attainment 7 cat (highest), NA_AGG"
	lab var educat_c_agg "educational attainment, 7 categories, NA_AGG"

	lab var age_c_agg "age educational attainment 7 cat (highest), NA_AGG"
	lab var dad_educat_a_agg "Educational attainment father, 4 cat, NA_AGG"
	lab var dad_report_a_agg "source of information education dad, 4 cat, NA_AGG"
	lab var dad_educat_c_agg "Educational attainment father, 7 cat, NA_AGG"
	lab var dad_report_c_agg "Source of information education dad, 7 cat, NA_AGG"
	lab var mum_educat_a_agg "Educational attainment mother, 4 cat, NA_AGG"
	lab var mum_report_a_agg "Source of information education mum, 4 cat, NA_AGG"
	lab var mum_educat_c_agg "Educational attainment mother, 7 cat, NA_AGG"
	lab var mum_report_c_agg "Source of information education mum, 7 cat, NA_AGG"
	lab var age_father_at_birth_agg "Age father at birth, NA_AGG"
	lab var age_mother_at_birth_agg "Age mother at birth, NA_AGG"
	lab var invjrm7 "Year of filling in survey, YS_7M"

	lab var lositm7 "Which school situation apply most to the twins during primary eduation?, YS_7M - - rated by mothers"
	lab var taalm7 "Current school results of the child: language, YS_7M - rated by mothers"
	lab var rekenm7 "Current school results of the child: arithmetic, YS_7M - rated by mothers" 
	lab var rekenm7n "Current school results of the child: arithmetic (6 levels), YS_7M - rated by mothers"
	lab var taalm7n "Current school results of the child: language (6 levels), YS_7M - rated by mothers"
	lab var in_YS_7M "Participant in survey 7 (YNTR), mother report, YS_7M - rated by mothers"
	lab var agem7 "Derived - Age child, YS_7M"
	lab var invjrv7 "Year of filling in survey, YS_7V"
	lab var lositv7 "Which school situation apply most to the twins during primary eduation?, YS_7V - rated by fathers"
	lab var taalv7 "Current school results: language, YS_7V - rated by fathers"
	lab var rekenv7 "Current school results: arithmetic, YS_7V - rated by fathers"
	lab var rekenv7n "Current school results of the child: arithmetic (6 levels), YS_7V - rated by fathers"
	lab var taalv7n "Current school results of the child: language (6 levels), YS_7V - rated by fathers"
	lab var in_YS_7V "Participant in survey 7 (YNTR), father report, YS_7V "
	lab var agev7 "Derived - Age child, YS_7V"
	lab var invjrm10 "Year of filling in survey, YS_10M"
	lab var lositm10 "Which school situation apply most to the twins during primary eduation?, YS_10M - rated by mothers"
	lab var taalm10 "Current school results: language, YS_10M - rated by mothers"
	lab var rekenm10 "Current school results: arithmetic, YS_10M - rated by mothers"
	lab var in_YS_10M "Participant in survey 10 (YNTR), mother report, YS_10M - rated by mothers"
	lab var agem10 "Derived - Age child, YS_10M"
	lab var invjrv10 "Year of filling in survey, YS_10V"
	lab var lositv10 "Which school situation apply most to the twins during primary eduation?, YS_10V - rated by fathers"
	lab var taalv10 "Current school results: language, YS_10V - rated by fathers"
	lab var rekenv10 "Current school results: arithmetic, YS_10V - rated by fathers"
	lab var in_YS_10V "Participant in survey 10 (YNTR), father report, YS_10V"
	lab var agev10 "Derived - Age child, YS_10V"
	lab var invjrm12 "Year of filling in survey, YS_12M"
	lab var advs0m12 "The school advice of the teacher was: practical training education, YS_12M"
	lab var advs1m12 "The school advice of the teacher was: secondary schools for students with specia" 
	lab var advs2m12 "The school advice of the teacher was: vocational secondary education (vmbo), bas"  
	lab var advs3m12 "The school advice of the teacher was: vocational secondary education (vmbo), adv"  
	lab var advs4m12 "The school advice of the teacher was: lower secondary education (vmbo), theoreti"  
	lab var advs5m12 "The school advice of the teacher was: upper general secondary education, YS_12M"
	lab var advs6m12 "The school advice of the teacher was: combination of upper general secondary edu"  
	lab var advs7m12 "The school advice of the teacher was: upper general secondary education, pre-uni"  
	lab var advs8m12 "The school advice of the teacher was: upper general secondary education, per-uni"  
	lab var advs9m12 "The school advice of the teacher was: does not apply, YS_12M"

	lab var in_YS_12M "Participant in survey 12 (YNTR), mother report, YS_12M"
	lab var agem12 "Derived - Age child, YS_12M"
	lab var invjrv12 "Year of filling in survey, YS_12V"

	lab var advs0v12 "The school advice of the teacher was: practical training education, YS_12V"
	lab var advs1v12 "The school advice of the teacher was: secondary schools for students with specia"
	lab var advs2v12 "The school advice of the teacher was: vocational secondary education (vmbo), bas"
	lab var advs3v12 "The school advice of the teacher was: vocational secondary education (vmbo), adv"
	lab var advs4v12 "The school advice of the teacher was: lower secondary education (vmbo), theoreti"
	lab var advs5v12 "The school advice of the teacher was: upper general secondary education, YS_12V"

	lab var advs6v12 "The school advice of the teacher was: combination of upper general secondary edu"
	lab var advs7v12 "The school advice of the teacher was: upper general secondary education, pre-uni"
	lab var advs8v12 "The school advice of the teacher was: upper general secondary education, per-uni"

	lab var advs9v12 "The school advice of the teacher was: does not apply, YS_12V"
	lab var in_YS_12V "Participant in survey 12 (YNTR), father report, YS_12V"
	lab var agev12 "Derived - Age child, YS_12V"
	lab var in_YS_DHBQ14 "Participant in DHBQ14, self report, YS_DHBQ142"
	lab var in_YS_DHBQ16 "Participant in DHBQ16, self report, YS_DHBQ16"
	lab var invjrt7 "Year of filling in survey, YS_TRF7"
	lab var rekrest7 "For the school subjects listed below, can you indicate the general results of th" 
	lab var taalrest7 "For the school subjects listed below, can you indicate the general results of th" 
	lab var lezrest7 "For the school subjects listed below, can you indicate the general results of th" 
	lab var in_YS_TRF7 "Participant in survey for teachers (TRF), age7, YS_TRF7"

	lab var agetrf7 "Age pupil (derived), YS_TRF7"
	lab var invjrt10 "Year of filling in survey, YS_TRF10"
	lab var rekrest10 "For the school subjects listed below, can you indicate the general results of th" 

	lab var taalrest10 "For the school subjects listed below, can you indicate the general results of th" 
	lab var lezrest10 "For the school subjects listed below, can you indicate the general results of th"
	lab var in_YS_TRF10 "Participant in survey for teachers (TRF), age9/10, YS_TRF10"

	lab var agetrf10 "Age pupil (derived), YS_TRF10"
	lab var ages14 "Age (exact), YS_DHBQ14"
	lab var ages16 "Age (exact), YS_DHBQ16"
	lab var birthweight "Birthweight"
	lab var d_hschm12 "Which type of secondary education does the child attend?, YS_12M [across version"

	lab var se_3_p "Derived - Which type of secondary school are you attending - did you attend?"
	lab var se_3s14 "Derived - Which type of secondary school are you attending - did you attend?"
	lab var se_5s14 "Derived - Which type of secondary school are you attending - did you attend?"
	lab var he_4s14 "Derived - What kind of education did you attend after high school? [Higher educa"
	lab var se_3s16 "Derived - Which type of secondary school are you attending - did you attend? [se"
	lab var se_5s16 "Derived - Which type of secondary school are you attending - did you attend? [se"
	lab var he_4s16 "Derived - What kind of education did you attend after high school? [Higher educa"
	lab var se_3s18 "Derived - Which type of secondary school are you attending - did you attend? [se"
	lab var cito_final_cito "CITO - Cito Final Test score (aggregated over projects), YS_CITO"

	lab var invjrs14 "Year of filling in survey, YS_DHBQ14"
	lab var invjrs16 "Year of filling in survey, YS_DHBQ16"
	lab var sibaq5 "Do the twins have any other brothers/sisters (half brothers/sisters)?"
	lab var sibtot_th5 "Derived -  Total number of siblings living at home (biological, semi-biological"
	lab var sibsm7 "Do the twins have any other brothers/sisters (half brothers/sisters)?"
	lab var sibtot_th7 "Derived -  Total number of siblings living at home (biological, semi-biological "
	lab var sibsm10 "Do the twins have any other brothers/sisters (half brothers/sisters)?"
	lab var sibtot_th10 "Derived -  Total number of siblings living at home (biological, semi-biological"
	lab var sibsm12 "Do the twins have any other brothers/sisters (half brothers/sisters)?"
	lab var sibtot_th12 "Derived -  Total number of siblings living at home (biological, semi-biological"

	save "$working_dataset/phenotypes.dta", replace

********************************************************************************
* Genotypes data *
********************************************************************************

* ---------------------------------------------------------------------------- *
* Basic 
* ---------------------------------------------------------------------------- *

	clear all
	set more off, perm
	set cformat %3.2f

	u "$original_dataset/genotypes.dta"

	* destring ID for merge
	destring ID, replace

	* father and mother 
	encode FATH, generate(FATH2)
	encode MOTH, generate(MOTH2)

	drop FATH MOTH
	rename MOTH2 MOTH
	rename FATH2 FATH

	* Gender
	lab define GENDER 1 "male" 2 "female" 
	lab value GENDER GENDER

	save "$working_dataset/genotypes.dta", replace

* ---------------------------------------------------------------------------- *
* PGS Cog 
* ---------------------------------------------------------------------------- *

	clear all
	set more off, perm
	set cformat %3.2f

	u "$original_dataset/CogPGS.dta"

	* ID for merge
	rename IID ID
	destring ID, replace

	* To invert the sign of PGI
	gen CogPGS = -(SCORE)

	save "$working_dataset/CogPGS.dta", replace

* ---------------------------------------------------------------------------- *
* PGS NonCog 
* ---------------------------------------------------------------------------- *

	clear all
	set more off, perm
	set cformat %3.2f

	u "$original_dataset/NCogPGS.dta"

	* drop CNT CNT2

	* ID for merge
	rename IID ID
	destring ID, replace

	* To invert the sign of PGI
	gen NCogPGS = -(SCORE)

	save "$working_dataset/NCogPGS.dta", replace

********************************************************************************
* Merge  *
********************************************************************************

	u "$working_dataset/phenotypes.dta", clear
	merge 1:1 ID using "$working_dataset/genotypes.dta", keep(master match) nogen
	merge 1:1 ID using "$working_dataset/CogPGS.dta", keep(master match) nogen 
	merge 1:1 ID using "$working_dataset/NCogPGS.dta", keep(master match) nogen
	save "$working_dataset/dataset_merge.dta", replace	



















