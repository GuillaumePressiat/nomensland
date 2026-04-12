
#' ~ api : recuperer une table (referentiel)
#'
#' @examples
#' \dontrun{
#' get_table('dictionnaire_tables')
#' get_table('ccam_actes')
#' get_table('cim', 2016:2017)
#' get_table('tarifs_mco_ghs', 2015:2018)
#' }
#'
#' @param table Character. Nom de la table.
#' @param version Character. Version pour filtrer la table (ex: 2025).
#' @param def_url Character. Chemin vers les données du package.
#' Par défaut, utilise \code{path.package("nomensland")}.
#' Ce paramètre est principalement destiné à un usage interne
#' ou pour des environnements spécifiques.
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
        dplyr::filter(.data$time_i %in% as.character(version)) %>%
        dplyr::select(-.data$time_i)
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
#' @param nom_liste Character. Nom de la liste (abrégé).
#' @param def_url Character. Chemin vers les données du package.
#' Par défaut, utilise \code{path.package("nomensland")}.
#' Ce paramètre est principalement destiné à un usage interne
#' ou pour des environnements spécifiques.
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
#' @param theme Character. Nom de la thématique recherchée
#' (par exemple : \code{"Chirurgie bariatrique"}).
#'
#' @param def_url Character. Chemin vers les données du package.
#' Par défaut, utilise \code{path.package("nomensland")}.
#' Ce paramètre est principalement destiné à un usage interne
#' ou pour des environnements spécifiques.
#' 
#' @import magrittr jsonlite
#' @importFrom dplyr filter
#' @export
get_all_listes <- function(theme, def_url = path.package("nomensland")){
  get_dictionnaire_listes() %>%
    dplyr::filter(.data$thematique == theme) %>% dplyr::pull(.data$nom_abrege) -> l
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
#'
#' @param def_url Character. Chemin vers les données du package.
#' Par défaut, utilise \code{path.package("nomensland")}.
#' Ce paramètre est principalement destiné à un usage interne
#' ou pour des environnements spécifiques.
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
#'
#' @param def_url Character. Chemin vers les données du package.
#' Par défaut, utilise \code{path.package("nomensland")}.
#' Ce paramètre est principalement destiné à un usage interne
#' ou pour des environnements spécifiques.
#'
#' @author G. Pressiat
#' @import jsonlite dplyr
#' @export
get_dictionnaire_tables <- function(def_url = path.package("nomensland")){
  def_url %>%
    paste0('/tables/dictionnaire_tables.json.gz') %>%
    jsonlite::read_json(simplifyVector = TRUE) %>% 
    dplyr::distinct(.data$nom_table, .data$commentaire_table, .data$source_table, .data$version) %>% 
    dplyr::as_tibble()
}


#' @title  Explorer les tables avec shiny
#'
#' @description
#' Lance une application \pkg{shiny} permettant d'explorer de manière interactive
#' les tables de données du package \pkg{nomensland}. Cette interface
#' facilite la consultation, le filtrage et la visualisation des données.
#'
#' @param launch.browser Logical. Indique si l'application doit être ouverte
#' dans le navigateur web par défaut. Par défaut, utilise l'option globale
#' \code{shiny.launch.browser}, ou \code{interactive()} si celle-ci n'est pas définie.
#'
#' @details
#' Cette fonction localise le répertoire de l'application Shiny embarquée
#' dans le package \pkg{nomensland} puis la lance via \code{\link[shiny]{runApp}}.
#'
#' Si le répertoire de l'application ne peut pas être trouvé (par exemple
#' si le package est mal installé), une erreur est levée avec un message
#' invitant à réinstaller le package.
#'
#' @return
#' Retourne la valeur renvoyée par \code{\link[shiny]{runApp}}.
#'
#' @examples
#' \dontrun{
#' # Lancer l'application dans le navigateur
#' explore_nomensland()
#'
#' # Lancer sans ouvrir automatiquement le navigateur
#' explore_nomensland(launch.browser = FALSE)
#' }
#'
#' @seealso \link[shiny]{runApp}
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
