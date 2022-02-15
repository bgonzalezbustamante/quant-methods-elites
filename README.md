# quant-methods-elites
**Quantitative Methods for Studying Elites**

[![Version](https://img.shields.io/badge/version-v0.8.3-blue.svg)](CHANGELOG.md) [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](STATUS.md) [![GitHub issues](https://img.shields.io/github/issues/bgonzalezbustamante/quant-methods-elites.svg)](https://github.com/bgonzalezbustamante/quant-methods-elites/issues/) [![GitHub issues-closed](https://img.shields.io/github/issues-closed/bgonzalezbustamante/quant-methods-elites.svg)](https://github.com/bgonzalezbustamante/quant-methods-elites/issues?q=is%3Aissue+is%3Aclosed) [![DOI](https://img.shields.io/badge/DOI-TBC-blue)](CHANGELOG.md) [![License](https://img.shields.io/badge/license-CC--BY--4.0-black)](LICENSE.md) [![R](https://img.shields.io/badge/made%20with-R%20v4.1.0-1f425f.svg)](https://cran.r-project.org/) [![Latex](https://img.shields.io/badge/made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/)

## Overview

This repository contains demonstrations for R of generalised linear models and proportional hazards Cox regressions to measure the impact of individual business trajectories on the access and permanence in political positions in the Chilean executive and legislative branches. These demonstrations are the primary analysis of the forthcoming methodological book chapter entitled “*Métodos cuantitativos para estudiar a las élites: Aplicaciones prácticas, sesgos y potencialidades*”.

In addition, it contains an anonymised, sliced data set from the Chilean Elite Survey (1990-2010) (*N* = 386) in Comma-Separated Values (CSV) format with Unicode encoding (UTF-8). The second data set used in the demonstrations is González-Bustamante and Olivares (2022).[^1]

## Metadata and Preservation

This code and data are stored with version control on a GitHub repository. Furthermore, a Digital Object Identifier is provided by Zenodo.

``` r
quant-methods-elites
|-- .gitignore
|-- CHANGELOG.md
|-- CITATION.cff (pending)
|-- CODE_OF_CONDUCT.md
|-- LICENSE.md
|-- quant-methods-elites.Rproj
|-- README.md
|-- STATUS.md
|-- code
    |-- stage_1_data_cleaning.R
    |-- stage_2_glm.R
    |-- stage_3_cox.R
|-- data
    |-- tidy
        |-- elite_survey_2010.csv
|-- refs
    |-- BIB-QM-Elites.bib
|-- results
    |-- figures
        |-- figure_01a.png
        |-- figure_01b.png
        |-- figure_02.png
        |-- figure_03a.jpg
        |-- figure_03b.jpg
        |-- figure_03c.jpg
        |-- figure_04.jpg
    |-- tables
        |-- table_01.html
        |-- table_01.tex
        |-- table_02.html
        |-- table_02.tex
        |-- table_03.html
        |-- table_03.tex
```

7 directories and 26 files.

In addition, this README file in Markdown (MD) format provides specific information to ensure the replicability of the code.

## Storage and Backup

The GitHub repository has controlled access with Two-Factor Authentication (2FA) with two physical USB security devices (Bastián González-Bustamante, [ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)). Both USB keys issue one-time passwords to generate a cryptographic authentication FIDO2 and U2F.

Moreover, the repository is backed up on Hierarchical File Server (HFS) for recovery in case of incidents. This backup is located on the University of Oxford hub connected to Code42 Cloud Backup encrypted with 256-bit AES. The backup is performed with every change on GitHub and receives weekly light maintenance and a deep one every month. This backup will be secured until May 2024. An extension of this period will be evaluated on budget availability.

## Getting Started

### Software

We use R version 4.1.0 (2021-05-18) -- "Camp Pontanezen".

Required R libraries are: WIP.

We recommend that users run replication code and scripts from the root directory using the R project "quant-methods-elites.Rproj" or, if they wish, import the anonymised, sliced data set from the Chilean Elite Survey (1990-2010) directly using the code below. The instructions for importing data on cabinets are available [**here**](https://github.com/bgonzalezbustamante/chilean-ministers/).

### Import Data

#### R Code

``` r
## GitHub Repository
github_1 <- "https://raw.githubusercontent.com/"
github_2 <- "bgonzalezbustamante/quant-methods-elites/main/data/tidy/"

## Chilean Ministers Data
chilean_ministers <- read.csv(paste(github_1, github_2, "elite_survey_2010.csv", sep = ""),
                              header = T, sep = ",", encoding = "UTF-8")
```
#### Python Code

``` python
import pandas as pd

## GitHub Repository
github_1 = "https://raw.githubusercontent.com/"
github_2 = "bgonzalezbustamante/quant-methods-elites/main/data/tidy/"

## Chilean Ministers Data
url = github_1 + github_2 + "elite_survey_2010.csv"
df = pd.read_csv(url, index_col=0)
```

### Replication Instructions

Folder "code" contains the R scripts.

Subfolders "results/figures" and "results/tables" include all plots and tables provided as PNG, JPG, HTML, and TeX files, respectively.

- **Stage 1.** Please do not run R script "**stage_1_data_cleaning.R**" from the "code" folder since it requires complete, non-anonymised data sets under embargo.

- **Stage 2.** Run script "**stage_2_glm.R**" from the "code" folder. This script contains GLMs demonstrations for R. Model after matching is not available for the moment since the propensity score chunk is still under embargo.

- **Stage 3.** Run script "**stage_3_cox.R**" from the "code" folder. This script contains proportional hazards models for R. Model after matching is not available for the moment since the propensity score chunk is still under embargo.

### Codebook

The file "**elite_survey_2010.csv**" in "data/tidy" subfolder is the anonymised, sliced data set on Chilean elite between 1990 and 2010. This set contains 386 observations.[^2]

- **id**. Unique ID.

- **sex**. Case sex.

- **dob**. Date of birth.

- **political_capital**.

- **education**.

- **school**.

- **family_capital**.

- **capital_father**.

- **capital_mother.

- **party_1**.

- **party_2**.

- **party_3**.

- **party_4**.

- **t1**.

- **t2**.

- **t3**.

- **t4**.

- **t5**.

- **t6**.

- **t7**.

- **t8**.

- **t9**.

- **exp_business**.

- **president**.

- **minister**.

- **senator**.

- **deputy**.

- **undersecretary**.

- **indendant**.

- **ceo**.

- **cabinet_chief**.

- **party_leader**.

## License

This R code and anonymised, sliced data set from the Chilean Elite Survey (1990-2010) are released under a [Creative Commons Attribution 4.0 International license (CC BY 4.0)](LICENSE.md). This open-access license allows the data to be shared, reused, adapted as long as appropriate acknowledgement is given.

## Contribute

Contributions are entirely welcome. You just need to [open an issue](https://github.com/bgonzalezbustamante/quant-methods-elites/issues/new) with your comment or idea.

For more substantial contributions, please fork this repository and make changes. Pull requests are also welcome.

Please read our [code of conduct](CODE_OF_CONDUCT.md) first. Minor contributions will be acknowledged, and significant ones will be considered on our contributor roles taxonomy.

## Citation

González-Bustamante, B. (2022). Quantitative Methods for Studying Elites (Version 0.8.3 -- TBC) [Computer software].

## Author

Bastián González-Bustamante \
bastian.gonzalezbustamante@politics.ox.ac.uk \
[ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820) \
https://bgonzalezbustamante.com 

## CRediT - Contributor Roles Taxonomy

Bastián González-Bustamante ([ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)): Conceptualisation, data curation, formal analysis, investigation, methodology, resources, software, validation, visualisation, writing – original draft, and writing – review and editing

Alfredo Joignant ([ORCID iD 0000-0002-5811-0988](https://orcid.org/0000-0002-5811-0988)): Data curation, funding acquisition, project administration, resources, supervision, and validation.

ANID/FONDECYT 1100877 Research Team: Investigation.[^3]

### Latest Revision

[February 12, 2022](CHANGELOG.md).

[^1]: González-Bustamante, B., & Olivares, A. (2022). Data Set on Chilean Ministers (1990-2014) (Version 3.1.0 -- Lively Wind) [Data set]. DOI: [10.5281/zenodo.5744536](https://doi.org/10.5281/zenodo.5744536).
[^2]: Although the codebook is still in progress, the names of some variables are self-explanatory.
[^3]: For contributions related to cabinet data, see this [GitHub repository](https://github.com/bgonzalezbustamante/chilean-ministers/).
