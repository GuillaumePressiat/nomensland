## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)


library(nomensland)

ccam <- get_table('ccam_actes')
dplyr::glimpse(ccam)

## -----------------------------------------------------------------------------
library(nomensland)

cim_21 <- get_table('cim', '2021')
dplyr::glimpse(cim_21)

## -----------------------------------------------------------------------------
library(nomensland)

ghm_rgp <- get_table('ghm_ghm_regroupement')
dplyr::glimpse(ghm_rgp)

## -----------------------------------------------------------------------------
library(nomensland)

ghs <- get_table('tarifs_mco_ghs')
dplyr::glimpse(ghs)

## -----------------------------------------------------------------------------
library(nomensland)
get_table('dictionnaire_tables') -> dico

DT::datatable(dplyr::distinct(dico, nom_table, commentaire_table, anseqta, version) %>% 
                select(nom_table, commentaire_table, anseqta, version) %>% 
                dplyr::arrange(nom_table), 
              escape = F, rownames = F, options = list(pageLength = 50))


## ----eval = FALSE-------------------------------------------------------------
#  library(nomensland)
#  explore_nomensland()

