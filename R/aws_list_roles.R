#aws_list_roles
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
#' Vault: Lists/Gets the AWS role present in your Vault instance.
#'
#' This function lists the AWS roles present in your Vault instance. 
#'
#' @references [Vault AWS LIST Roles Documentation](https://developer.hashicorp.com/vault/api-docs/v1.16.x/auth/aws#list-roles) <br/>
#' [HTTR Package VERB Function](https://httr.r-lib.org/reference/VERB.html) <br/>
#' <a href="https://www.r-project.org/" target="_blank">Open R Project in a new tab</a>
#' @param url URL of the HashiCorp Vault instance.
#' @param token token from user/github/approle/etc.... registered in Vault.
#' @keywords aws_list_roles
#' @return Return's a list of aws roles present in your Vault instance. 
#' @name aws_list_roles
#' @title aws_list_roles
#' @import httr
#' @import jsonlite
#' @examples
#'
#' \dontrun{
#' aws_list_roles(url="vault-url.com",token=token)
#'
#' }
#'
#' @export


aws_list_roles <- function(url=NULL,token=NULL){
  ###url of Vault instance
  url <- url
  ###Token from Vault user/github/approle/etc...
  token <- token
  ####Paste together Vault url using the sprintf() function
  complete_url <- sprintf('%s/v1/auth/aws/roles',url)
  ###Gets the data from the HashiCorp Vault path
  ###Create the LIST verb that is expected by the HashiCorp Vault API
  res<- VERB(verb = "LIST",url = complete_url, httr::add_headers('X-Vault-Token' = token))
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  print(results$data$keys)
  
}



