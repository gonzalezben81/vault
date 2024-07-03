get_user_token <- function(url,user,pass){
  ###url of the HashiCorp Vault instance
  url <- url
  ###Path to the HashiCorp Vault User Verification Path
  user <- user
  ###Secrets to be written to Vault.
  pass_list <- list(password = pass)
  ###Pastes the url and path and creates the path through /v1/secret/
  ###Removed the reference to port :8200
  complete_url<- paste0(url,'/v1/auth/userpass/login/',user)
  print(complete_url)
  ###Puts the data into the HashiCorp Vault path.
  res <- httr::POST(complete_url, body = pass_list, encode = "json",httr::verbose())
  ###If the status returned is 204 return the following message else return an error message
  results<- jsonlite::fromJSON(httr::content(x = res,type = "text",encoding = "UTF-8"))
  return(results$auth)
}


# Example test for the post_vault_data function
test_that("get_user_token gets a user token", {
  url <- "https://127.0.0.1"
  user <- "test"
  pass <- "test"
  
  results <- get_user_token(url = url, user = user, pass = pass)
  results_one <- get_user_token(url = url, user = user, pass = pass)
  expect_equal( print(results$client_token),
                results_one$client_token,ignore_attr = TRUE)
  

})
