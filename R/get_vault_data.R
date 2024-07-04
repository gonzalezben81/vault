# get_data_vault
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
#' Vault: Gets the Vault Data
#' 
#' @description
#' This function gets "secrets" or "data" from the vault instance and returns them inside a dataframe.
#' You will need the HashiCorp Vault URL you are using including the full path to the secret e.g. my/secrets
#' and lastly you will need a token that allows you to interact with Vault via the API.
#' 
#'
#' @param url URL of the HashiCorp Vault instance.
#' @param token token for the vault instance.
#' @param path path to the secret in the vault instance. The ?version=2 can be removed and the most recent version of the secret will be returned. An user can specify a specific version of a secret as needed.
#' @param dataframe whether to return the secret data via a dataframe. The default is "N"
#' @keywords get_vault_data
#' @return Return's the data or secrets that are in the vault instance.
#' @name get_vault_data
#' @title get_vault_data
#' @import httr
#' @import jsonlite
#' @examples
#'
#' \dontrun{  get_vault_data(url = "https://vault-url.com",path = "data?version=2",token = "hvs.token",dataframe="N")
#'
#' }
#'
#' @export


get_vault_data <- function(url=NULL,path=NULL,token=NULL,dataframe="N"){

  ###URL of the HashiCorp Vault instance
  url <- url
  ###Token from the HashiCorp Vault user
  token <- token
  ###Path to the HashiCorp Vault secrets
  path <- path
  ###Pastes the url and path and creates the path through /v1/secret/data is used for kv version 2
  ###v2 allows you to keep several versions of secrets in Vault
  ###Vault API Reference:https://developer.HashiCorp.com/vault/api-docs/secret/kv/kv-v2
  complete_url<- paste0(url,'/v1/secret/data/',path)

  ###Gets the data from the HashiCorp Vault path
  res<- httr::GET(complete_url, httr::add_headers('X-Vault-Token' = token),httr::verbose())
  ###Gets the data from the JSON format
  res<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"),httr::verbose())
  ###Puts the data into a data frame
  if(dataframe=="Y"){
  res<- as.data.frame(res$data$data)
  }else{
  res
  }

  return(res)
}






