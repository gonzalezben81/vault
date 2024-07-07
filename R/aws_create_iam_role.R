#aws_create_iam_role
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
#' Vault: Creates the Vault AWS IAM role to interact with the IAM role in your AWS account.
#'
#' This function creates the Vault AWS IAM Role and associates it with the IAM Role that has already been created in AWS. 
#'
#' @references [Vault AWS Create Role Documentation](https://developer.hashicorp.com/vault/api-docs/v1.16.x/auth/aws#create-update-role) <br/>
#' @param url URL of the HashiCorp Vault instance.
#' @param token token from user/github/approle/etc.... registered in Vault.
#' @param role_name name of the role you are creating.
#' @param auth_type authentication type for the role you are creating e.g. iam.
#' @param bound_iam_principal_arn arn of the iam role that you created in AWS.
#' @param policies policy or a list of policies in Vault to associate the IAM role with.
#' @keywords aws_create_iam_role
#' @return Return's a list of aws roles present in your Vault instance. 
#' @name aws_create_iam_role
#' @title aws_create_iam_role
#' @import httr
#' @import jsonlite
#' @md
#' @examples
#' \dontrun{
#' aws_create_iam_role(url=NULL,token=NULL,auth_type="iam",role_name=NULL,bound_iam_principal_arn=NULL,policies=NULL)
#'
#' }
#'
#' @export


aws_create_iam_role <- function(url=NULL,token=NULL,auth_type="iam",role_name=NULL,bound_iam_principal_arn=NULL,policies=NULL){
  ###url of Vault instance
  url <- url
  ###Token from Vault user/github/approle/etc...
  token <- token
  data_to_insert <- list(role_name,auth_type,bound_iam_principal_arn,policies)
  #data_to_insert<- jsonlite::toJSON(secrets)  
  ####Paste together Vault url using the sprintf() function
  complete_url <- sprintf('%s/v1/auth/aws/role/%s',url,role_name)
  ###Gets the data from the HashiCorp Vault path
  ###Create the LIST verb that is expected by the HashiCorp Vault API
  res <- httr::PUT(complete_url,httr::add_headers('X-Vault-Token' = token), body = data_to_insert, encode = "json",httr::verbose())
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  print(results)
  
}



