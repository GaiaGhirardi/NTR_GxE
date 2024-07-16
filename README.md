# NTR_GxE

Title: Interaction of family SES with children’s genetic propensity for cognitive and noncognitive skills: No evidence of the Scarr-Rowe hypothesis for educational outcomes

Authors: Gaia Ghirardi, Carlos Gil-Hernàndez, Fabrizio Bernardi, Elsje van Bergen, Perline Demange

## Data  

We draw on the Netherlands Twin Register (NTR) data. We cannot publish the NTR data, as participants did not consent to sharing their data publicly. However, interested researchers can request and use [NTR data](https://[github.com/GaiaGhirardi/ECEC](https://tweelingenregister.vu.nl) following their application procedure.

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
| 9_power_analysis_PGICOG   ||
| 9_power_analysis_PGINCOG  ||
| 9_power_analysis_R1       ||

## Variable description 

| Variable name      |  Description                                                                      |  
|--------------------|-----------------------------------------------------------------------------------|            
| ID_t               | Child's unique id                                                                 | 
| c_healthDD2        | Child's health at wave 2                                                          |
| place_residence1   | Place of residence                                                                |
| n_siblings1        | Number of siblings at wave 1                                                      |
| n_siblings3        | Number of siblings at wave 3                                                      |
| n_sib_d            | Change in number of siblings                                                      |
| single_parent1     | Cohabitation family wave 1                                                        |
| single_parent2     | Cohabitation family wave 2                                                        |  
| single_parent3     | Cohabitation family wave 2                                                        |
| benefit_ecec       | Benefit expectation Daycare: enrichment                                           |
| att3               | ECEC attendance                                                                   |
| c_weight1          | Child's weight at birth                                                           |
| c_migr_n1          | Child's migration background                                                      |
| p_goals            | Parenting goals                                                                   |
| sensori1_sd        | Cognitive-sensorimotor development                                                |          
| stratum            | Sample: stratification variable                                                   |
| psu                | Sample: Primary Sampling Unit (Point number)                                      |
| weight_ipw_simple  | IPW weight for selection in the sample                                            |
| weight_ipw_at      | IPW weight for controlling for attrition                                          |
| weight_ipw_atW3    | IPW weight for controlling selection in the sample (w3) , and for attrition       |
| weight_ipw_atW45   | IPW weight for controlling selection in the sample (w45) , and for attrition      |
| weight_ipw_atW6    | IPW weight for controlling selection in the sample (w6) , and for attrition       |
| SDQ_ppb4_sd        | Peer problems: Standardized (w4)                                                  |
| SDQ_ppb6_sd        | Peer problems: Standardized (w6)                                                  |
| SDQ_pb4_sd         | Problems Behaviour: Standardized (w4)                                             |    
| SDQ_pb6_sd         |  Prosocial behavior: Standardized (w6)                                            | 
| SDQ_h6_sd          | Hyperactivity: Standardized (w6)                                                  |
| SDQ_bp6_sd         | Behavioral problems: Standardized (w6)                                            |
| voc6_sd            |  Vocabulary: WLE Standardized (w6)                                                |
| cat4_sd            |  Categorization: WLE Standardized (w4)                                            |
| math5_sd           |  Mathematical: WLE Standardized (w5)                                              |

## Data files to open 

| Datasets            | Description                                                                                                            | 
|---------------------|------------------------------------------------------------------------------------------------------------------------|
| TRIO_rekenm7_em.dta | Main dataset containing all variables described above: between-family analysis and Mathematics grade age 7 as outcome  |


### Software 

- Stata 
