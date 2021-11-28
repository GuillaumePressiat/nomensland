<!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![https://guillaumepressiat.r-universe.dev/badges/nomensland](https://guillaumepressiat.r-universe.dev/badges/nomensland)](https://guillaumepressiat.r-universe.dev/ui#builds)
<!-- badges: end -->


# nomensland

Package contenant des nomenclatures et classifications pour le PMSI

Voir les vignettes (onglet articles / dossier vignettes) pour plus parlant.


Un exemple d'utilisation en python est également disponible [ici](https://github.com/GuillaumePressiat/nomensland/tree/master/python) (ce n'est qu'un début).


## Installation du package



### Depuis r-universe (CRAN-like pre-build)

Le plus simple pour installer nomensland est de lancer directement :

```r
install.packages('nomensland', repos = 'https://guillaumepressiat.r-universe.dev')
```

Cf [guillaumepressiat.r-universe](https://guillaumepressiat.r-universe.dev/ui#builds).


### Depuis github avec remotes

```r
# install.packages('remotes')
library(remotes)
install_github('guillaumepressiat/nomensland')
```

Cette commande lance l'installation du package et de ses dépendances.

### Installation derrière un proxy

Souvent, les établissements hospitaliers ont mis en place un proxy qui empèche l'installation pratique d'un package sur github.
Voici comment faire dans ce cas.

```r
# install.packages('httr')
library(httr)
set_config( use_proxy(
    url = "proxy_url",    # Remplacer proxy_url par l'URL de votre proxy
    port = 8080,
    username = "user",    # Remplacer user par votre nom d'utilisateur du proxy
    password = "password" #Remplacer password par votre nom d'utilisateur du proxy
))

# install.packages('remotes')
library(remotes)
install_github('guillaumepressiat/nomensland')
```
