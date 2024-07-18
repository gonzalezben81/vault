# vault <a href="https://gonzalezben81.github.io/vault/"><img src="man/figures/logo.png" align="right" height="82" alt="vault website" /></a>
<!-- badges: start -->

[![License](https://img.shields.io/badge/License-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://github.com/gonzalezben81/vault/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gonzalezben81/vault/actions/workflows/R-CMD-check.yaml)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/gonzalezben81/vault/total)
![GitHub Release](https://img.shields.io/github/v/release/gonzalezben81/vault)

<!-- badges: end -->

## vault

The package **vault** allows you to work with HashiCorp Vault. Allowing you to interact with retrieving secrets in a secure manner. You can utilize github and aws roles in addition to native vault roles to interact with your secrets. Additionally you can wrap your secrets and provide a one time use token for sharing secrets with others.


### Install the latest development verison

For the latest development version use
```R
devtools::install_github("gonzalezben81/vault")
```


### Get data from vault

```r
library(vault)

get_vault_data(url = "vault-url.com",path = "secret-path",token=token)

```