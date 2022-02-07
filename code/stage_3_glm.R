## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## GLMs Code QMM Studying Elites
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
library(stargazer)

## Elite Survey Data
elite_data <- read.csv("data/tidy/elite_survey_2010.csv", header = T, sep = ",", encoding = "UTF-8")

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Re-Coding Variables ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

elite_data$outstanding_career <- ifelse(elite_data$minister == 1, 1,
                                        ifelse(elite_data$senator == 1, 1, 0))

elite_data$pol_cap <- ifelse(elite_data$political_capital == "Nacional", 1,
                             ifelse(elite_data$political_capital == "Regional", 0.67,
                                    ifelse(elite_data$political_capital == "Local", 0.33, 0)))

elite_data$edu <- ifelse(elite_data$education == "Titulado de Doctor", 1,
                         ifelse(elite_data$education == "Candidato a Doctor", 0.84,
                                ifelse(elite_data$education == "Titulado de Magíster", 0.67,
                                       ifelse(elite_data$education == "Estudios de Postgrado", 0.5,
                                              ifelse(elite_data$education == "Universitaria completa", 0.33,
                                                     ifelse(elite_data$education == "Universitaria o técnica sin título", 0.16,
                                                            ifelse(elite_data$education == "Técnica completa", 0.16, 0)))))))

elite_data$priv_school <- ifelse(elite_data$school == "Privado pagado religioso", 1,
                                 ifelse(elite_data$school == "Privado pagado no religioso", 1, 0))

elite_data$pol_cap[is.na(elite_data$pol_cap)] <- 0
elite_data$edu[is.na(elite_data$edu)] <- 0
elite_data$exp_business[is.na(elite_data$exp_business)] <- 0
elite_data$priv_school[is.na(elite_data$priv_school)] <- 0
elite_data$party_1[is.na(elite_data$party_1)] <- "Ninguno"
sum(table(elite_data$sex))
sum(table(elite_data$pol_cap))
sum(table(elite_data$edu))
sum(table(elite_data$family_capital))
sum(table(elite_data$exp_business))
sum(table(elite_data$priv_school))
sum(table(elite_data$party_1))

## elite_data$executive <- ifelse(elite_data$minister == 1, 1,
                               ## ifelse(elite_data$undersecretary == 1, 1, 0))
## elite_data$legislative <- ifelse(elite_data$senator == 1, 1,
                                 ## ifelse(elite_data$deputy == 1, 1, 0))

## Subsamples
length(which(elite_data$minister == 1 | elite_data$undersecretary == 1
             | elite_data$intendant == 1 | elite_data$ceo == 1
             | elite_data$cabinet_chief == 1))

length(which(elite_data$senator == 1 | elite_data$deputy == 1 | elite_data$party_leader == 1))
## 228 + 155

## GLMs

model_1 <- glm(minister ~ I(exp_business == "Sí") + I(sex) + as.factor(pol_cap) + edu
               + priv_school + as.factor(family_capital), data = elite_data, family = "binomial")

model_2 <- glm(senator ~ I(exp_business == "Sí") + I(sex) + as.factor(pol_cap) + edu
               + priv_school + as.factor(family_capital), data = elite_data, family = "binomial")

model_3 <- glm(deputy ~ I(exp_business == "Sí") + I(sex) + as.factor(pol_cap) + edu
               + priv_school + as.factor(family_capital), data = elite_data, family = "binomial")

stargazer(model_1, model_2, model_3,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_01.html",
          title = "Determinantes de carrera destacada  (Modelos lineales generalizados)")

model_4 <- glm(minister ~ I(exp_business == "Sí") + I(sex) + as.factor(pol_cap) + edu
               + priv_school + as.factor(family_capital) + I(party_1),
               data = subset(elite_data, elite_data$minister == 1 | elite_data$undersecretary == 1
                             | elite_data$intendant == 1 | elite_data$ceo == 1
                             | elite_data$cabinet_chief == 1), family = "binomial")

model_5 <- glm(senator ~ I(exp_business == "Sí") + I(sex) + as.factor(pol_cap) + edu
               + priv_school + as.factor(family_capital) + I(party_1),
               data = subset(elite_data, elite_data$senator == 1 | elite_data$deputy == 1
                             | elite_data$party_leader == 1), family = "binomial")

## Model 6 and 7 after matching (WIP)

stargazer(model_4, model_5,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_02.html",
          title = "Determinantes de carrera destacada  (Modelos lineales generalizados)",
          ## dep.var.labels = c("Ministros/subsecretarios", "Senadores/Diputados"),
          notes.align = "c", model.numbers = TRUE, omit = "party_1")

## Check full stargazer traj. code (WIP)
