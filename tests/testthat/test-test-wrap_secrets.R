library(testthat)
library(httr)
library(jsonlite)

# Define the wrap_secrets function
wrap_secrets <- function(url=NULL, token=NULL, secrets_to_wrap=NULL, ttl='30m'){
  ###url of the Hashicorp Vault instance
  url <- url
  ###Time to Live for the wrap token that is returned from Vault
  ttl <- ttl
  ###Secrets to be wrap in Vault.
  data_to_wrap <- jsonlite::toJSON(secrets_to_wrap)
  ###Pastes the url and the wrap path in Vault
  complete_url <- paste0(url, ':8200/v1/sys/wrapping/wrap')
  print(complete_url)
  ###Posts the data for a return of the wrap token to unwrap the secrets from Vault
  res <- httr::POST(complete_url, httr::add_headers('X-Vault-Token' = token, "X-Vault-Wrap-TTL" = ttl), body = data_to_wrap, encode = "json", httr::verbose())
  ###Get the token that was used to wrap the secrets in Vault
  results <- jsonlite::fromJSON(httr::content(x = res, type = "text", encoding = "UTF-8"))
  ###Returns the wrap token used in the unwrap portion of Vault
  return(results$wrap_info$token)
}

# Example test for the wrap_secrets function
test_that("wrap_secrets prints the correct URL", {
  url <- "http://127.0.0.1"
  token <- "example-token"
  secrets_to_wrap <- list(secret1 = "value1", secret2 = "value2")
  ttl <- '30m'
  
  expect_output(wrap_secrets(url = url, token = token, secrets_to_wrap = secrets_to_wrap, ttl = ttl),
                paste0(url, ':8200/v1/sys/wrapping/wrap'))
})
