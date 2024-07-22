/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Sample & Standardization (Between family sample)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f

u "$working_dataset/dataset_sample_em.dta", clear 

********************************************************************************
* Exclude 1 Random MZ-twin within Analytical sample (without including outcomes)
********************************************************************************

* ---------------------------------------------------------------------------- * 
* 1) Look at how many are the MZ in double twin-pair or in triplets in order 
* to take only one of them
* ---------------------------------------------------------------------------- * 

	fre Extension
	tab mz
	tab multiple_type N_mult_fam if mzm==1 
	tab Extension if N_mult_fam==2 & mz==1 

* ---------------------------------------------------------------------------- * 
* 2) Create a random variable (random) to then choose only one MZ per triplet or pair
* ---------------------------------------------------------------------------- * 

	set seed 2038947 
	gen random = runiform() if mz==1
	sum random
	// kdensity random

* ---------------------------------------------------------------------------- * 
* 3) Create a variable (q) to know those are MZ twin no in triplet or only 1 set of twins
* to exclude triplets with two sets of MZ-twins  
* ---------------------------------------------------------------------------- * 

	gen q = 1 if inlist(Extension, 2, 3) & mzm==1 & multiple_type==3 & N_mult_fam==1 
	tab q 
	tab N_mult_fam q if mzm==1, miss

* ---------------------------------------------------------------------------- * 
* 4) Create a variable (dup2) to randomly take only one MZ in q 
* (per family with 2 mz-twins and 1 twin-set)
* ---------------------------------------------------------------------------- * 

	bys FamilyNumber q: egen min = min(random) if mz==1
	gen random_1mz = min == random if mz==1
	tab random_1mz if q==1
	sort FamilyNumber ID Extension mzm
	duplicates tag FamilyNumber if Extension>=2 & Extension<=3 & mzm==1 & multiple_type==3 & N_mult_fam==1, gen(dup2) 

* ---------------------------------------------------------------------------- * 
* 5) Finally,excluding 1 MZ-twin by family randomly (n=2,547) 
* for between-family models 
* ---------------------------------------------------------------------------- * 

	*  Excluding triplets and double twin sets
	duplicates report FamilyNumber if Extension>=2 & Extension<=3 & mzm==1 & multiple_type==3 & N_mult_fam==1 
	tab dup2 
	tab Extension if mzm==1 & dup2==1 
	tab Extension random_1mz if dup2==1, col 

	replace dup2=2 if sibling==1
	tab random_1mz q, miss
	drop if random_1mz==0 & dup2==1
	tab random_1mz q, miss
	tab random_1mz dup2
	tab multiple_type N_mult_fam if mzm==1
	drop if random_1mz==1 & q==. 
	drop if random_1mz==0 & q==.
	tab multiple_type N_mult_fam if mzm==1
	tab Extension if mzm==1 & dup2==1 
	tab Extension dup2 

	*DZ
	tab multiple_type N_mult_fam if dzm==1 
	drop if dzm==1 & N_mult_fam>1 
	drop if dzm==1 & multiple_type==2 | multiple_type==4
	tab multiple_type N_mult_fam if dzm==1 

	* Dropping Remaining Multiple twin sets, triplets and single twins registered (n=86)
	tab multiple_type N_mult_fam 
	drop if multiple_type==2 | N_mult_fam==2

	* Duplicates MZ-twins 
	duplicates report FamilyNumber if mzm==1
	tab dup2
	tab Extension dup2 

	* Duplicates MZ-twins by outcome's analytical sample
	duplicates report FamilyNumber if mzm==1 & rekenm7!=.
	duplicates report FamilyNumber if mzm==1 & rekenm10!=.	
	duplicates report FamilyNumber if mzm==1 & taalm7!=.	
	duplicates report FamilyNumber if mzm==1 & taalm10!=.	
	duplicates report FamilyNumber if mzm==1 & CITO!=.	
	duplicates report FamilyNumber if mzm==1 & track!=.	
	duplicates report FamilyNumber if mzm==1 & edu4!=.	

	* Check multiple twin sets and triplets (should be 0)
	tab multiple_type N_mult_fam 

	save "$working_dataset/dataset_sample_1MZ_em.dta", replace

* ---------------------------------------------------------------------------- *
* Checking how many siblings MZ and DZ-twins have/share of twins with siblings
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: egen dzf=max(dzm)
	bys FamilyNumber: egen mzf=max(mzm)
	bys FamilyNumber: egen sf=max(sibling)

	gen nsibling = inlist(role, 2) 
	bys FamilyNumber: egen N_sibling = sum(nsibling)

	tab Extension mzf
	tab Extension if mzf==1
	tab Extension if dzf==1

	tab sibling
	tab sf dzm
	tab N_sibling
	sum sibling nsibling N_sibling
	tab N_sibling dzm
	tab N_sibling dzm, col
	tab N_sibling if dzm==1 // DZ-twins with one or more full siblings n=1,403
	sum N_sibling if dzm==1
	tab N_sibling if mzm==1 // MZ-twins with one or more full siblings n=869
	sum N_sibling if mzm==1

	*Total sample: twins + siblings
	gen nchild_final = inlist(role, 1, 2) 
	bys FamilyNumber: egen N_childfinal = sum(nchild_final)
	tab N_sibling N_childfinal
	bys dzm: tab N_sibling N_childfinal
	corr N_child N_childfinal

	save "$working_dataset/dataset_sampleBE_NOPGSparents_em.dta", replace
