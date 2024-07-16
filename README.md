# NTR_GxE

Title: Interaction of family SES with children’s genetic propensity for cognitive and noncognitive skills: No evidence of the Scarr-Rowe hypothesis for educational outcomes

Authors: Gaia Ghirardi, Carlos Gil-Hernàndez, Fabrizio Bernardi, Elsje van Bergen, Perline Demange

## Data  

We draw on the Netherlands Twin Register (NTR) data. We cannot publish the NTR data, as participants did not consent to sharing their data publicly. However, interested researchers can request and use [NTR data](https://tweelingenregister.vu.nl) following their application procedure.

## Replication Folder and Files description

Following, we describe the dofiles, variables, and datasets used in the main analysis. 

## Dofile description 

| Dofile name               |  Description                                                                      |  
|---------------------------|-----------------------------------------------------------------------------------|            
| 0_master                  | Master dofile                                                                     | 
| 1_merge                   | Merges the phenotypic and genetic datasets                                        |
| 2_data                    | Basic data management and variables encoding                                      |
| 3A_sample_BE              | Sample selection and variable standardization for the between-family analysis     |
| 3B_sample_WI              | Sample selection and variable standardization for the within-family analysis      |
| 3C_sample_TRIO            | Sample selection and variable standardization for the trio analysis               |
| 4_sample_ALL              | Sample selection and variable standardization overall                             |
| 5_descriptive             | Descriptives dofile                                                               |  
| 6_models_tables           | Exports the tables of the main analysis                                           |
| 7_graphs_M2_coefplot      | Graphs plotting the main impact of the PGs and parents' SES                       |
| 8_graphs_M3_coefplot      | Graphs plotting the GxE coefficients                                              |
| 8_graphs_M3_marginsplot   | Graphs plotting the margins of the GxE analysis                                   |
| 9_multiple_testing        | Multiple testing dofile                                                           |
| 9_power_analysis_PGICOG   | Power analysis using Monte-Carlo simulation (PGI cognitive skills)                |
| 9_power_analysis_PGINCOG  | Power analysis using Monte-Carlo simulation (PGI noncognitive skills)             |
| 9_power_analysis_R2_test  | Power analysis R2 test in a multiple linear regression                            |

## Variable description 

| Variable name      |  Description                                                                      |  
|--------------------|-----------------------------------------------------------------------------------|            
| ID                 | Individual's unique id                                                            |
| FamilyNumber       | Family's unique id                                                                |
| rekenm7            | Mathematics (age 7)                                                               | 
| taalm7             | Reading (age 7)                                                                   |
| rekenm10           | Mathematics (age 10)                                                              |
| taalm10            | Reading (age 10)                                                                  |
| CITO_sd            | Test scores (CITO)                                                                |
| track              | Upper secondary track (age 12-18)                                                 |
| edu4_after1980     | Educational Attainment (age ≥ 25)                                                 |
| pedu_max_0         | Parents' education                                                                |
| CogPGS_sd          | PGI cognitive skills                                                              |
| NCogPGS_sd         | PGI noncognitive skills                                                           |

As controls, we have also the first 10 PCs and Platform. 

## Data files to open 

Here, we list the main datasets containing all the variables described above and used in the analyses. 
 
| Datasets                   | Description                                                                   | 
|----------------------------|-------------------------------------------------------------------------------|
| BE_rekenm7_em.dta          | Between-family analysis and Mathematics grade at age 7 as outcome             |
| BE_taalm7_em.dta           | Between-family analysis and Reading grade at age 7 as outcome                 |
| BE_rekenm10_em.dta         | Between-family analysis and Mathematics grade at age 10 as outcome            |
| BE_taalm10_em.dta          | Between-family analysis and Reading grade at age 10 as outcome                |
| BE_CITO_sd_em.dta          | Between-family analysis and Test scores (CITO) at age 12 as outcome           |
| BE_track_em.dta            | Between-family analysis and Upper secondary track at age 12-18 as outcome     |
| BE_edu4_after1980_em.dta   | Between-family analysis and Educational attainment (≥1980) at ≥25 as outcome  |
| WI_rekenm7_em.dta          | Within-family analysis and Mathematics grade at age 7 as outcome              |
| WI_taalm7_em.dta           | Within-family analysis and Reading grade at age 7 as outcome                  |
| WI_rekenm10_em.dta         | Within-family analysis and Mathematics grade at age 10 as outcome             |
| WI_taalm10_em.dta          | Within-family analysis and Reading grade at age 10 as outcome                 |
| WI_CITO_sd_em.dta          | Within-family analysis and Test scores (CITO) at age 12 as outcome            |
| WI_track_em.dta            | Within-family analysis and Upper secondary track at age 12-18 as outcome      |
| WI_edu4_after1980_em.dta   | Within-family analysis and Educational attainment (≥1980) at ≥25 as outcome   |
| TRIO_rekenm7_em.dta        | Trio analysis and Mathematics grade at age 7 as outcome                       |
| TRIO_taalm7_em.dta         | Trio analysis and Reading grade at age 7 as outcome                           |
| TRIO_rekenm10_em.dta       | Trio analysis and Mathematics grade at age 10 as outcome                      |
| TRIO_taalm10_em.dta        | Trio analysis and Reading grade at age 10 as outcome                          |
| TRIO_CITO_sd_em.dta        | Trio analysis and Test scores (CITO) at age 12 as outcome                     |
| TRIO_track_em.dta          | Trio analysis and Upper secondary track at age 12-18 as outcome               |
| TRIO_edu4_after1980_em.dta | Trio analysis and Educational attainment (≥1980) at ≥25 as outcome            |

### Software 

- Stata 
