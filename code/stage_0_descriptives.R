## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Revision Chamber of Deputies Code
## R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
## Date: February 2022

## Bastián González-Bustamante (University of Oxford, UK)
## https://bgonzalezbustamante.com

## GitHub Repository
## github.com/bgonzalezbustamante/quant-mixed-methods-elites
## DOI: 10.5281/zenodo.6098061

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Packages and Data ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Clean Environment
rm(list = ls())

## Packages
library(tidyverse)

## Data
chamber_1990 <- read.csv("data/raw/chamber_1990_1994.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_1990)[1] = "name"
chamber_1994 <- read.csv("data/raw/chamber_1994_1998.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_1994)[1] = "name"
chamber_1998 <- read.csv("data/raw/chamber_1998_2002.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_1998)[1] = "name"
chamber_2002 <- read.csv("data/raw/chamber_2002_2006.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_2002)[1] = "name"
chamber_2006 <- read.csv("data/raw/chamber_2006_2010.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_2006)[1] = "name"
chamber_2010 <- read.csv("data/raw/chamber_2010_2014.csv", header = T, sep = ",", encoding = "UTF-8")
names(chamber_2010)[1] = "name"

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Packages and Data ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

period_1990_2014 <- bind_rows(chamber_1990, chamber_1994, chamber_1998, chamber_2002,
                              chamber_2006, chamber_2010, id. = NULL)

nrow(period_1990_2014) - unname(table(duplicated(period_1990_2014))[2])

period_1990_2010 <- bind_rows(chamber_1990, chamber_1994, chamber_1998, chamber_2002,
                              chamber_2006, id. = NULL)

nrow(period_1990_2010) - unname(table(duplicated(period_1990_2010))[2])

survey_chamber <- 123

(survey_chamber / (nrow(period_1990_2010) - unname(table(duplicated(period_1990_2010))[2]))) * 100
