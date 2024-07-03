#aws_rotate_root_creds
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
#' Vault: Rotates the root credentials used in AWS by Vault.
#'
#' This function rotates the root IAM User credentials used in AWS by Vault. 
#'
#' @param url URL of the HashiCorp Vault instance.
#' @param token token (preferrably) the root token to rotate the AWS credentials being used by Vault.
#' @keywords aws_rotate_root_creds
#' @return Return's the access key that has been rotated in AWS.
#' @name aws_rotate_root_creds
#' @title aws_rotate_root_creds
#' @import httr
#' @import jsonlite
#' @examples
#'
#' \dontrun{  aws_rotate_root_creds(url,token)
#'
#' }
#'
#' @export


aws_rotate_root_creds <- function(url=NULL,token=NULL){
  ###url of Vault instance
  url <- url
  ###Token from Vault user/github/approle/etc...preferrably the root token to rotate
  ###the AWS credentials
  token <- token
  ####Paste together Vault url using the sprintf() function
  complete_url <- sprintf('%s/v1/aws/config/rotate-root',url)
  ###Gets the list of AWS roles registered in Vault
  res<- httr::POST(url = complete_url, httr::add_headers('X-Vault-Token' = token))
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  print(results)
  
}

