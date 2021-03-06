\name{cox_models}
\alias{cox_models}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Cox proportional hazards models and documentation
}
\description{
This function runs age- and multivariable-adjusted cox proportional hazards models.  The final results are compiled into a single table and all documentation is organized and prepared for program review.  Age-standardized rates will also be calculated for the exposure. Additionl functions are available for interaction and stratified models.
}
\usage{
cox_models(dat,failtime,outcome,expo,dtint,birthday,covariates,agedist,agegrps)
}

\arguments{
  \item{dat}{
     Data frame containing the data for the analysis
}
  \item{failtime}{
     Failtime variable (numeric)
}
  \item{outcome}{
     Outcome variable name (numeric), formatted 0=control, 1=case
}
  \item{expo}{
     Exposure variable name.  Exposure can be either continuous (numeric) or categorical (factor)
}
  \item{dtint}{
     Variable name for the start of followup. i.e. "dtint92","dtint97", etc.  This is required for the rate analysis.
}
  \item{birthday}{
     Variable name for exact birth date.  Typically this is our "BDAYDATE" variable from the master file.
}
  \item{covariates}{
     Vector of covariates used in the analysis.  Can be a mixture of numeric/character/factor variables.  No requirements on how they are coded.  Note: missing values in the covariates will drop people from the multivariable models.
}
  \item{agedist}{
     Age distribution standard used for the rate analysis (see nutweightlist documentation for details)
}
  \item{agegrps}{
Vector of start ages for the analysis.  Default is 5-year age groups starting at age 40-44, 45-59,... 85+.  To collapse ages, provide a vector of the ages you want each group to start with.  For example, if you wanted to use 10-year age groups you would provide: c(40,50,60,70,80) to create age groups 40-49, 50-59, 60-69, 70-79, 80+.  For 2 age groups (<65 and 65+) you would provide the vector c(40,65).
}
}
\details{
The cox_models() function automates the coxph() function found in the survival package and will run standard or time-dependent models depending on how the input data frame is constructed.  All models are stratified on single year of age at interview.  The function will run two sets of models with the following formulae:

Age-adjusted models:
     coxph(Surv(OUTCOME,FAILTIME)~EXPOSURE + strata(BASELINE_AGE))

Multivariable-adjusted models:
     coxph(Surv(OUTCOME,FAILTIME)~EXPOSURE + covariates + strata(BASELINE_AGE))

The final output list will contain a data frame organizing all of the results that is suitable for delivery to your PI.  It will also contain all the model output for the age-adjusted and multivariable-adjusted models required for checking your work while doing the analysis and program review.

}
\value{
The function outputs a 4-level list including all the output from the analysis.
     \item{final}{A data frame containing the organized output of the function. Includes exposure name, categories, case numbers, person years, standardized rates, age-adjusted estimates and p-values, and multivariable adjusted estimates and p-values}
          \item{rates}{Output from the rate analysis.  Multilevel list containing the age-specific person-years/events/rates for each level of the exposure as well as a rates$Std.Rates that includes summarized results.  These summarized results are used in the $final data.frame}
      \item{age}{age-adjusted model output documentation}
      \item{multi}{multivariable-adjusted model output documentation}


}

\author{
Brian Carter
}

\seealso{
\code{\link{coxph}}, {\link{incrate}}
}

\examples{
example.data <- data.frame(failnew=sample(1:7000,10000,replace=T),
                           allcauses=sample(0:1,10000,replace=T),
                           smoking=factor(sample(c("Never","Current","Former"),
                                                 10000,replace=T)),
                           dtint92=rep(as.Date("1992-01-01"),10000),
                           bdaydate=sample(c(-15000:5000),10000,replace=T))

foo <- cox_models(dat=example.data,
                  failtime="failnew",
                  outcome="allcauses",
                  expo="smoking",
                  dtint="dtint92",
                  birthday="bdaydate",
                  covariates=NULL,
                  agedist="YEARS00",
                  agegrps=c(40,65))

print(foo$final)
}

