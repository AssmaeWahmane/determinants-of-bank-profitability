# 📊 Stata Analysis

This folder contains all the Stata scripts used to perform the econometric analysis for the research project **"Determinants of Moroccan Banks' Profitability"**.

The empirical analysis follows a structured panel data econometric approach to investigate the impact of bank-specific and macroeconomic factors on bank profitability.

---

# 🎯 Objective

The objective of the Stata analysis is to identify the determinants of Moroccan commercial banks' profitability by estimating panel data econometric models and selecting the most appropriate specification based on statistical tests.

---

# 📚 Econometric Methodology

The empirical analysis is conducted in three main stages.

## 1. Preliminary Analysis

The first stage explores the dataset and verifies its suitability for panel data econometric modeling.

The analyses performed include:

- Descriptive statistics of all variables
- Correlation analysis
- Fisher Homogeneity Test

These preliminary analyses provide an overview of the data and help identify potential issues before model estimation.

---

## 2. Panel Data Model Estimation

The second stage consists of estimating alternative panel data models.

The following models and statistical tests are performed:

- Fixed Effects Model
- Random Effects Model
- Hausman Specification Test
- Breusch–Pagan Lagrange Multiplier Test

The Hausman test is used to determine whether the Fixed Effects or Random Effects estimator is the most appropriate model.

---

## 3. Post-Estimation Diagnostics

After selecting the appropriate model, several diagnostic tests are conducted to validate the econometric assumptions.

The validation process includes:

- Residual Normality Test
- Autocorrelation Test
- Heteroskedasticity Test

If heteroskedasticity and/or autocorrelation are detected, the Generalized Least Squares (GLS) estimator is applied to obtain more efficient estimates.

Finally, the estimated coefficients are interpreted and compared with both economic theory and the empirical literature.

---

# 🔄 Econometric Workflow

```text
Data Preparation
        │
        ▼
Preliminary Analysis
        │
        ├── Descriptive Statistics
        ├── Correlation Analysis
        └── Fisher Homogeneity Test
                │
                ▼
Panel Data Estimation
        │
        ├── Fixed Effects Model
        ├── Random Effects Model
        ├── Hausman Test
        └── Breusch–Pagan Test
                │
                ▼
Model Diagnostics
        │
        ├── Residual Normality
        ├── Autocorrelation
        ├── Heteroskedasticity
        └── GLS Estimation (if required)
                │
                ▼
Interpretation of Results
```

---

# 📂 Folder Structure

```text
stata/
│
├── do_files/
│
├── logs/
│
├── output/
│
└── README.md
```

---

# 📜 Stata Scripts

The econometric analysis is organized into independent Stata scripts.

```text
01_descriptive_statistics.do
02_correlation_analysis.do
03_fisher_homogeneity.do
04_fixed_effects_model.do
05_random_effects_model.do
06_hausman_test.do
07_breusch_pagan_test.do
08_model_diagnostics.do
09_gls_estimation.do
10_results_interpretation.do
```

> **Note:** Depending on the final organization of the project, some analyses may be grouped into fewer scripts.

---

# 🛠 Software

- Stata
- Panel Data Econometrics
- Fixed Effects Estimation
- Random Effects Estimation
- Generalized Least Squares (GLS)

---

# 📖 References

The econometric methodology implemented in this folder is based on standard panel data econometric techniques and was developed as part of the Master's research project:

**Determinants of Moroccan Banks' Profitability: A Panel Data Econometric Analysis (2013–2022).**
