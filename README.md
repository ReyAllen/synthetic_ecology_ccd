# synthetic_ecology_srm.R

Statistical model built and tested using the rsm-package (CRAN), from data of defined and undefined bacterial contaminant consortia.

Response variable is total contaminant growth as determined by absorbance measurement at OD600.
Main factors are kanamycin, NaCl, and pH (optional) levels.
A central composite design was used to build the model, augmenting a full factorial with replicates at centerpoint, and axial points of root2.

## Requirements
- R version 1.1.463 or later
- rsm-package version 2.9,  2017-10-23. Response-surface analysis. Creater and maintainer, Russell Lenth russell-lenth@uiowa.edu

## How to run synthetic_ecology_srm.R
From the terminal, specify input_file.csv as your uncoded rsm input data, and output_file.pdf as desired rsm data image file output. 

Sample code: 

drive@user_name /filepath ~  
$ Rscript --vanilla synthetic_ecology_srm.R input_file.csv output_file.pdf  

## Contact me
reyallen@users.noreply.github.com
