
#' ~ api : recuperer une table (referentiel)
#'
#'
#' @examples
#' \dontrun{
#' get_table('dictionnaire_tables')
#' get_table('ccam_actes')
#' get_table('cim', 2016:2017)
#' get_table('tarifs_mco_ghs', 2015:2018)
#' }
#'
#' @author G. Pressiat
#' @import magrittr jsonlite tibble
#' @export
# }
get_table <- function(table, version = '', def_url = path.package("nomensland")){
  v <- function(one){
    if (FALSE || one == ''){
      u <-   tibble::as_tibble(def_url %>%
                                 paste0('/tables/', table, '.json.gz') %>%
                                 jsonlite::read_json(simplifyVector = TRUE))
    } else {
      u <-   tibble::as_tibble(def_url %>%
                                 paste0('/tables/', table, '.json.gz') %>%
                                 jsonlite::read_json(simplifyVector = TRUE)) %>% 
        dplyr::filter(time_i %in% as.character(version)) %>%
        dplyr::select(-time_i)
    }
    return(u)
  }
  return(v(version))

}

#' ~ api : recuperer une liste
#'
#'
#' @examples
#' \dontrun{
#' get_liste('chip')
#' }
#'
#' @author G. Pressiat
#' @import magrittr jsonlite
#' @export
get_liste <- function(nom_liste, def_url = path.package("nomensland")){
  def_url %>%
    paste0('/listes/',  nom_liste, '.json') %>%
    jsonlite::fromJSON(simplifyVector = TRUE)
}

#' ~ api : recuperer toutes les listes sur une thematique
#'
#'
#' @examples
#' \dontrun{
#' get_all_listes("Chirurgie bariatrique")
#' get_all_listes("Recours Exceptionnel")
#' }
#'
#' @import magrittr jsonlite
#' @importFrom dplyr filter
#' @export
get_all_listes <- function(theme, def_url = path.package("nomensland")){
  get_dictionnaire_listes() %>%
    dplyr::filter(thematique == theme) %>% .$nom_abrege -> l
  lapply(l, get_liste)
}

#' ~ api : recuperer le dictionnaire des listes
#'
#'
#' @examples
#' \dontrun{
#' get_dictionnaire_listes()
#' }
#'
#' @author G. Pressiat
#' @importFrom magrittr "%>%"
#' @import jsonlite
#' @export
get_dictionnaire_listes <- function(def_url = path.package("nomensland")){
  def_url %>%
    paste0('/dictionnaire.json') %>%
    jsonlite::read_json(simplifyVector = TRUE) %>% 
    dplyr::as_tibble()
}

#' ~ api : avoir le dictionnaire des referentiels
#'
#'
#' @examples
#' \dontrun{
#' get_dictionnaire_tables()
#' }
#'
#' @author G. Pressiat
#' @import jsonlite dplyr
#' @export
get_dictionnaire_tables <- function(def_url = path.package("nomensland")){
  def_url %>%
    paste0('/tables/dictionnaire_tables.json.gz') %>%
    jsonlite::read_json(simplifyVector = TRUE) %>% 
    dplyr::distinct(nom_table, commentaire_table, source_table, version) %>% 
    dplyr::as_tibble()
}


#' @title  Explorer les tables avec shiny
#'
#' @export
explore_nomensland <- function(launch.browser = getOption("shiny.launch.browser", interactive())) {
  appDir <- system.file("explore_nomensland", "explore_nomensland", package = "nomensland")
  if (appDir == "") {
    # https://deanattali.com/2015/04/21/r-package-shiny-app/
    stop("Could not find explore_nomensland directory. Try re-installing nomensland.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal", launch.browser = launch.browser)
}
