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
library(performance)
library(pscl)
library(stargazer)
library(sjPlot)
library(ggplot2)

## Elite Survey Data
elite_data <- read.csv("data/tidy/elite_survey_2010.csv", header = T, sep = ",", encoding = "UTF-8")

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Re-Coding Variables ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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

elite_data$exp_business <- ifelse(elite_data$exp_business == "Sí", 1, 0)

elite_data$pol_cap[is.na(elite_data$pol_cap)] <- 0
elite_data$edu[is.na(elite_data$edu)] <- 0
elite_data$priv_school[is.na(elite_data$priv_school)] <- 0
elite_data$exp_business[is.na(elite_data$exp_business)] <- 0
elite_data$party_1[is.na(elite_data$party_1)] <- "Ninguno"
sum(table(elite_data$sex))
sum(table(elite_data$pol_cap))
sum(table(elite_data$edu))
sum(table(elite_data$family_capital))
sum(table(elite_data$priv_school))
sum(table(elite_data$exp_business))
sum(table(elite_data$party_1))

## Subsamples
length(which(elite_data$minister == 1 | elite_data$undersecretary == 1
             | elite_data$intendant == 1 | elite_data$ceo == 1
             | elite_data$cabinet_chief == 1))

length(which(elite_data$senator == 1 | elite_data$deputy == 1 | elite_data$party_leader == 1))
## 228 + 155

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Generalised Linear Models ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

model_1 <- glm(minister ~ exp_business + I(sex) + as.factor(pol_cap) + edu
               + priv_school + family_capital, data = elite_data, family = "binomial")

model_2 <- glm(senator ~ exp_business + I(sex) + as.factor(pol_cap) + edu
               + priv_school + family_capital, data = elite_data, family = "binomial")

model_3 <- glm(deputy ~ exp_business + I(sex) + as.factor(pol_cap) + edu
               + priv_school + family_capital, data = elite_data, family = "binomial")

## Check Multicollinearity
check_collinearity(model_1)
check_collinearity(model_2)
check_collinearity(model_3)

stargazer(model_1, model_2, model_3,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_01.html",
          title = "Regresiones logísticas con datos observacionales para posiciones políticas en Chile (1990-2010)",
          dep.var.labels = c("Gabinete", "Senado", "Cámara"), notes.align = "c", model.numbers = FALSE, omit = "party_1",
          column.labels = c("Modelo I","Modelo II","Modelo III"),
          add.lines = list(c("Matching", "No", "No", "No"),
                           c("Sub. Clustering", "No", "No", "No"),
                           c("Efectos fijos (partido)", "No", "No", "No"),
                           c("Submuestra", "No", "No", "No"),
                           c("VIF", "Bajo", "Bajo", "Bajo"),
                           c("Pseudo R2", format(round(unname(pR2(model_1)[6]), 3), nsmall = 3),
                             format(round(unname(pR2(model_2)[6]), 3), nsmall = 3),
                             format(round(unname(pR2(model_3)[6]), 3), nsmall = 3))),
          covariate.labels = c("Trayectoria empresarial", "Sexo (mujer)", "Capital político (dirigente local)",
                               "Capital político (dirigente regional)", "Capital político (dirigente nacional)",
                               "Nivel educacional", "Escuela secundaria privada", "Capital político familiar"))

model_4 <- glm(minister ~ exp_business + I(sex) + as.factor(pol_cap) + edu
               + priv_school + family_capital + I(party_1),
               data = subset(elite_data, elite_data$minister == 1 | elite_data$undersecretary == 1
                             | elite_data$intendant == 1 | elite_data$ceo == 1
                             | elite_data$cabinet_chief == 1), family = "binomial")

model_6 <- glm(senator ~ exp_business + I(sex) + as.factor(pol_cap) + edu
               + priv_school + family_capital + I(party_1),
               data = subset(elite_data, elite_data$senator == 1 | elite_data$deputy == 1
                             | elite_data$party_leader == 1), family = "binomial")

## Code PSA (under embargo)
source("../secured-data/qmm-elites/stage_2_psa_embargo.R", encoding = "UTF-8")

## Standardised and Absolute Mean Differences
png("results/figures/figure_01.png", width = (1024*2), height = (768*2), units = 'px', res = 300)
love.plot(m_out_1, stat = "mean.diffs", poly = 1, abs = TRUE,
          drop.distance = TRUE, thresholds = c(m = .1),
          var.order = "unadjusted",
          shapes = c("square filled", "triangle filled"),
          colors = c("black", "black"),
          var.names = loveplot_var_1,
          sample.names = c("Sin Matching", "Full Matching"),
          line = FALSE, stars = "none", title = NULL) + theme_minimal(base_size = 12) +
  theme(plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"), legend.title = element_blank()) + xlab("Gabinete")
dev.off()

## Standardised and Absolute Mean Differences
png("results/figures/figure_02.png", width = (1024*2), height = (768*2), units = 'px', res = 300)
love.plot(m_out_2, stat = "mean.diffs", poly = 1, abs = TRUE,
          drop.distance = TRUE, thresholds = c(m = .1),
          var.order = "unadjusted",
          shapes = c("square filled", "triangle filled"),
          colors = c("black", "black"),
          var.names = loveplot_var_2,
          sample.names = c("Sin Matching", "Full Matching"),
          line = FALSE, stars = "none", title = NULL) + theme_minimal(base_size = 12) +
  theme(plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"), legend.title = element_blank()) + xlab("Senado")
dev.off()

## Check Multicollinearity
check_collinearity(model_4)
check_collinearity(model_5)
check_collinearity(model_6)
check_collinearity(model_7)

stargazer(model_4, model_5, model_6, model_7,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_02.html",
          title = "Regresiones logísticas y modelos de resultados después del matching para posiciones políticas en Chile (1990-2010)",
          se = list(NULL, m5_cluster_robust_se[,2], NULL, m7_cluster_robust_se[,2]),
          dep.var.labels = c("Gabinete", "Senado"), notes.align = "c", model.numbers = FALSE, omit = "party_1",
          column.labels = c("Modelo IV","Modelo V","Modelo VI", "Modelo VII"),
          add.lines = list(c("Matching", "No", "Full", "No", "Full"),
                           c("Sub. Clustering", "No", "Sí", "No", "Sí"),
                           c("Efectos fijos (partido)", "Sí", "PSA", "Sí", "PSA"),
                           c("Submuestra", "Sí", "Sí", "Sí", "Sí"),
                           c("VIF", "Bajo", "Bajo", "Bajo", "Bajo"),
                           c("Pseudo R2", format(round(unname(pR2(model_4)[6]), 3), nsmall = 3),
                             "--", format(round(unname(pR2(model_6)[6]), 3), nsmall = 3), "--")),
          covariate.labels = c("Trayectoria empresarial", "Sexo (mujer)", "Capital político (dirigente local)",
                               "Capital político (dirigente regional)", "Capital político (dirigente nacional)",
                               "Nivel educacional", "Escuela secundaria privada", "Capital político familiar"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Effects Plots ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

plot_model(model_1, type = "pred", terms = c("edu")) +
  theme_classic() + coord_cartesian(expand = TRUE, ylim = c(0, 1)) +
  labs(x = "\nNivel educacional", y = "Probabilidad predicha", caption = "") +
  ggtitle("") +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        panel.background = element_blank(),
        axis.line = element_blank()) +
  scale_x_continuous(breaks = c(0, 0.33, 0.67, 1),
                     labels = c("Secundaria", "Universitaria", "Magíster", "Doct."))
ggsave("results/figures/figure_03.jpg", width = 4, height = 4, units = "in")

plot_model(model_4, type = "pred", terms = c("edu")) +
  theme_classic() + coord_cartesian(expand = TRUE, ylim = c(0, 1)) +
  labs(x = "\nNivel educacional", y = "Probabilidad predicha", caption = "") +
  ggtitle("") +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        panel.background = element_blank(),
        axis.line = element_blank()) +
  scale_x_continuous(breaks = c(0, 0.33, 0.67, 1),
                     labels = c("Secundaria", "Universitaria", "Magíster", "Doct."))
ggsave("results/figures/figure_04.jpg", width = 4, height = 4, units = "in")

plot_model(model_5, type = "pred", terms = c("edu"), se = m5_cluster_robust_se[,2]) +
  theme_classic() + coord_cartesian(expand = TRUE, ylim = c(0, 1)) +
  labs(x = "\nNivel educacional", y = "Probabilidad predicha", caption = "") +
  ggtitle("") +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        panel.background = element_blank(),
        axis.line = element_blank()) +
  scale_x_continuous(breaks = c(0, 0.33, 0.67, 1),
                     labels = c("Secundaria", "Universitaria", "Magíster", "Doct."))
ggsave("results/figures/figure_05.jpg", width = 4, height = 4, units = "in")
