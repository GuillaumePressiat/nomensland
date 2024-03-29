
library(shiny)
library(nomensland)
library(dplyr, warn.conflicts = FALSE)

liste_table <- get_table('dictionnaire_tables') %>% 
  distinct(nom_table, commentaire_table)

shiny::shinyUI(shiny::fluidPage(
  sidebarLayout(
    sidebarPanel(width = 3,
                 selectInput("tab", "Choisir une table :",
                             list(`CCAM` = liste_table$nom_table %>% .[grepl('ccam_', .)],
                                  `NGAP` = 'ngap_norme_b2_code_prestation',
                                  `CIM` =  liste_table$nom_table %>% .[grepl('cim', .)],
                                  `CSARR` = liste_table$nom_table %>% .[grepl('csarr_', .)],
                                  `MO, ATU et DMI` = liste_table$nom_table %>% .[grepl('mco_medref_|mco_dmiref_', .)],
                                  `GHM` = liste_table$nom_table %>% .[grepl('ghm_', .)],
                                  `tarifs` = liste_table$nom_table %>% .[grepl('^tarifs_', .)],
                                  `LPP` = liste_table$nom_table %>% .[grepl('lpp_', .)],
                                  `lib (et autres)` = liste_table$nom_table %>% .[grepl('lib_|dictio', .)]), 
                             multiple = FALSE, size = 13, selectize = FALSE, #width = '230px'
                 ),
                 
                 radioButtons("filetype", "Choisir le type :",
                              choices = c("csv", "tsv", "xlsx")),
                 downloadButton('downloadData', 'Télécharger')),
    
    mainPanel(width = 9,
              h5(textOutput('titre_table')),
              DT::dataTableOutput("result"))
    
  )))
