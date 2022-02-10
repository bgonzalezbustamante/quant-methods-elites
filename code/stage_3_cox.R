## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Proportional Hazards Models Code QMM Studying Elites
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
library(survival)
library(performance)
library(stargazer)
library(sjPlot)
library(ggplot2)

## GitHub Repository
github_1 <- "https://raw.githubusercontent.com/"
github_2 <- "bgonzalezbustamante/chilean-ministers/main/data/"

## Chilean Ministers Data
chilean_ministers <- read.csv(paste(github_1, github_2, "Chilean_cabinets_1990_2014.csv", sep = ""),
                              header = T, sep = ",", encoding = "UTF-8")

chilean_ministers$prestige <- ifelse(chilean_ministers$economist == 1, 1,
                                     ifelse(chilean_ministers$lawyer == 1, 1, 0))

sum(table(chilean_ministers$exp_business))
sum(table(chilean_ministers$sex))
sum(table(chilean_ministers$party_leader))
sum(table(chilean_ministers$prestige))
sum(table(chilean_ministers$political_kinship))

## Time Variables
chilean_ministers$time_minister <- with(chilean_ministers, (as.Date(chilean_ministers$end_minister)
                                                   - as.Date(chilean_ministers$start_minister)))

chilean_ministers$time_minister <- as.numeric(chilean_ministers$time_minister)

chilean_ministers$time_president <- with(chilean_ministers, (as.Date(chilean_ministers$end_president)
                                                   - as.Date(chilean_ministers$start_president)))

chilean_ministers$time_president <- as.numeric(chilean_ministers$time_president)

chilean_ministers$prop_term <- chilean_ministers$time_minister / chilean_ministers$time_president

## Event Variables
chilean_ministers$exit <- ifelse(chilean_ministers$end_minister < chilean_ministers$end_president, 1, 0)

chilean_ministers$t75 <- ifelse(chilean_ministers$prop_term >= 0.75, 1, 0)

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Cox Proportional Hazards Models ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cox_1 <- coxph(Surv(time_minister, t75 == 1) ~ exp_business + I(sex) + non_party + party_leader
               + prestige + political_kinship, ties = "breslow", data = chilean_ministers)

cox_2 <- coxph(Surv(time_minister, exit == 1) ~ exp_business + I(sex) + non_party + party_leader
               + prestige + political_kinship + I(president), ties = "efron", data = chilean_ministers)

## Code PSA (under embargo)
source("../secured-data/qmm-elites/stage_3_psa_embargo.R", encoding = "UTF-8")

## Standardised and Absolute Mean Differences
png("results/figures/figure_02.png", width = (1024*2), height = (768*2), units = 'px', res = 300)
love.plot(c_out_1, stat = "mean.diffs", poly = 1, abs = TRUE,
          drop.distance = TRUE, thresholds = c(m = .1),
          var.order = "unadjusted",
          shapes = c("square filled", "triangle filled"),
          colors = c("black", "black"),
          var.names = loveplot_var_3,
          sample.names = c("Sin Matching", "Full Matching"),
          line = FALSE, stars = "none", title = NULL) + theme_minimal(base_size = 12) +
  theme(plot.margin = unit(c(0.5,0.5,0.5,0.5), "cm"), legend.title = element_blank()) + xlab("Gabinete")
dev.off()

## Check Multicollinearity
performance::check_collinearity(cox_1)
performance::check_collinearity(cox_2)

## PHA Test
res.zph1 <- cox.zph(cox_1)
res.zph2 <- cox.zph(cox_2)
res.zph3 <- cox.zph(cox_3)

stargazer(cox_1, cox_2, cox_3,
          type = "html", header = FALSE, style = "ajps", out = "results/tables/table_03.html",
          title = "Modelos de riesgos proporcionales de Cox y resultados después del matching para salidas del gabinete en Chile (1990-2010)",
          dep.var.labels = c("Umbral 75%", "Salida censurada"), notes.align = "c",
          model.numbers = FALSE, omit = "president",
          column.labels = c("Modelo VIII","Modelo IX","Modelo X"),
          omit.stat = c("rsq", "max.rsq", "wald", "lr", "logrank"),
          add.lines = list(c("Matching", "No", "No", "Full"),
                           c("Sub. Clustering", "No", "No", "Sí"),
                           c("Efectos fijos (gobierno)", "No", "Sí", "PSA"),
                           c("Submuestra", "No", "No", "No"),
                           c("PHA", round(res.zph1$table[7,3], 3), round(res.zph2$table[8,3], 3),
                             round(res.zph3$table[2,3], 3)),
                           c("VIF", "Bajo", "Bajo", "Bajo"),
                           c("AIC", round(extractAIC(cox_1)[2], 3),
                             round(extractAIC(cox_2)[2], 3), round(extractAIC(cox_2)[2], 3)),
                           c("C-Index", round(cox_1$concordance[6], 3),
                             round(cox_2$concordance[6], 3), round(cox_3$concordance[6], 3)),
                           c("Eventos", cox_1$nevent, cox_2$nevent, cox_3$nevent)),
          covariate.labels = c("Trayectoria empresarial", "Sexo (mujer)", "Independencia política",
                               "Dirigente de partido", "Profesión de prestigio", "Capital político familiar"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### HR Plot ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

plot_model(cox_3_plot, type = "pred", terms = c("exp_business")) +
  theme_classic() + coord_cartesian(expand = TRUE, ylim = c(0, 1)) +
  labs(x = "\nTrayectoria empresarial", y = "Coeficiente de riesgo", caption = "") +
  ggtitle("") +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        panel.background = element_blank(),
        axis.line = element_blank()) +
  scale_x_continuous(breaks = c(0, 1),
                     labels = c("No posee", "Posee"))
ggsave("results/figures/figure_04.jpg", width = 4, height = 4, units = "in")
