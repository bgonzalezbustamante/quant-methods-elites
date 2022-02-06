## Draft Code
## Bastián González-Bustamante
## February 2022

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
                                        ifelse(elite_data$senator == 1, 1,
                                               ifelse(elite_data$deputy == 1, 1, 0)))

table(elite_data$outstanding_career[which(elite_data$sex == "Hombre")])
218 / (218+104)
table(elite_data$outstanding_career[which(elite_data$sex == "Mujer")])
39 / (39+25)

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

elite_data$pol_cap[is.na(elite_data$pol_cap)] <- 0
elite_data$edu[is.na(elite_data$edu)] <- 0
sum(table(elite_data$sex))
sum(table(elite_data$pol_cap))
sum(table(elite_data$edu))
sum(table(elite_data$family_capital))
sum(table(elite_data$capital_father))
sum(table(elite_data$capital_mother))

elite_data$executive <- ifelse(elite_data$minister == 1, 1,
                               ifelse(elite_data$undersecretary == 1, 1, 0))
elite_data$legislative <- ifelse(elite_data$senator == 1, 1,
                                 ifelse(elite_data$deputy == 1, 1, 0))

## Subsamples
length(which(elite_data$minister == 1 | elite_data$undersecretary == 1
             | elite_data$intendant == 1 | elite_data$ceo == 1
             | elite_data$cabinet_chief == 1))

length(which(elite_data$senator == 1 | elite_data$deputy == 1 | elite_data$party_leader == 1))

228 + 155

## GLMs

model_1 <- glm(executive ~ I(sex) + as.factor(pol_cap) + edu
               + as.factor(family_capital), data = elite_data, family = "binomial")

model_2 <- glm(executive ~ I(sex) + as.factor(pol_cap) + edu
               + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_3 <- glm(executive ~ I(sex) * edu + as.factor(pol_cap)
               + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_4 <- glm(legislative ~ I(sex) + as.factor(pol_cap) + edu
               + as.factor(family_capital), data = elite_data, family = "binomial")

model_5 <- glm(legislative ~ I(sex) + as.factor(pol_cap) + edu
               + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_6 <- glm(legislative ~ I(sex) * edu + as.factor(pol_cap)
               + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

stargazer(model_1, model_2, model_3, model_4, model_5, model_6,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_02.html",
          title = "Determinantes de carrera destacada  (Modelos lineales generalizados)",
          dep.var.labels = c("Ministros/subsecretarios", "Senadores/Diputados"),
          notes.align = "c", model.numbers = FALSE, omit = "party1",
          column.labels = c("Modelo I","Modelo II","Modelo III", "Modelo IV", "Modelo V", "Modelo VI"),
          add.lines = list(c("Efectos fijos (partido)", "No", "Sí", "Sí", "No", "Sí", "Sí", "Sí"),
                           c("Pseudo R2", format(round(unname(pscl::pR2(model_1)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_2)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_3)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_4)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_5)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_6)[6]), 3), nsmall = 3))),
          covariate.labels = c("Sexo (mujer)", "Capital político (líder local)",
                               "Capital político (líder regional)", "Capital político (líder nacional)",
                               "Nivel educational", "Capital familiar heredado",
                               "Mujer x Nivel educacional"))

model_1b <- glm(minister ~ I(sex) + as.factor(pol_cap) + edu
                + as.factor(family_capital), data = elite_data, family = "binomial")

model_2b <- glm(minister ~ I(sex) + as.factor(pol_cap) + edu
                + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_3b <- glm(minister ~ I(sex) * edu + as.factor(pol_cap)
                + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_4b <- glm(senator ~ I(sex) + as.factor(pol_cap) + edu
                + as.factor(family_capital), data = elite_data, family = "binomial")

model_5b <- glm(senator ~ I(sex) + as.factor(pol_cap) + edu
                + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

model_6b <- glm(senator ~ I(sex) * edu + as.factor(pol_cap)
                + as.factor(family_capital) + I(party1), data = elite_data, family = "binomial")

stargazer(model_1b, model_2b, model_3b, model_4b, model_5b, model_6b,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_02b.html",
          title = "Determinantes de carrera destacada  (Modelos lineales generalizados)",
          dep.var.labels = c("Ministros/subsecretarios", "Senadores/Diputados"),
          notes.align = "c", model.numbers = FALSE, omit = "party1",
          column.labels = c("Modelo I","Modelo II","Modelo III", "Modelo IV", "Modelo V", "Modelo VI"),
          add.lines = list(c("Efectos fijos (partido)", "No", "Sí", "Sí", "No", "Sí", "Sí", "Sí"),
                           c("Pseudo R2", format(round(unname(pscl::pR2(model_1b)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_2b)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_3b)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_4b)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_5b)[6]), 3), nsmall = 3),
                             format(round(unname(pscl::pR2(model_6b)[6]), 3), nsmall = 3))),
          covariate.labels = c("Sexo (mujer)", "Capital político (líder local)",
                               "Capital político (líder regional)", "Capital político (líder nacional)",
                               "Nivel educational", "Capital familiar heredado",
                               "Mujer x Nivel educacional"))
