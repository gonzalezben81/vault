% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrap_secrets.R
\name{wrap_secrets}
\alias{wrap_secrets}
\title{wrap_secrets}
\usage{
wrap_secrets(url = NULL, token = NULL, secrets_to_wrap = NULL, ttl = "30m")
}
\arguments{
\item{url}{URL of the HashiCorp Vault instance.}

\item{token}{The token used to wrap the secrets in Vault via the wrapping utility.}

\item{secrets_to_wrap}{The secrets you want to wrap via the Vault wrapping utility.}

\item{ttl}{Time to live or ttl, refers to the time a token is able to be used to unwrap the wrapped secrets in Vault.}
}
\value{
Return's the wrap token that is used to unwrap the secrets in Vault.
}
\description{
Vault: Gets the approle token from Vault.
}
\details{
This function wraps secrets via the wrap endpoint in Vault. The function returns a single use token that can be utilized once to retrieve the secrets.
}
\examples{

\dontrun{  wrap_secrets(url,token,secrets_to_wrap,ttl)

}

}
\references{
\href{https://developer.HashiCorp.com/vault/api-docs/system/wrapping-wrap}{Vault Wrap Token API}\if{html}{\out{<br/>}}
\href{https://developer.HashiCorp.com/vault/docs/concepts/response-wrapping}{Vault Wrapping Overview}
}
\keyword{get_approle_token}
