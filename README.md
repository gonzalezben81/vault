# vault <img src="man/figures/vault.png" align="right" style="width: 200px; height: 150px;"/>
<!-- badges: start -->

[![License](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://github.com/gonzalezben81/vault/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gonzalezben81/vault/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## vault

The package **vault** allows you to work with Hashicorp Vault. Allowing you to interact with retrieving secrets in a secure manner. You can utilize github and aws roles in addition to native vault roles to interact with your secrets. Additionally you can wrap your secrets and provide a one time use token for sharing secrets with others.


### Get data from vault

```r
library(vault)

get_vault_data("vault.url.com",secret,token=token)
```