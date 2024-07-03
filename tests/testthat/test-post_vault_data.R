library(testthat)
library(httr)
library(jsonlite)

# Define the post_vault_data function
post_vault_data <- function(url=NULL, path=NULL, token=NULL, secrets=NULL){
  ###url of the HashiCorp Vault instance
  url <- url
  ###Token from the HashiCorp Vault user
  token <- token
  ###Path to the HashiCorp Vault secrets
  path <- path
  ###Secrets to be written to Vault.
  data_to_insert <- jsonlite::toJSON(secrets)
  ###Pastes the url and path and creates the path through /v1/secret/
  complete_url <- paste0(url, ':8200/v1/secret/', path)
  print(complete_url)
  ###Puts the data into the HashiCorp Vault path.
  res <- httr::PUT(complete_url, httr::add_headers('X-Vault-Token' = token), body = data_to_insert, encode = "json", httr::verbose())
  
  ###If the status returned is 204 return the following message else return an error message
  if(res$status_code == 204){
    message(paste0("Data successfully written to ", path))
  } else {
    message(paste0("Error saving data to ", path))
  }
  return(res)
}

# Example test for the post_vault_data function
test_that("post_vault_data prints the correct URL", {
  url <- "http://127.0.0.1"
  path <- "example-path"
  token <- "example-token"
  secrets <- list(secret1 = "value1", secret2 = "value2")
  
  
  expect_output(post_vault_data(url = url, path = path, token = token, secrets = secrets),
                paste0(url, ':8200/v1/secret/', path))
  

  
  expect_output(post_vault_data(url = url, path = path, token = token, secrets = secrets),
                paste0(url, ':8200/v1/secret/', path))
})
