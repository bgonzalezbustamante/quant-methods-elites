## Draft Code
## Bastián González-Bustamante
## February 2022

## Testing QCA
library(tidyverse)
library(QCA)

women_data <- filter(elite_data, sex == "Mujer")
qca_women <- select(women_data, outstanding_career, political_capital, education, family_capital)
qca_women[is.na(qca_women)] <- 0

cs_table <- truthTable(qca_women, outcome = "outstanding_career", show.cases = FALSE)
ttable1

21*0.476
which(qca_women$political_capital == 0 & qca_women$education == 0 & qca_women$family_capital == 0 & qca_women$outstanding_career == 1)
