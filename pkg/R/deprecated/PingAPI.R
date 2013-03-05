PingAPI <- function(MyKey) {
  web <- "http://eol.org/api/ping.json"
  curl.call <- paste(web, "?key=", MyKey, sep="")
  suppressWarnings(fromJSON(file=curl.call))$response$message
}