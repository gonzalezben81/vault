#wrap_secrets
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#' Vault: Gets the approle token from Vault.
#'
#' This function wraps secrets via the wrap endpoint in Vault. The function returns a single use token that can be utilized once to retrieve the secrets.
#' [Vault Wrap Token API](https://developer.hashicorp.com/vault/api-docs/system/wrapping-wrap)
#' [Vault Wrapping Overview](https://developer.hashicorp.com/vault/docs/concepts/response-wrapping)
#' @param url URL of the Hashicorp Vault instance.
#' @param token The token used to wrap the secrets in Vault via the wrapping utility.
#' @param secrets_to_wrap The secrets you want to wrap via the Vault wrapping utility.
#' @param ttl Time to live or ttl, refers to the time a token is able to be used to unwrap the wrapped secrets in Vault.
#' @keywords get_approle_token
#' @return Return's the wrap token that is used to unwrap the secrets in Vault.
#' @name wrap_secrets
#' @title wrap_secrets
#' @import httr
#' @import jsonlite
#' 
#' @examples
#'
#' \dontrun{  wrap_secrets(url,token,secrets_to_wrap,ttl)
#'
#' }
#'
#' @export

wrap_secrets <- function(url=NULL,token=NULL,secrets_to_wrap=NULL,ttl='30m'){
  ###url of the Hashicorp Vault instance
  url <- url
  ###Time to Live for the wrap token that is returned from Vault
  ttl <- ttl
  ###Secrets to be wrap in Vault.
  data_to_wrap<- jsonlite::toJSON(secrets_to_wrap)
  ###Pastes the url and the wrap path in Vault
  complete_url<- paste0(url,'/v1/sys/wrapping/wrap')
  print(complete_url)
  ###Posts the data for a return of the wrap token to unwrap the secrets from Vault
  res <- httr::POST(complete_url,httr::add_headers('X-Vault-Token' = token,"X-Vault-Wrap-TTL"=ttl), body = data_to_wrap, encode = "json",httr::verbose())
  ###Get the token that was used to wrap the secrets in Vault
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  ###Returns the wrap token used in the unwrap portion of Vault
  return(results$wrap_info$token)
}
