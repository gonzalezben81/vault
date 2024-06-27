get_user_token <- function(url,user,pass){
  ###url of the Hashicorp Vault instance
  url <- url
  ###Path to the Hashicorp Vault User Verification Path
  user <- user
  ###Secrets to be written to Vault.
  secrets <- list(username=user,password=pass)
  data_to_insert<- jsonlite::toJSON(secrets)
  ###Pastes the url and path and creates the path through /v1/secret/
  complete_url<- paste0(url,':8200/v1/auth/userpass/login/',user)
  ###Puts the data into the Hashicorp Vault path.
  res <- httr::PUT(complete_url, body = data_to_insert, encode = "json",httr::verbose())
  ###If the status returned is 204 return the following message else return an error message
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  return(results$auth)
}