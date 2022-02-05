## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Data Cleaning Code Chilean Elites Surveys
## R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
## Date: February 2022

## Bastián González-Bustamante (University of Oxford, UK)

## GitHub Repository
## github.com/bgonzalezbustamante/quant-mixed-methods-elites

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Packages and Data ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Clean Environment
rm(list = ls())

## Packages
library(foreign)
library(tidyverse)

## Data
elite_data <- read.spss("../secured-data/Elites-Survey-2010/BASE ÉLITES EN CHILE_FONDECYT.sav", to.data.frame = TRUE)
revision <- read.csv("../secured-data/Elites-Survey-2010/20140924-Joignant-Gonzalez-Bustamante.csv")

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### González-Bustamante and Garrido-Vergara Variables ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

table(elite_data$CARGOS[which(elite_data$J_GB == 1)])
table(elite_data$P24_REC[which(elite_data$J_GB == 1)])

test1 <- c("Cargos de Primera Línea", "Parlamentarios", "Jefe de Servicio", "Directorio o Gerencia de Empresa Pública")
test2 <- "Cargos de Gobierno de Primera Línea"

elite_data$father <- ifelse(elite_data$P33.1_REC1 == test1[1] | elite_data$P33.1_REC1 == test1[2] | elite_data$P33.1_REC1 == test1[3] | elite_data$P33.1_REC1 == test1[4], 1,
                            ifelse(elite_data$P33.1_REC2 == test1[1] | elite_data$P33.1_REC2 == test1[2] | elite_data$P33.1_REC2 == test1[3] | elite_data$P33.1_REC2 == test1[4], 1,
                                   ifelse(elite_data$P33.1_REC3 == test1[1] | elite_data$P33.1_REC3 == test1[2] | elite_data$P33.1_REC3 == test1[3] | elite_data$P33.1_REC3 == test1[4], 1,
                                          ifelse(elite_data$P33.1_REC4 == test1[1] | elite_data$P33.1_REC4 == test1[2] | elite_data$P33.1_REC4 == test1[3] | elite_data$P33.1_REC4 == test1[4], 1,
                                                 ifelse(elite_data$P33.1_REC5 == test1[1] | elite_data$P33.1_REC5 == test1[2] | elite_data$P33.1_REC5 == test1[3] | elite_data$P33.1_REC5 == test1[4], 1,
                                                        ifelse(elite_data$P33.1_REC6 == test1[1] | elite_data$P33.1_REC6 == test1[2] | elite_data$P33.1_REC6 == test1[3] | elite_data$P33.1_REC6 == test1[4], 1,
                                                               ifelse(elite_data$P33.1_REC7 == test1[1] | elite_data$P33.1_REC7 == test1[2] | elite_data$P33.1_REC7 == test1[3] | elite_data$P33.1_REC7 == test1[4], 1,
                                                                      ifelse(elite_data$P33.1_REC8 == test1[1] | elite_data$P33.1_REC8 == test1[2] | elite_data$P33.1_REC8 == test1[3] | elite_data$P33.1_REC8 == test1[4], 1, 0))))))))

elite_data$mother <- ifelse(elite_data$P33.2_REC1 == test2 | elite_data$P33.2_REC1 == test1[2] | elite_data$P33.2_REC1 == test1[3] | elite_data$P33.2_REC1 == test1[4], 1,
                            ifelse(elite_data$P33.2_REC2 == test2 | elite_data$P33.2_REC2 == test1[2] | elite_data$P33.2_REC2 == test1[3] | elite_data$P33.2_REC2 == test1[4], 1,
                                   ifelse(elite_data$P33.2_REC3 == test2 | elite_data$P33.2_REC3 == test1[2] | elite_data$P33.2_REC3 == test1[3] | elite_data$P33.2_REC3 == test1[4], 1,
                                          ifelse(elite_data$P33.2_REC4 == test2 | elite_data$P33.2_REC4 == test1[2] | elite_data$P33.2_REC4 == test1[3] | elite_data$P33.2_REC4 == test1[4], 1,
                                                 ifelse(elite_data$P33.2_REC5 == test2 | elite_data$P33.2_REC5 == test1[2] | elite_data$P33.2_REC5 == test1[3] | elite_data$P33.2_REC5 == test1[4], 1,
                                                        ifelse(elite_data$P33.2_REC6 == test2 | elite_data$P33.2_REC6 == test1[2] | elite_data$P33.2_REC6 == test1[3] | elite_data$P33.2_REC6 == test1[4], 1,
                                                               ifelse(elite_data$P33.2_REC7 == test2 | elite_data$P33.2_REC7 == test1[2] | elite_data$P33.2_REC7 == test1[3] | elite_data$P33.2_REC7 == test1[4], 1, 0)))))))

elite_data$father[is.na(elite_data$father)] <- 0
elite_data$mother[is.na(elite_data$mother)] <- 0
elite_data$parents <- ifelse(elite_data$father == 1, 1, ifelse(elite_data$mother == 1, 1, 0))
table(elite_data$parents[which(elite_data$J_GB == 1)])

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Joignant and González-Bustamante Corrections ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

elite_core <- select(revision, PRESIDENTE, MINISTRO, SENADOR, DIPUTADO, SUBSECRETARIO,
                     INTENDENTE, AUTORID..ECO..REG., JEFES.GAB..O.DIV., MIEMBROS.MESAS.DIR..PP)
elite_core <- cbind(id = rownames(elite_core), elite_core)
elite_data <- cbind(id = rownames(elite_data), elite_data)
elite_data <- left_join(elite_data, elite_core, by = "id")

## Check
sum(elite_data$J_GB - elite_data$MINISTRO)

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### CSV File ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

anonymised_data <- select(elite_data, id, Sexo, Año_nacimiento, CARGOS, P24_REC, parents,
                          father, mother, p5_1, p5_2, p5_3, p5_4, P6.1, P6.2, P6.3, P6.4,
                          P6.5, P6.6, P6.7, P6.8, P6.9, PRESIDENTE, MINISTRO, SENADOR,
                          DIPUTADO, SUBSECRETARIO, INTENDENTE, AUTORID..ECO..REG.,
                          JEFES.GAB..O.DIV., MIEMBROS.MESAS.DIR..PP)
names(anonymised_data)[2] = "sex"
names(anonymised_data)[3] = "dob"
names(anonymised_data)[4] = "political_capital"
names(anonymised_data)[5] = "education"
names(anonymised_data)[6] = "family_capital"
names(anonymised_data)[7] = "capital_father"
names(anonymised_data)[8] = "capital_mother"
names(anonymised_data)[9] = "party1"
names(anonymised_data)[10] = "party2"
names(anonymised_data)[11] = "party3"
names(anonymised_data)[12] = "party4"
names(anonymised_data)[13] = "t1"
names(anonymised_data)[14] = "t2"
names(anonymised_data)[15] = "t3"
names(anonymised_data)[16] = "t4"
names(anonymised_data)[17] = "t5"
names(anonymised_data)[18] = "t6"
names(anonymised_data)[19] = "t7"
names(anonymised_data)[20] = "t8"
names(anonymised_data)[21] = "t9"
names(anonymised_data)[22] = "president"
names(anonymised_data)[23] = "minister"
names(anonymised_data)[24] = "senator"
names(anonymised_data)[25] = "deputy"
names(anonymised_data)[26] = "undersecretary"
names(anonymised_data)[27] = "intendant"
names(anonymised_data)[28] = "ceo"
names(anonymised_data)[29] = "cabinet_chief"
names(anonymised_data)[30] = "party_leader"

## Save File
write.csv(anonymised_data, "data/tidy/elite_survey_2010.csv", fileEncoding = "UTF-8", row.names =  FALSE)
write.csv(anonymised_data, "../women-trajectories/data/tidy/elite_survey_2010.csv",
          fileEncoding = "UTF-8", row.names =  FALSE)
