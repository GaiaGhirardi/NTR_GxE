/*------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
* Project: GxE using NTR
* Authors: Ghirardi et al. (2024)
* Dofile topic: Models (Graphs M3: Interactions PGIs x family SES)
 ------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

clear all
set more off, perm
set cformat %3.2f

********************************************************************************
* Cognitive 
********************************************************************************

* ---------------------------------------------------------------------------- *
* Mathematics at age 7
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm7_em", clear 
	if "`des'" == "BE" {
		reg rekenm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg rekenm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber
		xtreg rekenm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_rekenm7==1, vce(cl FamilyNumber) fe
	}
	estimate store rekenm7_`des'  
}

#delimit ; 
 coefplot 
 (rekenm7_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (rekenm7_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (rekenm7_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc)) 
 title("Mathematics" "(age 7)", size(small)) legend(rows(1) pos(6)) name(M_COG_rekenm7, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 7
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm7_em", clear 
	if "`des'" == "BE" {
		reg taalm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg taalm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg taalm7 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_taalm7==1, vce(cl FamilyNumber) fe
	}
	estimate store taalm7_`des'  
}
// controlsWI_mod_Cog_edumax instead of 

#delimit ; 
 coefplot 
 (taalm7_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (taalm7_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (taalm7_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc)) 
 title("Reading" "(age 7)", size(small)) legend(rows(1) pos(6)) name(M_COG_taalm7, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Mathematics at age 10
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm10_em", clear 
	if "`des'" == "BE" {
		reg rekenm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg rekenm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg rekenm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_rekenm10==1, vce(cl FamilyNumber) fe
	}
	estimate store rekenm10_`des'  
}

#delimit ; 
 coefplot 
 (rekenm10_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (rekenm10_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (rekenm10_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc)) 
 title("Mathematics" "(age 10)", size(small)) legend(rows(1) pos(6)) name(M_COG_rekenm10, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 10
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm10_em", clear 
	if "`des'" == "BE" {
		reg taalm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg taalm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg taalm10 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_taalm10==1, vce(cl FamilyNumber) fe
	}
	estimate store taalm10_`des'  
}

#delimit ; 
 coefplot 
 (taalm10_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (taalm10_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (taalm10_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc))
 title("Reading" "(age 10)", size(small)) legend(rows(1) pos(6)) name(M_COG_taalm10, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* CITO 
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_CITO_sd_em", clear 
	if "`des'" == "BE" {
		reg CITO_sd c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg CITO_sd c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg CITO_sd c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_CITO_sd==1, vce(cl FamilyNumber) fe
	}
	estimate store CITO_sd_`des'  
}

#delimit ; 
 coefplot 
 (CITO_sd_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (CITO_sd_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (CITO_sd_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc)) 
 title("Test Scores (CITO)" "(age 12)", size(small)) legend(rows(1) pos(6)) name(M_COG_CITO_sd, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Track 
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_track_em", clear 
	if "`des'" == "BE" {
		reg track c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg track c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg track c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_track==1, vce(cl FamilyNumber) fe
	}
	estimate store track_`des'  
}

#delimit ; 
 coefplot 
 (track_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (track_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (track_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons ) 
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc)) 
 title("Upper secondary tracks (VWO+HAVO)" "(age 12-18)", size(small)) legend(rows(1) pos(6)) name(M_COG_track, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* EA 
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_edu4_after1980_em", clear 
	if "`des'" == "BE" {
		reg edu4_after1980 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsBE_mod_Cog_edumax, vce(cl FamilyNumber) 
	}
	if "`des'" == "TRIO" {
		reg edu4_after1980 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsTRIO_COG, vce(cl FamilyNumber) 
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg edu4_after1980 c.CogPGS_sd##i.pedu_max_0 c.NCogPGS_sd $controlsWI_mod_Cog_edumax if dup_edu4_after1980==1, vce(cl FamilyNumber) fe
	}
	estimate store edu4_after1980_`des'  
}

#delimit ; 
 coefplot 
 (edu4_after1980_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (edu4_after1980_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (edu4_after1980_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.CogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).2, format(%9.1fc))
 title("Higher educational attainment" " (age ≥ 25)", size(small)) legend(rows(1) pos(6)) name(M_COG_edu4_after1980, replace) 
 ;
#delimit cr

* Graph combine 
grc1leg M_COG_rekenm7 M_COG_taalm7 M_COG_rekenm10 M_COG_taalm10 M_COG_CITO_sd M_COG_track M_COG_edu4_after1980, ///
col (4) ycom title("PGI cognitive x family SES", size(small)) 
graph export "$output_figures/BE_WI_TRIO/M3_coefplot_COG.pdf", replace
graph save "$output_figures/BE_WI_TRIO/M3_coefplot_COG.gph", replace
graph export "$output_figures/BE_WI_TRIO/M3_coefplot_COG.tif", width(4000) replace

********************************************************************************
* NonCognitive 
********************************************************************************

* ---------------------------------------------------------------------------- *
* Mathematics at age 7
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm7_em", clear 
	if "`des'" == "BE" {
		reg rekenm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg rekenm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
	    xtreg rekenm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_rekenm7==1, vce(cl FamilyNumber) fe
	}
	estimate store rekenm7_NC_`des'  
}

#delimit ; 
 coefplot 
 (rekenm7_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (rekenm7_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (rekenm7_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Mathematics" "(age 7)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_rekenm7, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 7
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm7_em", clear 
	if "`des'" == "BE" {
		reg taalm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg taalm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
	    xtreg taalm7 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_taalm7==1, vce(cl FamilyNumber) fe
	}
	estimate store taalm7_NC_`des'  
}

#delimit ; 
 coefplot 
 (taalm7_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (taalm7_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (taalm7_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Reading" "(age 7)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_taalm7, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Mathematics at age 10
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_rekenm10_em", clear 
	if "`des'" == "BE" {
		reg rekenm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg rekenm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg rekenm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_rekenm10==1, vce(cl FamilyNumber) fe
	}
	estimate store rekenm10_NC_`des'  
}

#delimit ; 
 coefplot 
 (rekenm10_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (rekenm10_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (rekenm10_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Mathematics" "(age 10)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_rekenm10, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Reading at age 10
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_taalm10_em", clear 
	if "`des'" == "BE" {
		reg taalm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg taalm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg taalm10 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_taalm10==1, vce(cl FamilyNumber) fe
	}
	estimate store taalm10_NC_`des'  
}

#delimit ; 
 coefplot 
 (taalm10_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (taalm10_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (taalm10_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Reading" "(age 10)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_taalm10, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* CITO at age 12
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_CITO_sd_em", clear 
	if "`des'" == "BE" {
		reg CITO_sd c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg CITO_sd c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg CITO_sd c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_CITO_sd==1, vce(cl FamilyNumber) fe
	}
	estimate store CITO_sd_NC_`des'  
}

#delimit ; 
 coefplot 
 (CITO_sd_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (CITO_sd_NC_WI, msymbol(T) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (CITO_sd_NC_TRIO, msymbol(T) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("CITO" "(age 12)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_CITO_sd, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* Tracking at age 12
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_track_em", clear 
	if "`des'" == "BE" {
		reg track c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg track c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg track c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_track==1, vce(cl FamilyNumber) fe
	}
	estimate store track_NC_`des'  
}

#delimit ; 
 coefplot 
 (track_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (track_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (track_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Upper secondary tracks (VWO+HAVO)" "(age 12-18)", size(small)) legend(rows(1) pos(6)) name(M_NCOG_track, replace) 
 ;
#delimit cr

* ---------------------------------------------------------------------------- *
* EA
* ---------------------------------------------------------------------------- *

foreach des in "BE" "WI" "TRIO" {
	use "$working_dataset/`des'_edu4_after1980_em", clear 
	if "`des'" == "BE" {
		reg edu4_after1980 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsBE_mod_NCog_edumax , vce(cl FamilyNumber)
	}
	if "`des'" == "TRIO" {
		reg edu4_after1980 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsTRIO_NCOG , vce(cl FamilyNumber)
	}
	if "`des'" == "WI" {
		xtset FamilyNumber		
		xtreg edu4_after1980 c.NCogPGS_sd##i.pedu_max_0 CogPGS_sd $controlsWI_mod_NCog_edumax if dup_edu4_after1980==1, vce(cl FamilyNumber) fe
	}
	estimate store edu4_after1980_NC_`des'  
}

#delimit ; 
 coefplot 
 (edu4_after1980_NC_BE, msymbol(Th) mfcolor(edkblue%10) mlcolor(black) ciopts(lcolor(black)) lab("Between-family design")) 
 (edu4_after1980_NC_WI, msymbol(0) mfcolor(edkblue%30) mlcolor(black) ciopts(lcolor(black)) lab("Within-family design")) 
 (edu4_after1980_NC_TRIO, msymbol(D) mfcolor(edkblue%90) mlcolor(black) ciopts(lcolor(black)) lab("Trio design"))
 , cirecast(rcap)   yline(0, lwidth(1pt) lcolor(red))  vertical
 mfcolor(white) msize(medium)  xlabel(,  valuelabel labsize(small))  
 keep (1.pedu_max_0#c.NCogPGS_sd) drop(_cons )  
 xlab("") ylab("") mlabel format(%9.2f)   mlabposition(3) mlabgap(*2) mlabsize(small)
 ylabel(-.4(.1).4, format(%9.1fc)) 
 title("Higher educational attainment" " (age ≥ 25) ", size(small)) legend(rows(1) pos(6)) name(M_NCOG_edu4_after1980, replace) 
 ;
#delimit cr

* Graph combine 
grc1leg M_NCOG_rekenm7 M_NCOG_taalm7 M_NCOG_rekenm10 M_NCOG_taalm10 M_NCOG_CITO_sd M_NCOG_track M_NCOG_edu4_after1980, ///
col (4) ycom title("PGI noncognitive x family SES", size(small)) 
graph export "$output_figures/BE_WI_TRIO/M3_coefplot_NCOG.pdf", replace
graph save "$output_figures/BE_WI_TRIO/M3_coefplot_NCOG.gph", replace
graph export "$output_figures/BE_WI_TRIO/M3_coefplot_NCOG.tif", width(4000) replace













