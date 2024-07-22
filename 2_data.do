/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Data preparation 
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

	u "$working_dataset/dataset_merge.dta", clear	
	sort FamilyNumber role
	
********************************************************************************
* Family Information  
********************************************************************************

* ---------------------------------------------------------------------------- *
* Number of children for family
* ---------------------------------------------------------------------------- *

	gen child = inlist(role, 1, 2) 
	bys FamilyNumber: egen N_child = sum(child)
	drop child
	lab var N_child "Number of children (who partecipate to the survey)"

	fre sibtot_th5 sibtot_th7 sibtot_th10 sibtot_th12
	recode sibtot_th5 -1=. 
	recode sibtot_th10 -1=. 

	fre sibaq5 sibsm7 sibsm10 sibsm12

* ---------------------------------------------------------------------------- *
* Change in number of siblings
* ---------------------------------------------------------------------------- *
 
	gen n_sib_delta= sibtot_th12 - sibtot_th5
	recode n_sib_delta (-7/0=0 "No more siblings born") (1/4=1 "One or more siblings born"), gen (n_sib_d)
	lab var n_sib_d "Change in number of siblings (between age 5 and age 12)"
	drop  n_sib_delta	

* ---------------------------------------------------------------------------- *	
* Mother
* ---------------------------------------------------------------------------- *

	gen mother=.
	replace mother=1 if role==3 & sex==2
	replace mother=0 if role==1 | role==2 | role==4 | role==5 | role==6 ///
			| role==7 | role==8 |  role==10 // uncertain about role==4 since it is spouse
	replace mother=0 if role==3 & sex==1 // fathers
	tab mother
	label define mother 0 "No" 1 "Mother", replace
	label value mother mother
	tab role mother

* ---------------------------------------------------------------------------- *
* Father 
* ---------------------------------------------------------------------------- *

	gen father=.
	replace father=1 if role==3 & sex==1
	replace father=0 if role==1 | role==2 | role==4 | role==5 | role==6 	 ///
		| role==7 | role==8 |  role==10 // uncertain about role==4 since it is spouse
	replace father=0 if role==3 & sex==2 // mothers
	tab father
	label define father 0 "No" 1 "Father", replace
	label value father father
	tab role father

* ---------------------------------------------------------------------------- *
* Sex 
* ---------------------------------------------------------------------------- *

	label define sex 0 "Male" 1 "Female", replace
	label value sex sex
	tab sex
	recode sex 1=0 2=1 
	tab sex
	lab var sex "Sex (ref: Female)"

* ---------------------------------------------------------------------------- *
* Twin
* ---------------------------------------------------------------------------- *

	gen twin=0 if role!=. 
	replace twin=1 if role==1 
	label define twin 0 "No" 1 "Twin", replace
	label value twin twin
	tab role twin

* ---------------------------------------------------------------------------- *
* Number of member family
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: gen  N_member = [_N] 
	lab var N_member "Number of people in a family"

* ---------------------------------------------------------------------------- *
* Twin1 & Twin2 & Twin3
* ---------------------------------------------------------------------------- *

	bys FamilyNumber twin : gen  N_twins = _n if twin==1 
	gen twin1=1 if N_twins==1
	gen twin2=1 if N_twins==2
	gen twin3=1 if N_twins==3
	label define twin1 0 "No" 1 "Twin-1", replace
	label define twin2 0 "No" 1 "Twin-1", replace
	label define twin3 0 "No" 1 "Twin-1", replace
	label value twin1 twin1
	label value twin2 twin2
	label value twin3 twin3

* ---------------------------------------------------------------------------- *
* Sibling 
* ---------------------------------------------------------------------------- *

	gen sibling=0 if role!=. 
	replace sibling=1 if role==2 
	label define sibling 0 "No" 1 "Sibling", replace
	label value sibling sibling
	tab role sibling

* ---------------------------------------------------------------------------- *
* Zygosity
* ---------------------------------------------------------------------------- *

	//DOSfm: DZ opposite sex female & male 
	//DOSmf: DZ opposite sex male & female

	*MZ
	fre twzyg
	gen mzm=0 if twzyg!=.
	replace mzm = 1 if twzyg == 1 | twzyg == 3
	label define mzm 0 "No" 1 "Yes", replace
	label value mzm mzm
	lab var mzm "Monozygotic twin"
	tab twzyg mzm

	*DZ 
	fre twzyg 
	gen dzm=0 if twzyg!=.
	replace dzm = 1 if twzyg == 2 | twzyg == 4 | twzyg == 5 | twzyg == 6
	label define dzm 0 "No" 1 "Yes", replace
	label value dzm dzm
	lab var dzm "Dyzigotic twin"
	tab twzyg dzm

********************************************************************************
* Parental Characteristics into Family-Constant Variable
********************************************************************************

	sort FamilyNumber ID

* ---------------------------------------------------------------------------- *
* Mother' education
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: egen medu7 = max(mum_educat_c_agg) 
	label values medu7 mum_educat_c_agg
	lab var medu7 "Mothers educational level - 7 categories"
	tab mum_educat_c_agg medu7, miss

	bys FamilyNumber: egen medu4 = max(mum_educat_a_agg)
	label values medu4 mum_educat_c_agg
	lab var medu4 "Mothers educational level - 4 categories"
	tab mum_educat_a_agg medu4, miss

* ---------------------------------------------------------------------------- *
* Father's education
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: egen fedu7 = max(dad_educat_c_agg)
	label values fedu7 dad_educat_c_agg
	lab var fedu7 "Fathers educational level - 7 categories"

	bys FamilyNumber: egen fedu4 = max(dad_educat_a_agg)
	label values fedu4 dad_educat_a_agg
	lab var fedu4 "Fathers educational level - 4 categories"

* ---------------------------------------------------------------------------- *
* Highest parental educational level
* ---------------------------------------------------------------------------- *

	gen pedu_max=.
	replace pedu_max=medu7 if medu7>fedu7
	replace pedu_max=medu7 if medu7==fedu7
	replace pedu_max=fedu7 if medu7<fedu7
	replace pedu_max=medu7 if fedu7==.
	replace pedu_max=fedu7 if medu7==.
	replace pedu_max=. if medu7==. & fedu7==.
	#delimit ;
	label define pedu_max 1 "primary school only" 2 "lower vocational schooling" 
		3 "lower secondary schooling (general)" 								 
		4 "intermediate vocational schooling" 								   	 
		5 "intermediate/higher secondary schooling (general)" 					 
		6 "higher vocational schooling" 										 
		7 "university"
	;
	#delimit cr	
	label value pedu_max pedu_max 
	tab medu7 fedu7, cell row miss
	fre pedu_max medu7 fedu7
	tab medu7 pedu_max, miss
	tab fedu7 pedu_max, miss

* ---------------------------------------------------------------------------- *
* Mother's age at child birth 
* ---------------------------------------------------------------------------- *

	tab age_mother_at_birth_agg
	fre age_mother_at_birth_agg
	gen age_mother_at_birth=age_mother_at_birth_agg+15
	tab age_mother_at_birth_agg age_mother_at_birth
	rename age_mother_at_birth mother_age
	lab var mother_age "Mother age at birth"

* ---------------------------------------------------------------------------- *
* Father's age at child birth
* ---------------------------------------------------------------------------- *

	tab age_father_at_birth_agg
	fre age_father_at_birth_agg
	gen age_father_at_birth=age_father_at_birth_agg+14
	tab age_father_at_birth_agg age_father_at_birth
	rename age_father_at_birth father_age

* ---------------------------------------------------------------------------- *
* Mother's PGS 
* ---------------------------------------------------------------------------- *
// corrected by conditioning on mother's, otherwise you were assigning the PGS average among all members within the family

	bys FamilyNumber: egen MCogPGS2=mean(CogPGS) if mother==1
	bys FamilyNumber: egen MCogPGS=mean(MCogPGS2)
	drop MCogPGS2
	lab var MCogPGS "PGS Cog Mother"

	bys FamilyNumber: egen MNCogPGS2=mean(NCogPGS) if mother==1 
	bys FamilyNumber: egen MNCogPGS=mean(MNCogPGS2)
	drop MNCogPGS2
	lab var MNCogPGS "PGS NonCog Mother"

* ---------------------------------------------------------------------------- *
* Father's PGS 
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: egen FCogPGS2=mean(CogPGS) if father==1
	bys FamilyNumber: egen FCogPGS=mean(FCogPGS2)
	drop FCogPGS2
	lab var FCogPGS "PGS Cog Father"

	bys FamilyNumber: egen FNCogPGS2=mean(NCogPGS) if father==1
	bys FamilyNumber: egen FNCogPGS=mean(FNCogPGS2)
	drop FNCogPGS2
	lab var FNCogPGS "PGS NonCog Father"

********************************************************************************
* Twin Characteristics
********************************************************************************

* ---------------------------------------------------------------------------- * 
* Year of birth 
* ---------------------------------------------------------------------------- *

	lab var yob "Year of birth"

* ---------------------------------------------------------------------------- *
* Adult EA
* ---------------------------------------------------------------------------- *

	* EA with 4 categories
	recode educat_a_agg (1 2= 0 "Low educated") (3 4 = 1 "High educated"), gen(edu34) 
	lab var edu34 "Educational Attainment"
	recode educat_a_agg (1 2 3 = 0 "Low educated") (4 = 1 "High educated"), gen(edu4) 
	lab var edu4 "Educational Attainment"

	* EA with 7 categories
	recode educat_c_agg (1 2 3 4 = 0 "Low educated") (5 6 7= 1 "High educated"), gen(edu567) 
	lab var edu567 "Educational Attainment"
	recode educat_c_agg (1 2 3 4 5= 0 "Low educated") (6 7= 1 "High educated"), gen(edu67) 
	lab var edu67 "Educational Attainment"
	recode educat_c_agg (1 2 3 4 5 6 = 0 "Low educated") (7= 1 "High educated"), gen(edu7) 
	lab var edu7 "Educational Attainment"

	* EA in 4 categories only those born after 1980
	gen edu4_after1980 = edu4 if yob>=1980
	lab var edu4_after1980 "Educational Attainment (age ≥ 25)"
	label define edu4 0 "Low educated" 1 "High educated", replace
	label value edu4 

	* EA in 4 categories only those born after 1980
	gen edu7_after1980 = edu7 if yob>=1980
	lab var edu7_after1980 "Educational Attainment"
	label define edu7 0 "Low educated" 1 "High educated", replace
	label value edu7 

	* Clone variable for EA to analysis with logistic 
	clonevar edu4_D = edu4
	clonevar edu4_after1980_D = edu4_after1980
	
* ---------------------------------------------------------------------------- *
* Years of education 
* ---------------------------------------------------------------------------- *

	recode educat_a_agg (1 = 7) (2 3 = 10) (4 5 = 13) (6 7 = 19), gen(yrsedu) 
	lab var yrsedu "Years of education"

* ---------------------------------------------------------------------------- *
* Grades in primary education
* ---------------------------------------------------------------------------- *

	fre rekenm7 taalm7 rekenm10 taalm10 
	lab var rekenm7 "Mathematics (age 7)"
	lab var taalm7 "Reading (age 7)"
	lab var rekenm10 "Mathematics (age 10)"
	lab var taalm10 "Reading (age 10)"

	recode rekenm10 (1 2 3 = 0 "Low") (4 5 = 1 "High"), gen(rekenm10_D)
	lab var rekenm10_D "Mathematics (age 10)"
	recode rekenm7 (1 2 3 = 0 "Low") (4 5 = 1 "High"), gen(rekenm7_D)
	lab var rekenm7_D "Mathematics (age 7)"
	recode taalm10 (1 2 3 = 0 "Low") (4 5 = 1 "High"), gen(taalm10_D)
	lab var taalm10_D "Reading (age 10)"
	recode taalm7 (1 2 3 = 0 "Low") (4 5 = 1 "High"), gen(taalm7_D)
	lab var taalm7_D "Reading (age 7)"

* ---------------------------------------------------------------------------- *
* Cito 
* ---------------------------------------------------------------------------- *

	rename cito_final_cito CITO
	lab var CITO "Test scores CITO (age 12)"

* ---------------------------------------------------------------------------- *
* School Tracking
* ---------------------------------------------------------------------------- *

	des d_hschm12 se_3_p se_3s14 se_5s14 se_3s16 se_5s16 se_3s18
	sum d_hschm12 se_3_p se_3s14 se_5s14 se_3s16 se_5s16 se_3s18
	mdesc d_hschm12 se_3_p se_3s14 se_5s14 se_3s16 se_5s16 se_3s18
	fre d_hschm12 se_3_p se_3s14 se_5s14 se_3s16 se_5s16 se_3s18

	*12-14
	tab d_hschm12 se_3s14, m
	tab d_hschm12 se_3s14 if se_3s14!=1, row nofreq
	*12-16
	tab d_hschm12 se_3s16, m
	tab d_hschm12 se_3s16 if se_3s16!=1, row nofreq
	*12-18
	tab d_hschm12 se_3s18, m
	tab d_hschm12 se_3s18 if se_3s18!=1, row nofreq
	*14-16
	tab se_3s14 se_3s16, m
	tab se_3s14 se_3s16, row nofreq
	*14-18
	tab se_3s14 se_3s18, m
	tab se_3s14 se_3s18, row nofreq
	*16-18
	tab se_3s16 se_3s18, m
	tab se_3s16 se_3s18, row nofreq

* ---------------------------------------------------------------------------- *	
* Most conservative measure of School Tracking 
* ---------------------------------------------------------------------------- *

	// Age 12
	clonevar track_12=d_hschm12
		recode track_12 1=. 2/5=0 6/9=1
		label define track_12 0 "VMBO" 1 "HAVO/VWO", replace
		label value track_12 track_12
		fre track_12
		tab track_12 d_hschm12, m

	clonevar track_12p=se_3_p
		recode track_12p 1=. 2=0  3/4=1
		label define track_12p 0 "VMBO" 1 "HAVO/VWO", replace
		label value track_12p track_12p
		fre track_12p
		tab track_12p se_3_p, m
		tab track_12p d_hschm12, m

	// Age 14
	clonevar track_14=se_3s14
		fre track_14
		recode track_14 1=. 2=0  3/4=1
		label define track_14 0 "VMBO" 1 "HAVO/VWO", replace
		label value track_14 track_14
		fre track_14
		tab track_14 se_3s14, m

	// Age 16
	clonevar track_16=se_3s16
		fre track_16
		recode track_16 1=. 2=0  3/4=1
		label define track_16 0 "VMBO" 1 "HAVO/VWO", replace
		label value track_16 track_16
		fre track_16
		tab track_16 se_3s16, m

	// Age 18
	clonevar track_18=se_3s18
		fre track_18
		recode track_18 1=. 2=0  3/4=1
		label define track_18 0 "VMBO" 1 "HAVO/VWO", replace
		label value track_18 track_18
		fre track_18
		tab track_18 se_3s18, m

	* Imput missing track information from later grades
	tab track_12 track_12p, m 

	clonevar track=track_12
		replace track=track_12p if track==. 
		tab track
		replace track=track_14 if track==.
		tab track
		replace track=track_16 if track==.
		tab track
		replace track=track_18 if track==.
		tab track

	clonevar track_miss=track

	* Assign track information from later grade if information available and students 
	* changed track in the following transitions/grades at ages: 12-14; 14-16; 16-18 

	// 12-14
	tab track_12 track_14, row // discordant n=121
	replace track=track_14 if track_12!=. & track_14!=. & track_12!=track_14
		
	// 12-16
	tab track_12 track_16, row // discordant n=93
	replace track=track_16 if track_12!=. & track_16!=. & track_12!=track_16
		
	// 12-18
	tab track_12 track_18, row // discordant n=11
	replace track=track_18 if track_12!=. & track_18!=. & track_12!=track_18
		
	// 14-16
	tab track_14 track_16, row // discordant n=51
	replace track=track_16 if track_14!=. & track_16!=. & track_14!=track_16
		
	// 14-18
	tab track_14 track_18, row // discordant n=0
	replace track=track_18 if track_14!=. & track_18!=. & track_14!=track_18
		
	// 16-18
	tab track_16 track_18, row // discordant n=5
	replace track=track_18 if track_16!=. & track_18!=. & track_16!=track_18

	fre track //Cross-check our distribution (65% academic tracks) with official stats or population-representative data to estimate 
			  // the mangnitude of the positive sample selection bias.
			  // In 2015/16, 28% of Dutch 16-year-olds were enrolled in HAVO. In the same year, 19% of Dutch 16-year-old students 
			  // were enrolled in VWO pre-university education (CBS, 2016). 
				 
	lab var track  "Upper secondary track (age 12-18)"		 

* ---------------------------------------------------------------------------- *
* Less conservative measure of School Tracking 
* ---------------------------------------------------------------------------- *

	// Age 12
	clonevar track_12X=d_hschm12
		recode track_12X 1=. 2/8=0 9=1
		label define track_12X 0 "Lower" 1 "VWO", replace
		label value track_12X track_12X
		fre track_12X
		tab track_12X d_hschm12, m

	clonevar track_12pX=se_3_p
		recode track_12pX 1=. 2/3=0  4=1
		label define track_12pX 0 "Lower" 1 "VWO", replace
		label value track_12pX track_12pX
		fre track_12pX
		tab track_12p se_3_p, m

	// Age 14
	clonevar track_14X=se_3s14
		fre track_14X
		recode track_14X 1=. 2/3=0  4=1
		label define track_14X 0 "Lower" 1 "VWO", replace
		label value track_14X track_14X
		fre track_14X
		tab track_14X se_3s14, m

	// Age 16
	clonevar track_16X=se_3s16
		fre track_16X
		recode track_16X 1=. 2/3=0  4=1
		label define track_16X 0 "Lower" 1 "VWO", replace
		label value track_16X track_16X
		fre track_16X
		tab track_16X se_3s16, m

	// Age 18
	clonevar track_18X=se_3s18
		fre track_18X
		recode track_18X 1=. 2/3=0  4=1
		label define track_18X 0 "Lower" 1 "VWO", replace
		label value track_18X track_18X
		fre track_18X
		tab track_18X se_3s18, m

	* Imput missing track information from later grades
	clonevar track2=track_12X
		replace track2=track_12pX if track2==.
		tab track2
		replace track2=track_14X if track2==.
		tab track2
		replace track2=track_16X if track2==.
		tab track2
		replace track2=track_18X if track2==.
		tab track2

	* Clone variable for tracking to analysis with logistic
	clonevar track_D = track

	* Assign track information from later grade if information available and students 
	* changed track in the following transitions/grades at ages: 12-14; 14-16; 16-18 

	// 12-14
	tab track_12X track_14X, row // discordant n=240
	replace track2=track_14X if track_12X!=. & track_14X!=. & track_12X!=track_14X

	// 12-16
	tab track_12X track_16X, row // discordant n=133
	replace track2=track_16X if track_12X!=. & track_16X!=. & track_12X!=track_16X

	// 12-18
	tab track_12X track_18X, row // discordant n=30
	replace track2=track_18X if track_12X!=. & track_18X!=. & track_12X!=track_18X

	// 14-16
	tab track_14X track_16X, row // discordant n=96
	replace track2=track_16X if track_14X!=. & track_16X!=. & track_14X!=track_16X

	// 14-18
	tab track_14X track_18X, row // discordant n=0
	replace track2=track_18X if track_14X!=. & track_18X!=. & track_14X!=track_18X

	// 16-18
	tab track_16X track_18X, row // discordant n=6
	replace track2=track_18X if track_16X!=. & track_18X!=. & track_16X!=track_18X

	lab var track2  "Academic Tracking (age 12-18)"	

********************************************************************************
* PGI Twin Characteristics
********************************************************************************

* ---------------------------------------------------------------------------- *
* PGI mean among the two/three twins within the same family 
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: egen PGS_pair_meanC=mean(CogPGS) if twin==1
	lab var PGS_pair_meanC "Mean PGS Cog of the 2/3 twins in the same family"

	bys FamilyNumber: egen PGS_pair_meanN=mean(NCogPGS) if twin==1
	lab var PGS_pair_meanN "Mean PGS NonCog of the 2/3 twins in the same family"

* ---------------------------------------------------------------------------- *
* Deviation from Pair Average (Within): by definition, equal and opposite effects for each twin in a pair 
* ---------------------------------------------------------------------------- *

	bys FamilyNumber: gen PGS_devC=CogPGS-PGS_pair_meanC if twin==1 & dzm==1
	sum PGS_devC

********************************************************************************
* SES 
********************************************************************************

	* Imput missing SES age 3 with information from later ages (ses7_agg & ses10_agg)

	sum ses3_agg
	clonevar ses3_aggN=ses3_agg
	replace ses3_aggN=ses7_agg if ses3_agg==.
	sum ses3_aggN
	replace ses3_aggN=ses10_agg if ses3_aggN==.
	sum ses3_aggN

* ---------------------------------------------------------------------------- *
* SES at age 3 
* ---------------------------------------------------------------------------- *

	recode ses3_aggN (1 = 0 "Low SES") ( 2 3 4 5  = 1 "High SES"), gen(ses3_1)
	recode ses3_aggN (1 2 = 0 "Low SES") (3 4 5  = 1 "High SES"), gen(ses3_2)
	recode ses3_aggN (1 2 3 = 0 "Low SES") (4 5  = 1 "High SES"), gen(ses3_3)
	recode ses3_aggN (1 2 3 4 = 0 "Low SES") (5  = 1 "High SES"), gen(ses3_4)

* ---------------------------------------------------------------------------- *
* SES at age 7 
* ---------------------------------------------------------------------------- *

	recode ses7_agg (1 = 0 "Low SES") ( 2 3 4 5  = 1 "High SES"), gen(ses7_1)
	recode ses7_agg (1 2 = 0 "Low SES") (3 4 5  = 1 "High SES"), gen(ses7_2)
	recode ses7_agg (1 2 3 = 0 "Low SES") (4 5  = 1 "High SES"), gen(ses7_3)

* ---------------------------------------------------------------------------- *
* SES at age 10
* ---------------------------------------------------------------------------- * 

	recode ses10_agg (1 = 0 "Low SES") ( 2 3 4 5  = 1 "High SES"), gen(ses10_1)
	recode ses10_agg (1 2 = 0 "Low SES") (3 4 5  = 1 "High SES"), gen(ses10_2)
	recode ses10_agg (1 2 3 = 0 "Low SES") (4 5  = 1 "High SES"), gen(ses10_3)

* ---------------------------------------------------------------------------- *
* Education mother
* ---------------------------------------------------------------------------- *

	recode medu7 (1 2 3 4 5 6 = 0 "Low SES") (7 = 1 "High SES"), gen(medu7_0)
	lab var medu7_0 "Mothers educational level"

* ---------------------------------------------------------------------------- *
* Education parents
* ---------------------------------------------------------------------------- *

	recode pedu_max (1 2 3 4 5 6 = 0 "Low-SES") (7  = 1 "High-SES"), gen(pedu_max_0)
	lab var pedu_max_0 "Highest educational level among parents"

* ---------------------------------------------------------------------------- *
* Education father
* ---------------------------------------------------------------------------- *

	recode fedu7 (1 2 3 4 5 6 = 0 "Low educated") (7  = 1 "High educated"), gen(fedu7_0)

	save "$working_dataset/dataset_vars.dta", replace	
