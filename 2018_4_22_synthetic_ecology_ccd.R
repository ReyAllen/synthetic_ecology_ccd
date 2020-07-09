###
# rsm-package version 2.9,  2017-10-23. Response-surface analysis. 
# Creater and maintainer, Russell Lenth russell-lenth@uiowa.edu
# vignette("rsm") run in R Studio to assist with analysis pipeline.
# vignette("rsm-plots") run in R Studio to assist with plotting surface response model:
# https://mran.microsoft.com/snapshot/2015-08-06/web/packages/rsm/vignettes/rsm-plots.pdf
# https://cran.r-project.org/web/packages/rsm/index.html
###


library(rsm) # load rsm package
OD_uncoded <- read.table("OD_uncoded.txt", header=T)  #Read file to dataframe. File is uncoded additive levels and OD response
OD_coded <- coded.data(OD_uncoded, x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068, x3 ~ (pH - 7.3)/0.2121)  #internally store factor levels as coded
OD_coded  #show transformations used to code factor levels as X1, X2, and X3
as.data.frame(OD_coded)   #append coded data to dataframe for display
#next three lines of code are testing whether variances of second-order (SO) model predictions are reasonably small
par(mfrow=c(1,2))   #set parameters of plot
varfcn(OD_coded, ~ SO(x1,x2,x3))
varfcn(OD_coded, ~ SO(x1,x2,x3), contour = TRUE)
#output indicates variance is acceptable levels (no error msg, see vignette("rs-illus")
SOdes <- ccd(basis=3, n0=c(3,0), alpha=1.4142, randomize=F, inscribed=F, coding=list(x1 ~ (salt - 0.3)/0.2122, x2 ~ (kan - 100)/70.71068, x3 ~ (pH - 7.3)/0.2121), oneblock=T)
#create coded.data object 'SOdes' (second order design) consisting of one block of 17 runs, non-randomized, including cube (factorial) and star (axial) points.
SOdes_reps <- djoin(SOdes, dupe(SOdes, randomize=F), dupe(SOdes, randomize=F)) #replicates original SOdes three times, blocked by replicate

OD.rsm <- rsm(OD ~ block + SO(x1, x2, x3), data = OD_coded)   #generate ANOVA and regression from OD_coded, add block by replicate
summary(OD.rsm)  #output of OD.rsm, includes coefficients and SE_coeff for estimating confidence intervals
#next three lines of code plot the rsm 
persp(OD.rsm, x1 ~ x2, zlab = "OD")

######################## below this line is work in progress ############################


persp(swiss2.lm, Education ~ Agriculture, zlab = "Fertility")

