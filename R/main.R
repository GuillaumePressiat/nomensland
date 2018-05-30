
#' ~ api : recuperer une table (referentiel)
#'
#'
#' @examples
#' \dontrun{
#' get_table('dictionnaire_tables')
#' get_table('ccam_actes')
#' }
#'
#' @author G. Pressiat
#' @import magrittr jsonlite tibble
#' @export
# }
get_table <- function(table, def_url = path.package("nomensland")){
  tibble::as_tibble(def_url %>%
    paste0('/tables/', table, '.json.gz') %>%
    jsonlite::read_json(simplifyVector = TRUE))
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
  get_dictionnaire() %>%
    filter(thematique == theme) %>% .$nom_abrege -> l
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
    dplyr::distinct(nom_table, commentaire_tables, source_table, version) %>% 
    dplyr::as_tibble()
}
