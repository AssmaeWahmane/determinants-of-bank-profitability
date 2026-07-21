/********************************************************************
Project : Determinants of Bank Profitability in Morocco
Author  : Assmae Wahmane
Degree  : MSc in Quantitative Economics for Decision-Making
Software: Stata 17
Method  : Panel Data Econometrics
Purpose :
This script investigates the determinants of bank profitability
using panel data regression models, specification tests,
diagnostic tests, and Feasible GLS estimation.
********************************************************************/

clear all
set more off

/**************************************************************************
                        1. DATA IMPORT & PANEL SETUP
**************************************************************************/

* Import the dataset
import excel "path_to_dataset.xlsx", sheet("ROA") firstrow clear

* Declare the panel structure
xtset BANQUES ANNEE, yearly


/**************************************************************************
                    2. PRELIMINARY DATA ANALYSIS
**************************************************************************/

* Descriptive statistics
summarize ROA CNE RCNP ADC TB TC TMIC

* Correlation matrix
corr ROA CNE RCNP ADC TB TC TMIC

* Panel descriptive statistics
xtsum ROA CNE RCNP ADC TB TC TMIC


/**************************************************************************
                  3. FISHER HOMOGENEITY TEST
**************************************************************************/

* Residual Sum of Squares (unrestricted model)

local SCR1 = 0

scalar N = 5
scalar TAN = 10
scalar K = 6

forvalues i = 1/5 {

    quietly reg ROA CNE RCNP ADC TB TC TMIC if BANQUES == `i'

    local SCR1 = `SCR1' + e(rss)

}

display `SCR1'

* Residual Sum of Squares (pooled model)

quietly reg ROA CNE RCNP ADC TB TC TMIC

local SCR1C = e(rss)

display `SCR1C'

* Fisher statistic F1

local F1=((`SCR1C'-`SCR1')*(N*TAN-N*(K+1))) ///
          /(`SCR1'*(N-1)*(K+1))

display `F1'

display "dof1 = " (N-1)*(K+1) ///
        " dof2 = " (N*TAN-N*(K+1))

local PVF1 = Ftail((K+1)*(N-1), ///
                   (N*TAN-N*(K+1)), ///
                   `F1')

display invFtail((K+1)*(N-1), ///
                 (N*TAN-N*(K+1)), ///
                 0.05)

* Individual fixed-effects model

xtreg ROA CNE RCNP ADC TB TC TMIC, fe

local SCR1CP = e(rss)

display `SCR1CP'

* Fisher statistic F2

local F2=((`SCR1CP'-`SCR1')*(N*TAN-N*(K+1))) ///
          /(`SCR1'*(N-1)*K)

display "dof1 = " K*(N-1) ///
        " dof2 = " (N*TAN-N*(K+1))

local PVF2=Ftail(K*(N-1), ///
                 (N*TAN-N*(K+1)), ///
                 `F2')

* Fisher statistic F3

local F3=(`SCR1C'-`SCR1CP') ///
         *(N*(TAN-1)-K) ///
         /(`SCR1CP'*(N-1))

display "dof1 = " (N-1) ///
        " dof2 = " (N*(TAN-1)-K)

local PVF3=Ftail((N-1), ///
                 (N*(TAN-1)-K), ///
                 `F3')

* Display results

display "SCR1 = " `SCR1'
display "SCR1C = " `SCR1C'
display "SCR1CP = " `SCR1CP'

display "F1 = " `F1'
display "F2 = " `F2'
display "F3 = " `F3'

display "P-value F1 = " `PVF1'
display "P-value F2 = " `PVF2'
display "P-value F3 = " `PVF3'


/**************************************************************************
                    4. FIXED EFFECTS MODEL
**************************************************************************/

xtreg ROA CNE RCNP ADC TB TC TMIC, fe

estimates store fe


/**************************************************************************
                    5. RANDOM EFFECTS MODEL
**************************************************************************/

xtreg ROA CNE RCNP ADC TB TC TMIC, re

estimates store re


/**************************************************************************
                     6. MODEL SELECTION
**************************************************************************/

* Hausman specification test

hausman fe re

* Breusch-Pagan Lagrange Multiplier test

xttest0


/**************************************************************************
                7. POST-ESTIMATION DIAGNOSTICS
**************************************************************************/

* Estimate FE model

xtreg ROA CNE RCNP ADC TB TC TMIC, fe

* Generate residuals

predict residu, resid

* Groupwise heteroskedasticity

xttest3

* Normality test

sktest residu

* Wooldridge autocorrelation test

xtserial residu


/**************************************************************************
                    8. FEASIBLE GLS ESTIMATION
**************************************************************************/

* Generate bank dummy variables

tabulate BANQUES, generate(z)

* Estimate FGLS model with AR(1) correlation

xtgls ROA CNE RCNP ADC TB TC TMIC ///
      z1 z2 z3 z4 z5, ///
      noconstant ///
      corr(ar1)

* Robust GLS estimation

xtglsr
