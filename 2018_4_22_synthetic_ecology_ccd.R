###
# rsm-package version 2.9,  2017-10-23. Response-surface analysis. 
# Creater and maintainer, Russell Lenth russell-lenth@uiowa.edu
# vignette("rsm") run in R Studio to assist with analysis pipeline.
# vignette("rsm-plots") run in R Studio to assist with plotting surface response model:
# https://mran.microsoft.com/snapshot/2015-08-06/web/packages/rsm/vignettes/rsm-plots.pdf
# https://cran.r-project.org/web/packages/rsm/index.html
###

### original data was collected with an additional factor, pH, that was improperly buffered to establish
#desired levels for statistical modeling. Therefore, these data were redacted to exclude the pH factor.
# Redaction process as follows: sort data by Block (replicates, then salt, then kan, and delete those rows that
# are only different in the pH column. To eliminate potential confounding factor, I always deleted the
# row with the higher of the two pH values. 
# The original code that includes pH is shown beneath the revised code. 

### to run code from terminal:
# Rscript --vanilla scriptname.R input_file.csv output_file.pdf
# It also outputs a plot for model adequacy checking. 

library(rsm) # load rsm package
OD_uncoded <- read.csv("OD_uncoded_no_pH.csv", header=T, sep='\t', stringsAsFactors = FALSE)  #Read file to dataframe. File is uncoded additive levels and OD response
OD_coded <- coded.data(OD_uncoded, x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068)  #internally store factor levels as coded
OD_coded  #show transformations used to code factor levels as X1 and X2
as.data.frame(OD_coded)   #append coded data to dataframe for display
#next three lines of code are testing whether variances of second-order (SO) model predictions are reasonably small
par(mfrow=c(1,2))   #set parameters of plot
varfcn(OD_coded, ~ SO(x1,x2), contour = TRUE)
#output ("Rplots.pdf") indicates variance levels are acceptable levels (no error msg, see vignette("rs-illus")
SOdes <- ccd(basis=2, n0=c(3,0), alpha=1.4142, randomize=F, inscribed=F, coding=list(x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068), oneblock=T)
#create coded.data object 'SOdes' (second order design) consisting of one block of runs, non-randomized, including cube (factorial) and star (axial) points.
SOdes_reps <- djoin(SOdes, dupe(SOdes, randomize=F), dupe(SOdes, randomize=F)) #replicates original SOdes, blocked by replicate

OD.rsm <- rsm(OD ~ block + SO(x1, x2), data = OD_coded)   #generate ANOVA and regression from OD_coded; add block by replicate
summary(OD.rsm)  #output of OD.rsm, includes coefficients and SE_coeff for estimating confidence intervals
#next three lines plot the rsm: 
pdf("OD_rsm_noPH.pdf", width=8.3, height=11.7)
persp(OD.rsm, x1 ~ x2, zlab = "OD", col = rainbow(50), contours = "colors")
dev.off() #returns output to 'Plots' window in Rstudio

################### below this line is 3-factor model, 2^3 full factorial including pH

##library(rsm) # load rsm package
#OD_uncoded <- read.csv("OD_uncoded.csv", header=T, sep='\t', stringsAsFactors = FALSE)  #Read file to dataframe. File is uncoded additive levels and OD response
#OD_coded <- coded.data(OD_uncoded, x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068, x3 ~ (pH - 7.3)/0.2121)  #internally store factor levels as coded
#OD_coded  #show transformations used to code factor levels as X1, X2, and X3
#as.data.frame(OD_coded)   #append coded data to dataframe for display
##next three lines of code are testing whether variances of second-order (SO) model predictions are reasonably small
#par(mfrow=c(1,2))   #set parameters of plot
#varfcn(OD_coded, ~ SO(x1,x2,x3), contour = TRUE)
##output indicates variance is acceptable levels (no error msg, see vignette("rs-illus")
#SOdes <- ccd(basis=3, n0=c(3,0), alpha=1.4142, randomize=F, inscribed=F, coding=list(x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068, x3 ~ (pH - 7.3)/0.2121), oneblock=T)
##create coded.data object 'SOdes' (second order design) consisting of one block of 17 runs, non-randomized, including cube (factorial) and star (axial) points.
#SOdes_reps <- djoin(SOdes, dupe(SOdes, randomize=F), dupe(SOdes, randomize=F)) #replicates original SOdes three times, blocked by replicate

#OD.rsm <- rsm(OD ~ block + SO(x1, x2, x3), data = OD_coded)   #generate ANOVA and regression from OD_coded, add block by replicate
#summary(OD.rsm)  #output of OD.rsm, includes coefficients and SE_coeff for estimating confidence intervals
##next three lines of code plot the rsm 
#pdf("OD_rsm.pdf", width=8.3, height=11.7)
#persp(OD.rsm, x1 ~ x2, zlab = "OD", col = rainbow(50), contours = "colors")
#dev.off()


