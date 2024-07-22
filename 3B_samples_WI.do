/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Sample & Standardization (Within-family sample)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f
	
u "$working_dataset/dataset_sample_em.dta", clear

/*
* Sample Within-family analysis composition:
* a) Balanced DZ twins
* b) Unbalanced DZ-twin + 1 Random Sibling
* c) 1 Random MZ Twin/ 1 Unbalanced MZ twin + 1 Random Sibling
*/

u "$working_dataset/dataset_sample_em.dta", clear

********************************************************************************
* 1) All balanced DZ (n=3,960); One unbalanced DZ-twin + 1 Random Sibling (n=304)
********************************************************************************

	* (Un)Balanced DZ-twin pairs
	tab multiple_type N_mult_fam if dzm==1 
	duplicates tag FamilyNumber if Extension>=2 & Extension<=3 & dzm==1 & multiple_type==3 & N_mult_fam==1, gen(dup_dz) 
	duplicates report FamilyNumber if Extension>=2 & Extension<=3 & dzm==1 & multiple_type==3 & N_mult_fam==1 
	sort FamilyNumber ID
	//edit FamilyNumber ID Extension dzm dup_dz N_mult_fam multiple_type if dzm==1
	tab dup_dz 
	tab Extension if dzm==1 & dup_dz==1 
	tab dup_dz 
	tab dup_dz dz

	* Checking how many siblings DZ-twins have
	bys FamilyNumber: egen dzf=max(dz)
	bys FamilyNumber: egen sf=max(sibling)
	bys FamilyNumber: egen dup_dz_sib=max(dup_dz)
	tab dzf sf if dup_dz_sib==0 
	count if dzf==1 & sf==1 & dup_dz_sib==0
	tab N_mult_fam if dzf==1 & sf==1 & dup_dz_sib==0
	duplicates tag FamilyNumber if dzf==1 & sf==1 & dup_dz_sib==0, gen(dup_dz_sib2)
	tab dup_dz_sib2

	* 1) Create a random variable (random) to then choose only one random sibling among unbalanced dz-twins with more than 1 sibling
	set seed 2038947  
	gen random = runiform() if dup_dz_sib2!=. & sibling==1 
	sum random

	* 2) Create a variable to randomly take only one sibling per family among unbalanced dz-twins (1 twin-set and no triplets)
	bys FamilyNumber dup_dz_sib2: egen min = min(random) if dup_dz_sib2!=. & sibling==1
	gen random1sib = min == random if dup_dz_sib2!=. & sibling==1
	tab random1sib if dup_dz_sib2!=. & sibling==1
	replace random1sib=2 if dup_dz==0 & dzm==1 & dup_dz_sib2!=.  
	label define random1sib 0 "Non-picked sibling" 1 "Randomly-picked sibling" 2 "Unbalanced DZ-twin with sibling", replace
	label value random1sib random1sib
	fre random1sib
	tab Extension random1sib

********************************************************************************
* 2) One Random MZ twin (from balanced MZ-pairs/families): n=2,630
********************************************************************************

* ----------------------------------------------------------------------------- *
* 1) Look at how many are the MZ in double twin-pair or in triplets in order to take only one of them
* ----------------------------------------------------------------------------- *

	fre Extension
	tab mz
	tab multiple_type N_mult_fam if mzm==1 

* ---------------------------------------------------------------------------- *
* 2) Create a random variable (random) to then choose only one MZ per triplet or pair
* ---------------------------------------------------------------------------- *

	set seed 2038947  
	gen random_mz = runiform() if mz==1
	sum random_mz

* ---------------------------------------------------------------------------- *
* 3) Create a variable (q) to know those are MZ twin no in triplet or only 1 set of twins
* to exclude triplets and two sets of MZ-twins  
* ---------------------------------------------------------------------------- *

	gen q = 1 if inlist(Extension, 2, 3) & mzm==1 & multiple_type==3 & N_mult_fam==1 
	tab q 
	tab N_mult_fam q if mzm==1, miss

* ---------------------------------------------------------------------------- *
* 4) Create a variable (dup2) to randomly take only one MZ in q (per family with 
* 2 mz-twins and 1 twin-set)
* ---------------------------------------------------------------------------- *

	bys FamilyNumber q: egen min_mz = min(random_mz) if mz==1
	gen random_1mz = min_mz == random_mz if mz==1
	tab random_1mz if q==1
	sort FamilyNumber ID Extension mzm
	duplicates tag FamilyNumber if Extension>=2 & Extension<=3 & mzm==1 & multiple_type==3 & N_mult_fam==1, gen(dup2) 

* ---------------------------------------------------------------------------- *
* 5) Finally, excluding 1 MZ-twin by family randomly (n=2,630) 
* ---------------------------------------------------------------------------- *
 
	* Excluding triplets and double twin sets
	duplicates report FamilyNumber if Extension>=2 & Extension<=3 & mzm==1 & multiple_type==3 & N_mult_fam==1 
	tab dup2 
	tab Extension if mzm==1 & dup2==1 
	tab Extension random_1mz if dup2==1, col 

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

********************************************************************************
* 3) One Random MZ-twin (n=2,630) / One Unbalanced MZ-twin (n=406) + One Random Sibling (n=1,772)
********************************************************************************
		
	bys FamilyNumber: egen mzf=max(mz)
	bys FamilyNumber: egen sf2=max(sibling)
	bys FamilyNumber: egen dup_mz=max(dup2) 
	tab mzf sf
	count if mzf==1 & sf2==1
	tab N_mult_fam if mzf==1 & sf2==1

	* Random/Unbalanced MZ twin + 1 Random Sibling
	duplicates tag FamilyNumber if mzf==1 & sf2==1, gen(dup_mz_sib) 
	duplicates report FamilyNumber if mzf==1 & sf2==1 
	tab dup_mz_sib 

* ---------------------------------------------------------------------------- *
* 1) Create a random variable (random) to then choose only one random sibling 
* among Random/Unbalanced mz-twins with more than 1 sibling
* ---------------------------------------------------------------------------- *

	set seed 2038947 
	gen random_mz_sib = runiform() if dup_mz_sib!=. & sibling==1 
	sum random_mz_sib

* ---------------------------------------------------------------------------- *
* 2) Create a variable to randomly take only one sibling per family among random/
* unbalanced mz-twins (1 twin-set and no triplets)
* ---------------------------------------------------------------------------- *

	bys FamilyNumber dup_mz_sib: egen min_mz_sib = min(random_mz_sib) if dup_mz_sib!=. & sibling==1
	gen random1mzsib = min_mz_sib == random_mz_sib if dup_mz_sib!=. & sibling==1
	tab random1mzsib if dup_mz_sib!=. & sibling==1 

	* Generate label random1sib==1 to random/unbalanced mz-twins as to the random picked sibling
	replace random1mzsib=2 if mzm==1 & dup_mz_sib!=. 
	label define random1mzsib 0 "Non-picked sibling" 1 "Randomly-picked sibling" 2 "Random/Unbalanced mz-twin with sibling", replace
	label value random1mzsib random1mzsib
	fre random1mzsib
	tab Extension random1mzsib

	* Balanced DZ-twin pairs
	count if dup_dz==1 & dzm==1

	* + DZ (unbalanced) / MZ (1 random/unbalanced) + Sibling (1 random)
	fre random1sib random1mzsib
	gen randomsib_dz_mz=.
	replace randomsib_dz_mz=0 if dup_dz==1 & dzm==1
	replace randomsib_dz_mz=1 if random1sib==1
	replace randomsib_dz_mz=1 if random1sib==2
	replace randomsib_dz_mz=2 if random1mzsib==1
	replace randomsib_dz_mz=2 if random1mzsib==2
	label define randomsib_dz_mz 0 "Balanced DZ twin-pairs" 1 "Unbalanced DZ + only/random sibling" 2 "Random/Unbalanced MZ-twin + only/random sibling", replace
	label value randomsib_dz_mz randomsib_dz_mz

	fre random1sib random1mzsib randomsib_dz_mz
	keep if randomsib_dz_mz!=.
	
	* Balanced sample (2 copies by family)
	fre randomsib_dz_mz
	duplicates report FamilyNumber

	* Duplicates by outcome's analytical sample (2 copies by family / Balanced sample): Adjust for this in final models (copies==2)
	foreach var of varlist rekenm7 taalm7 rekenm10 taalm10 CITO track edu4   ///
		edu4_after1980 track2 edu7 edu7_after1980 {
	duplicates tag FamilyNumber if `var'!=., gen(dup_`var')
	duplicates report FamilyNumber if `var'!=.
	}

	rename dup_CITO dup_CITO_sd

save "$working_dataset/dataset_sampleWT_randomsibling_em", replace 
