# quant-methods-elites
**Quantitative Methods for Studying Elites: Demonstration for R**

[![Version](https://img.shields.io/badge/version-v1.0.0-blue.svg)](CHANGELOG.md) [![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](STATUS.md) [![GitHub issues](https://img.shields.io/github/issues/bgonzalezbustamante/quant-methods-elites.svg)](https://github.com/bgonzalezbustamante/quant-methods-elites/issues/) [![GitHub issues-closed](https://img.shields.io/github/issues-closed/bgonzalezbustamante/quant-methods-elites.svg)](https://github.com/bgonzalezbustamante/quant-methods-elites/issues?q=is%3Aissue+is%3Aclosed) [![DOI](https://zenodo.org/badge/455969529.svg)](https://zenodo.org/badge/latestdoi/455969529) [![License](https://img.shields.io/badge/license-GNU%20GPLv3-black)](LICENSE-GPL.md) [![License](https://img.shields.io/badge/license-CC%20BY%204.0-black)](LICENSE-CC.md) [![R](https://img.shields.io/badge/made%20with-R%20v4.1.0-1f425f.svg)](https://cran.r-project.org/) [![Latex](https://img.shields.io/badge/made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/)

## Overview

This repository contains demonstrations for `R` of generalised linear models and proportional hazards Cox regressions to measure the impact of individual business trajectories on the access and permanence in political positions in the Chilean executive and legislative branches. These demonstrations are the primary analysis of the forthcoming methodological article entitled “*Métodos cuantitativos para estudiar a las élites: Aplicaciones prácticas, sesgos y potencialidades*”.[^1]

In addition, it contains an anonymised, sliced data set from the Chilean Elite Survey (1990-2010) (*N* = 386) in Comma-Separated Values `CSV` format with Unicode encoding `UTF-8` based on the latest update by Joignant and González-Bustamante (2014).[^2] The second data set used in the demonstrations is González-Bustamante and Olivares (2022).[^3]

## Metadata and Preservation

This code and data are stored with version control on a GitHub repository. Furthermore, a Digital Object Identifier is provided by Zenodo.

``` r
quant-methods-elites
|-- .gitignore
|-- CHANGELOG.md
|-- CITATION.cff
|-- CODE_OF_CONDUCT.md
|-- LICENSE.md
|-- quant-methods-elites.Rproj
|-- README.md
|-- STATUS.md
|-- code
    |-- stage_0_descriptives.R
    |-- stage_1_data_cleaning.R
    |-- stage_2_glm.R
    |-- stage_3_cox.R
|-- data
    |-- raw
        |-- chamber_1990_1994.csv
        |-- chamber_1994_1998.csv
        |-- chamber_1998_2002.csv
        |-- chamber_2002_2006.csv
        |-- chamber_2006_2010.csv
        |-- chamber_2010_2014.csv
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

8 directories and 33 files.

In addition, this README file in Markdown `MD` format provides specific information to ensure the replicability of the code.

## Storage and Backup

The GitHub repository has controlled access with Two-Factor Authentication `2FA` with two physical USB security devices (Bastián González-Bustamante, [ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)). Both USB keys issue one-time passwords to generate a cryptographic authentication `FIDO2` and `U2F`.

Moreover, the repository is backed up on Hierarchical File Server `HFS` for recovery in case of incidents. This backup is located on the University of Oxford hub connected to `Code42` Cloud Backup encrypted with `256-bit AES`. The backup is performed with every change on GitHub and receives weekly light maintenance and a deep one every month. This backup will be secured until May 2024. An extension of this period will be evaluated on budget availability.

## Getting Started

### Software

We use `R v4.1.0 -- Camp Pontanezen` and the following packages: `foreign v0.8-81`, `performance v0.8.0`, `pscl v1.5.5`, `sjPlot v2.8.9`, `stargazer v5.2.2`,	`survival v3.2-11` and `tidyverse v1.3.1`. In addition, we have used `ggplot2 v3.3.3` as a dependency.

Propensity score estimation, under embargo, was carried out using `MatchIt v4.2.0`, `cobalt v4.3.1`, `lmtest v0.9-38`, `sandwich v3.0-1` and, as a dependency, `optmatch v0.9-14`. A more complex code is already released as supplementary material in González-Bustamante (2022).[^4]

We recommend that users run replication code and scripts from the root directory using the `R` project `quant-methods-elites.Rproj` or, if they wish, import the anonymised, sliced data set from the Chilean Elite Survey (1990-2010) directly using the code below. The instructions for importing data on cabinets are available on this [**GitHub repository**](https://github.com/bgonzalezbustamante/chilean-ministers/).

### Import Data

#### R Code

``` r
## GitHub Repository
github_1 <- "https://raw.githubusercontent.com/"
github_2 <- "bgonzalezbustamante/quant-methods-elites/main/data/tidy/"

## Elite Survey Data
elite_survey <- read.csv(paste(github_1, github_2, "elite_survey_2010.csv", sep = ""),
                              header = T, sep = ",", encoding = "UTF-8")
```
#### Python Code

``` python
import pandas as pd

## GitHub Repository
github_1 = "https://raw.githubusercontent.com/"
github_2 = "bgonzalezbustamante/quant-methods-elites/main/data/tidy/"

## Elite Survey Data
url = github_1 + github_2 + "elite_survey_2010.csv"
df = pd.read_csv(url, index_col=0)
```

### Replication Instructions

Folder `code` contains the `R` scripts.

Subfolders `results/figures` and `results/tables` include all plots and tables provided as `PNG`, `JPG`, `HTML`, and `TeX` files, respectively.

- **Stage 1.** Please do not run `R` script `stage_1_data_cleaning.R` from the "code" folder since it requires complete, non-anonymised data sets under embargo.

- **Stage 2.** Run script `stage_2_glm.R` from the `code` folder. This script contains GLMs demonstrations for `R`. Model after matching is not available for the moment since the propensity score chunk is still under embargo.

- **Stage 3.** Run script `stage_3_cox.R` from the `code` folder. This script contains proportional hazards models for `R`. Model after matching is not available for the moment since the propensity score chunk is still under embargo.

The file `stage_0_descriptives.R` contains a descriptive code for the Chamber of Deputies using a sliced data set from González-Bustamante and Cisternas (2016).[^5] This is not necessary for the models.

To ensure the replicability of our analyses, we used project-local R dependency with `renv v0.16.0`.

``` r
library(renv)
renv::init()
renv::install("tidyverse@1.3.1")
renv::install("foreign@0.8-81")
renv::install("performance@0.8.0")
renv::install("pscl@1.5.5")
renv::install("stargazer@5.2.2")
renv::install("sjPlot@2.8.9")
renv::install("ggplot2@3.3.3")
renv::install("MatchIt@4.2.0") ## PSA code under embargo
renv::install("cobalt@4.3.1") ## PSA code under embargo
renv::install("lmtest@0.9-38") ## PSA code under embargo
renv::install("sandwich@3.0-1") ## PSA code under embargo
renv::install("optmatch@0.9-14") ## PSA code under embargo
renv::install("survival@3.2-11")
renv::snapshot()
renv::status()
```

### Codebook

The file `elite_survey_2010.csv` in `data/tidy` subfolder is the anonymised, sliced data set on Chilean elite between 1990 and 2010. This set contains 386 observations.

- `id`. Unique ID per case.

- `sex`. Case sex.

- `dob`. Date of birth.

- `political_capital`. A nominal variable indicating the highest post in a political party: national, regional, local level, none formal position.

- `education`. A nominal variable indicating the highest educational level: primary school, high school, BA/BPS completed, technical career achieved, unfinished college or technical career, graduate studies without a degree, MA/MBA, PhD, PhD candidate.

- `school`. A nominal variable indicating the type of primary school: secular private, religious private, subsidised private, local government school, or public primary school,

- `family_capital`. A dummy variable indicating whether the case's parents held government first-line positions (*i.e.*, minister, undersecretary or senior public manager) or was a congressman or congresswoman.

- `capital_father`. A dummy variable indicating whether the case's father held government first-line positions (*i.e.*, minister, undersecretary or senior public manager) or was a congressman or congresswoman.

- `capital_mother`. A dummy variable indicating whether the case's mother held government first-line positions (*i.e.*, minister, undersecretary or senior public manager) or was a congressman or congresswoman.

- `party_1`. A nominal variable indicating partisanship (first option).

- `party_2`. A nominal variable indicating partisanship (second option).

- `party_3`. A nominal variable indicating partisanship (third option).

- `party_4`. A nominal variable indicating partisanship (fourth option).

- `t1`. A nominal variable indicating public and private careers in chronological order (first post)

- `t2`. A nominal variable indicating public and private careers in chronological order (second post)

- `t3`. A nominal variable indicating public and private careers in chronological order (third post)

- `t4`. A nominal variable indicating public and private careers in chronological order (fourth post)

- `t5`. A nominal variable indicating public and private careers in chronological order (fifth post)

- `t6`. A nominal variable indicating public and private careers in chronological order (sixth post)

- `t7`. A nominal variable indicating public and private careers in chronological order (seventh post)

- `t8`. A nominal variable indicating public and private careers in chronological order (eighth post)

- `t9`. A nominal variable indicating public and private careers in chronological order (ninth post)

- `exp_business`. A dummy variable indicating whether the case has a previous trajectory as a CEO.

- `president`. A dummy variable indicating whether the case's highest political post was president.

- `minister`. A dummy variable indicating whether the case's highest political post was minister.

- `senator`. A dummy variable indicating whether the case's highest political post was senator.

- `deputy`. A dummy variable indicating whether the case's highest political post was deputy.

- `undersecretary`. A dummy variable indicating whether the case's highest political post was undersecretary (*i.e.*, viceminister).

- `intendant`. A dummy variable indicating whether the case's highest political post was intendant.

- `ceo`. A dummy variable indicating whether the case's highest political post was senior public manager.

- `cabinet_chief`. A dummy variable indicating whether the case's highest political post was cabinet chief.

- `party_leader`. A dummy variable indicating whether the case's highest political post was party leader.

## License

The content of this project itself is licensed under a [Creative Commons Attribution 4.0 International license (CC BY 4.0)](LICENSE-CC.md), and the underlying code used to format and display that content is licensed under an [GNU GPLv3 license](LICENSE-GPL.md).

The above implies that the data set may be shared, reused, and adapted as long as appropriate acknowledgement is given. In addition, the code may be shared, reused, and adapted as long as the source is disclosed, the changes are stated, and the same [GNU GPLv3 license](LICENSE-GPL.md) is used.

## Contribute

Contributions are entirely welcome. You just need to [open an issue](https://github.com/bgonzalezbustamante/quant-methods-elites/issues/new) with your comment or idea.

For more substantial contributions, please fork this repository and make changes. Pull requests are also welcome.

Please read our [code of conduct](CODE_OF_CONDUCT.md) first. Minor contributions will be acknowledged, and significant ones will be considered on our contributor roles taxonomy.

## Citation

González-Bustamante, B. (2022). Quantitative Methods for Studying Elites: Demonstration for R (Version 1.0.0 -- Quiet Hill) [Computer software]. DOI: [10.5281/zenodo.6098061](https://doi.org/10.5281/zenodo.6098061)

## Author

Bastián González-Bustamante \
bastian.gonzalezbustamante@politics.ox.ac.uk \
[ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820) \
https://bgonzalezbustamante.com

## CRediT - Contributor Roles Taxonomy

Bastián González-Bustamante ([ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)): Conceptualisation, data curation, formal analysis, methodology, resources, software, validation, visualisation, writing – original draft, and writing – review and editing.

Alfredo Joignant ([ORCID iD 0000-0002-5811-0988](https://orcid.org/0000-0002-5811-0988)): Data curation, funding acquisition, project administration, resources, supervision, and validation.

Gonzalo Delamaza ([ORCID iD 0000-0002-5418-3135](https://orcid.org/0000-0002-5418-3135)): Resources and supervision.

Hernán Cuevas ([ORCID iD 0000-0002-4295-5652](https://orcid.org/0000-0002-4295-5652)): Resources and supervision.

Manuel Gárate ([ORCID iD 0000-0002-0016-596X](https://orcid.org/0000-0002-0016-596X)): Resources and supervision.

ANID/FONDECYT 1100877 Research Team: Investigation.[^6]

### Latest Revision

[November 25, 2022](CHANGELOG.md).

[^1]: González-Bustamante, B. (2022, *forthcoming*). Métodos cuantitativos para estudiar a las élites: Aplicaciones prácticas, sesgos y potencialidades. *Revista Chilena de Derecho y Ciencia Política*. SocArXiv: [10.31235/osf.io/5m2ur](https://doi.org/10.31235/osf.io/5m2ur).
[^2]: Joignant, A., & González-Bustamante, B. (2014). El núcleo de la élite política chilena 1990-2010. Proyecto Fondecyt 1100877. Working Paper, Universidad Diego Portales.
[^3]: González-Bustamante, B., & Olivares, A. (2022). Data Set on Chilean Ministers (1990-2014) (Version 3.3.6 -- Dry Bonus) [Data set]. DOI: [10.5281/zenodo.5744536](https://doi.org/10.5281/zenodo.5744536).
[^4]: González-Bustamante, B. (2022). Ministerial Stability During Presidential Approval Crises: The Moderating Effect of Ministers’ Attributes on Dismissals in Brazil and Chile. *The British Journal of Politics and International Relations*. OnlineFirst. DOI: [10.1177/13691481221124850](https://doi.org/10.1177/13691481221124850).
[^5]: González-Bustamante, B., & Cisternas (2016). Élites políticas en el poder legislativo chileno: La Cámara de Diputados (1990-2014). *Política, Revista de Ciencia Política, 54*(1), 19-52.
[^6]: For contributions related to cabinet data, see this [GitHub repository](https://github.com/bgonzalezbustamante/chilean-ministers/).
