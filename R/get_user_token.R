#get_user_token
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
#' This function gets the user token from Vault for the user name registered in your Vault instance registered at the auth/userpass path. 
#'
#' @param url URL of the HashiCorp Vault instance.
#' @param user username registered in Vault.
#' @param pass password for username registered in Vault
#' @keywords get_token
#' @return Return's the user token that allows an individual to query secrets in Vault. 
#' @name get_user_token
#' @title get_user_token
#' @import httr
#' @import jsonlite
#' @examples
#'
#' \dontrun{  get_user_token(url,user,pass)
#'
#' }
#'
#' @export

get_user_token <- function(url,user,pass){
  ###URL of the HashiCorp Vault instance
  url <- url
  ###Username to authenticate against the Vault API
  user <- user
  ###Password to login to Vault with username
  pass_list <- list(password = pass)
  ###Pastes the url and path and creates the path through /v1/auth/userpass/login/username
  ###Removed the reference to port :8200
  complete_url<- paste0(url,'/v1/auth/userpass/login/',user)
  print(complete_url)
  ###POST the username and password to retrieve a token for the user to work with Vault
  res <- httr::POST(complete_url, body = pass_list, encode = "json",httr::verbose())
  ###Retrieve the token and other information from the Vault server API
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  return(results$auth)
}

