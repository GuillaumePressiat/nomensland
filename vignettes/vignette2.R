## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(nomensland)

get_liste('chip')

## -----------------------------------------------------------------------------
library(nomensland)

get_liste('m4_inca_digestif')

## -----------------------------------------------------------------------------
objet <- get_all_listes('Recours Exceptionnel')

listviewer::jsonedit(objet, mode = "code")

## -----------------------------------------------------------------------------
dplyr::glimpse(get_dictionnaire_listes())

