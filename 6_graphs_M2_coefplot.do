/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Models (Graphs M2: Main impact PGIs and family SES)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f

* ---------------------------------------------------------------------------- *
* Mathematics at age 7
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm7_em", clear 
	if "`des'" == "BE" {
	reg rekenm7 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg rekenm7 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg rekenm7 c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_rekenm7==1, fe vce(cl FamilyNumber)
	}
	estimate store rekenm7_`des'
			
	}

	#delimit ; 
	coefplot 
	(rekenm7_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(rekenm7_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(rekenm7_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family")  
	subtitle(, size(medium))  || 
	(rekenm7_WI, keep(CogPGS_sd) ) 
	(rekenm7_WI, keep(NCogPGS_sd)) 
	(rekenm7_WI, keep(1.pedu_max_0)), bylabel("Within-family") || 
	(rekenm7_TRIO, keep(CogPGS_sd)) 
	(rekenm7_TRIO, keep(NCogPGS_sd)) 
	(rekenm7_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 		   
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).4,  format(%9.1fc)) 
	byopts(compact cols(3) title("Mathematics (age 7)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6)  size(medium)) name(M2_rekenm7, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 7
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm7_em", clear 
	if "`des'" == "BE" {
	reg taalm7 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg taalm7 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg taalm7 c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_taalm7==1, fe vce(cl FamilyNumber)
	}
	estimate store taalm7_`des'  
	}

	#delimit ; 
	coefplot 
	(taalm7_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(taalm7_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(taalm7_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family")  
	subtitle(, size(medium))  || 
	(taalm7_WI, keep(CogPGS_sd) ) 
	(taalm7_WI, keep(NCogPGS_sd)) 
	(taalm7_WI, keep(1.pedu_max_0)), bylabel("Within-family")  || 
	(taalm7_TRIO, keep(CogPGS_sd)) 
	(taalm7_TRIO, keep(NCogPGS_sd)) 
	(taalm7_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).4,  format(%9.1fc)) 
	byopts(compact cols(3) title("Reading (age 7)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6)  size(medium)) name(M2_taalm7, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* Mathematics at age 10
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm10_em", clear 
	if "`des'" == "BE" {
	reg rekenm10 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg rekenm10 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg rekenm10 c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_rekenm10==1, fe vce(cl FamilyNumber)
	}
	estimate store rekenm10_`des'  
	}

	#delimit ; 
	coefplot 
	(rekenm10_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(rekenm10_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(rekenm10_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family") 
	subtitle(, size(medium)) || 
	(rekenm10_WI, keep(CogPGS_sd) ) 
	(rekenm10_WI, keep(NCogPGS_sd)) 
	(rekenm10_WI, keep(1.pedu_max_0)), bylabel("Within-family") || 
	(rekenm10_TRIO, keep(CogPGS_sd)) 
	(rekenm10_TRIO, keep(NCogPGS_sd)) 
	(rekenm10_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).4,  format(%9.1fc)) 
	byopts(compact cols(3) title("Mathematics (age 10)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6)  size(medium)) name(M2_rekenm10, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 10
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm10_em", clear 
	if "`des'" == "BE" {
	reg taalm10 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg taalm10 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg taalm10 c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_taalm10==1, fe vce(cl FamilyNumber)
	}
	estimate store taalm10_`des'  
	}

	#delimit ; 
	coefplot 
	(taalm10_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(taalm10_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(taalm10_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family") 
	subtitle(, size(medium))  || 
	(taalm10_WI, keep(CogPGS_sd) ) 
	(taalm10_WI, keep(NCogPGS_sd)) 
	(taalm10_WI, keep(1.pedu_max_0)), bylabel("Within-family") || 
	(taalm10_TRIO, keep(CogPGS_sd)) 
	(taalm10_TRIO, keep(NCogPGS_sd)) 
	(taalm10_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).4,  format(%9.1fc)) 
	byopts(compact cols(3) title("Reading (age 10)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6)  size(medium)) name(M2_taalm10, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* CITO 
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_CITO_sd_em", clear 
	if "`des'" == "BE" {
	reg CITO_sd c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg CITO_sd c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg CITO_sd c.CogPGS_sd c.NCogPGS_sd $controlsWI if dup_CITO_sd==1, fe vce(cl FamilyNumber)
	}
	estimate store CITO_sd_`des'  
	}

	#delimit ; 
	coefplot 
	(CITO_sd_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(CITO_sd_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(CITO_sd_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family")  
	subtitle(, size(medium)) || 
	(CITO_sd_WI, keep(CogPGS_sd) ) 
	(CITO_sd_WI, keep(NCogPGS_sd)) 
	(CITO_sd_WI, keep(1.pedu_max_0)), bylabel("Within-family") || 
	(CITO_sd_TRIO, keep(CogPGS_sd)) 
	(CITO_sd_TRIO, keep(NCogPGS_sd)) 
	(CITO_sd_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).5,  format(%9.1fc)) 
	byopts(compact cols(3) title("Test scores (CITO) (age 12)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6) size(medium)) name(M2_CITO_sd, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* Track 
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_track_em", clear 
	if "`des'" == "BE" {
	reg track c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg track c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg  track c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_track==1, fe vce(cl FamilyNumber)
	}
	estimate store track_`des'  
	}

	#delimit ; 
	coefplot 
	(track_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(track_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(track_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) 
	, bylabel("Between-family")  
	subtitle(, size(medium)) || 
	(track_WI, keep(CogPGS_sd) ) 
	(track_WI, keep(NCogPGS_sd)) 
	(track_WI, keep(1.pedu_max_0)), bylabel("Within-family") || 
	(track_TRIO, keep(CogPGS_sd)) 
	(track_TRIO, keep(NCogPGS_sd)) 
	(track_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).5,  format(%9.1fc)) 
	byopts(compact cols(3) title("Upper secondary tracks (VWO+HAVO) (age 12-18)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6) size(medium)) name(M2_track, replace)
	;
	#delimit cr

* ---------------------------------------------------------------------------- *
* EA 
* ---------------------------------------------------------------------------- *

	foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_edu4_after1980_em", clear 
	if "`des'" == "BE" {
	reg edu4_after1980 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsBE, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
	reg edu4_after1980 c.CogPGS_sd c.NCogPGS_sd  i.pedu_max_0 $controlsTRIO, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
	xtset FamilyNumber
	xtreg edu4_after1980 c.CogPGS_sd c.NCogPGS_sd  $controlsWI if dup_edu4_after1980==1, fe vce(cl FamilyNumber) 
	}
	estimate store edu4_after1980_`des'  
	}
  
	#delimit ; 
	coefplot 
	(edu4_after1980_BE, keep(CogPGS_sd) msymbol(T) mfcolor(ebblue%20) msize(large) mlcolor(edkblue) ciopts(lcolor(edkblue))) 
	(edu4_after1980_BE, keep(NCogPGS_sd) msymbol(O) mfcolor(orange%20)  msize(large) mlcolor(cranberry) ciopts(lcolor(cranberry))) 
	(edu4_after1980_BE, keep(1.pedu_max_0) msymbol(D) mfcolor(midgreen%20)  msize(large) mlcolor(dkgreen) ciopts(lcolor(dkgreen))) , 
	bylabel("Between-family") 
	subtitle(, size(medium)) || 
	(edu4_after1980_WI, keep(CogPGS_sd) ) 
	(edu4_after1980_WI, keep(NCogPGS_sd)) 
	(edu4_after1980_WI, keep(1.pedu_max_0)), bylabel("Within-family")   || 
	(edu4_after1980_TRIO, keep(CogPGS_sd)) 
	(edu4_after1980_TRIO, keep(NCogPGS_sd)) 
	(edu4_after1980_TRIO, keep(1.pedu_max_0)), bylabel("Trio") vertical 
	xlab("") ylab("") mlabel mlabformat(%9.2g)   mlabposition(3) mlabgap(*2) 
	mlabsize(small)  ylabel(-.1(.1).5,  format(%9.1fc)) 
	byopts(compact cols(3) title("Higher educational attainment (age ≥ 25)", size(medium))) plotlabels("PGI Cognitive skills" "PGI Noncognitive skills" "Family SES")
	yline(0, lwidth(1pt) lcolor(red)) legend(rows(1) pos(6) size(medium)) name(M2_edu4_after1980, replace)
	;
	#delimit cr

	* graph combine

	grc1leg2 M2_rekenm7 M2_taalm7 M2_rekenm10 M2_taalm10 , col (1)  ysize(9)
	graph export "$output_figures/BE_WI_TRIO/M2_grades.pdf", replace 
	graph save "$output_figures/BE_WI_TRIO/M2_grades.gph", replace
	graph export "$output_figures/BE_WI_TRIO/M2_grades.tif", width(4000) replace
	graph export "$output_figures/BE_WI_TRIO/M2_grades.eps", replace

	grc1leg2 M2_CITO_sd M2_track M2_edu4_after1980 , col (1)  ysize(9)
	graph export "$output_figures/BE_WI_TRIO/M2_citotrackedu.pdf", replace 
	graph save "$output_figures/BE_WI_TRIO/M2_citotrackedu.gph", replace
	graph export "$output_figures/BE_WI_TRIO/M2_citotrackedu.tif", width(4000) replace
	graph export "$output_figures/BE_WI_TRIO/M2_citotrackedu.eps",  replace



