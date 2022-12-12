# synthetic_ecology_ccd.R

Statistical model built and tested using the rsm-package (CRAN), from data of defined and undefined bacterial contaminant consortia.

Response variable is total contaminant growth as determined by absorbance measurement at OD600.  
Main factors are kanamycin, NaCl, and pH (optional) levels.  
A central composite design was used to build the model, augmenting a full factorial with replicates at centerpoint, and axial points of root2.  

## Requirements
R version 1.1.463 or later  
rsm-package version 2.9,  2017-10-23. Response-surface analysis. Creater and maintainer, Russell Lenth russell-lenth@uiowa.edu  

## How to run synthetic_ecology_ccd.R
Navigate to a folder containing the R script file, and your data file in .csv format.  
Modify line 33 of R script so that the factor names (column headers) of your data file match the desired variable names (x1 = 'salt', etc.).  
From the terminal, specify your_file_name.csv as your uncoded rsm input data, and your_file_name.pdf as desired rsm data image file output.  
Additional output plot for model adequacy checking is automatically generated.  
Code is provided for either 2-factor or 3-factor rsm; 2-factor is the default. 

Use case:   

drive@user_name ~/filepath   
$ Rscript --vanilla synthetic_ecology_ccd.R input_file.csv output_file.pdf  

## Contact me
31254709+RhysCAllen@users.noreply.github.com  

## Example Output: SRM plot

<img src="https://github.com/RhysCAllen/synthetic_ecology_ccd/blob/master/rainbow_srm.png" width=700 align=left alt="Sample RSM Plot" title="Consortia Growth Response Model">
